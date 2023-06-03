//
//  BubblePopup.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/2.
//

import UIKit
 
enum BubblePopupType {
    // 虚线
    case dotLine
    // 三角形
    case triangle
}
 
enum BubblePopupPositionType {
    case top
    case bottom
    case left
    case right
}
 
struct DotLineRect {
    let x:Double;
    let y:Double;
    let width:Double;
    let length:Double; //代表linkPoint与气泡连线的长度
     
    func startPoint(position:BubblePopupPositionType) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    func endPoint(position:BubblePopupPositionType) -> CGPoint {
        switch position {
        case .top,.bottom:
            return CGPoint(x: x, y: length+y)
        case .left,.right:
            return CGPoint(x: x+length, y: y)
        }
    }
}
 
struct BubbleDistance {
    let width:Double;  //宽度
    let length:Double; //代表point与气泡连线的长度
}
 
class BubblePopup: UIView {
    private let tips: String?
    private let type: BubblePopupType
    private let positionType: BubblePopupPositionType
    private let maxWidth: Double
    private var contentView: UIView?
    private var bgBubbleView = UIView()
    // 三角形
    private let popupPoint: CGPoint
    // 虚线
    private let linkPoint: CGPoint
    private let dotlineSize = CGSize(width: 2, height: 35.0)
    private let triangleDistance = BubbleDistance(width: 10, length: 10)
    let dotBottomCirleWidth = 10.0
    let dotTopCirleWidth = 6.0
     
     
     
     
    // MARK: - Life Cycle
    init(tips: String? = nil, customContentView: UIView? = nil, type: BubblePopupType, positionType: BubblePopupPositionType, popupPoint: CGPoint, linkPoint: CGPoint, maxWidth: Double) {
        self.tips = tips
        self.type = type
        self.positionType = positionType
        self.popupPoint = popupPoint
        self.linkPoint = linkPoint
        self.maxWidth = maxWidth
        self.contentView = customContentView;
        super.init(frame: .zero)
         
        if let tipsSub = tips {
            contentView = TextContentView(tips: tipsSub, maxWidth: maxWidth)
            self.frame.size = contentView!.frame.size
            self.addSubview(contentView!)
        }
        setupUI()
    }
     
    convenience init(tips: String, dotLinePositionType: BubblePopupPositionType, linkPoint: CGPoint, maxWidth: Double) {
        self.init(tips: tips, type: .dotLine, positionType: dotLinePositionType, popupPoint: .zero, linkPoint: linkPoint, maxWidth: maxWidth)
    }
     
    convenience init(tips: String, trianglePositionType: BubblePopupPositionType, popupPoint: CGPoint, maxWidth: Double) {
        self.init(tips: tips, type: .triangle, positionType: trianglePositionType, popupPoint: popupPoint, linkPoint: .zero, maxWidth: maxWidth)
    }
     
    convenience init(customContentView: UIView, dotLinePositionType: BubblePopupPositionType, linkPoint: CGPoint, maxWidth: Double) {
        self.init(customContentView: customContentView, type: .dotLine, positionType: dotLinePositionType, popupPoint: .zero, linkPoint: linkPoint, maxWidth: maxWidth)
    }
     
    convenience init(customContentView: UIView, trianglePositionType: BubblePopupPositionType, popupPoint: CGPoint, maxWidth: Double) {
        self.init(customContentView: customContentView, type: .triangle, positionType: trianglePositionType, popupPoint: popupPoint, linkPoint: .zero, maxWidth: maxWidth)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    deinit {
         
    }
     
 
    // MARK: - Private Method
    func setupUI() {
        setupBaseView()
         
        switch type {
        case .dotLine:
            setupDotLineView()
        case .triangle:
            setupTriangleView()
        }
    }
     
    func setupBaseView() {
        bgBubbleView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        insertSubview(bgBubbleView, at: 0)
         
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bgBubbleView.frame.width, height: bgBubbleView.frame.height)
        gradientLayer.colors = [UIColor.yellow.cgColor,
                                UIColor.brown.cgColor].compactMap({ $0 })
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        bgBubbleView.layer.insertSublayer(gradientLayer, at: 0)
        bgBubbleView.layer.cornerRadius = 8
        bgBubbleView.layer.masksToBounds = true
    }
     
    func setupDotLineView() {
        switch positionType {
        case .top:
            let pY = linkPoint.y-dotBottomCirleWidth/2
            let pMaxX = linkPoint.x+self.frame.width/2
            var pMinX = linkPoint.x-self.frame.width/2
            if pMaxX > UIScreen.main.bounds.width {
                pMinX = pMinX - (pMaxX-UIScreen.main.bounds.width)
            } else if pMinX < 0 {
                pMinX = 0
            }
 
            self.frame.origin = CGPoint(x: pMinX, y: pY)
             
            self.frame.size = CGSize(width: (contentView?.frame.width)!, height: (contentView?.frame.height)!+dotlineSize.height)
            drawDotLine(position: .top)
        case .bottom:
            let pY = linkPoint.y-dotlineSize.height-self.frame.height+dotBottomCirleWidth/2
            let pMaxX = linkPoint.x+self.frame.width/2
            var pMinX = linkPoint.x-self.frame.width/2
            if pMaxX > UIScreen.main.bounds.width {
                pMinX = pMinX - (pMaxX-UIScreen.main.bounds.width)
            } else if pMinX < 0 {
                pMinX = 0
            }
 
            self.frame.origin = CGPoint(x: pMinX, y: pY)
             
            self.frame.size = CGSize(width: (contentView?.frame.width)!, height: (contentView?.frame.height)!+dotlineSize.height)
            drawDotLine(position: .bottom)
        case .left:
            let pY = linkPoint.y-self.frame.height/2
            let pMinX = linkPoint.x-dotBottomCirleWidth/2
 
            self.frame.origin = CGPoint(x: pMinX, y: pY)
            self.frame.size = CGSize(width: (contentView?.frame.width)!+dotlineSize.height, height: (contentView?.frame.height)!)
            drawDotLine(position: .left)
        case .right:
            let pY = linkPoint.y-self.frame.height/2
            let pMinX = linkPoint.x-self.frame.width-dotlineSize.height+dotBottomCirleWidth/2
 
            self.frame.origin = CGPoint(x: pMinX, y: pY)
            self.frame.size = CGSize(width: (contentView?.frame.width)!+dotlineSize.height, height: (contentView?.frame.height)!)
            drawDotLine(position: .right)
        }
        updateBGBubbleView(position: positionType)
    }
     
    func setupTriangleView() {
        switch positionType {
        case .top:
            let pY = popupPoint.y
            let pMaxX = popupPoint.x+self.frame.width/2
            var pMinX = popupPoint.x-self.frame.width/2
            if pMaxX > UIScreen.main.bounds.width {
                pMinX = pMinX - (pMaxX-UIScreen.main.bounds.width)
            } else if pMinX < 0 {
                pMinX = 0
            }
 
            self.frame.origin = CGPoint(x: pMinX, y: pY)
             
            self.frame.size = CGSize(width: (contentView?.frame.width)!, height: (contentView?.frame.height)!+triangleDistance.length)
            drawTriangle(position: .top)
        case .bottom:
            let pY = popupPoint.y-triangleDistance.length-self.frame.height
            let pMaxX = popupPoint.x+self.frame.width/2
            var pMinX = popupPoint.x-self.frame.width/2
            if pMaxX > UIScreen.main.bounds.width {
                pMinX = pMinX - (pMaxX-UIScreen.main.bounds.width)
            } else if pMinX < 0 {
                pMinX = 0
            }
 
            self.frame.origin = CGPoint(x: pMinX, y: pY)
             
            self.frame.size = CGSize(width: (contentView?.frame.width)!, height: (contentView?.frame.height)!+triangleDistance.length)
            drawTriangle(position: .bottom)
        case .left:
            let pY = popupPoint.y-self.frame.height/2
//            let pMaxX = popupPoint.x+self.frame.width+triangleDistance.length
            let pMinX = popupPoint.x
 
            self.frame.origin = CGPoint(x: pMinX, y: pY)
             
            self.frame.size = CGSize(width: (contentView?.frame.width)!+triangleDistance.length, height: (contentView?.frame.height)!)
            drawTriangle(position: .left)
        case .right:
            let pY = popupPoint.y-self.frame.height/2
//            let pMaxX = popupPoint.x
            let pMinX = popupPoint.x-triangleDistance.length-self.frame.width
            self.frame.origin = CGPoint(x: pMinX, y: pY)
             
            self.frame.size = CGSize(width: (contentView?.frame.width)!+triangleDistance.length, height: (contentView?.frame.height)!)
            drawTriangle(position: .right)
        }
        updateTriangleBGBubbleView(position: positionType)
    }
 
    // MARK: - Public Method
     
    // MARK: - Event
 
}
 
extension BubblePopup {
    // 获取DotLine绘制坐标
    func getDotLineRectParams(position: BubblePopupPositionType, dotView: UIView) -> (dotLine:DotLineRect, dotBottomCirle:CGRect, dotTopCirle:CGRect) {
        switch position {
        case .top:
            let dotLineRect = DotLineRect(x: dotBottomCirleWidth/2, y: dotBottomCirleWidth, width: dotlineSize.width, length: dotlineSize.height-dotBottomCirleWidth)
            let dotBottomCirleRect = CGRect(x: 0, y: 0, width: dotBottomCirleWidth, height: dotBottomCirleWidth)
            let dotTopCirleRect = CGRect(x: (dotBottomCirleWidth-dotTopCirleWidth)/2, y: (dotBottomCirleWidth-dotTopCirleWidth)/2, width: dotTopCirleWidth, height: dotTopCirleWidth)
            return (dotLine:dotLineRect, dotBottomCirle:dotBottomCirleRect, dotTopCirle:dotTopCirleRect)
        case .bottom:
            let dotLineRect = DotLineRect(x: dotBottomCirleWidth/2, y: 0, width: dotlineSize.width, length: dotlineSize.height-dotBottomCirleWidth)
            let dotBottomCirleRect = CGRect(x: 0, y: dotlineSize.height-dotBottomCirleWidth, width: dotBottomCirleWidth, height: dotBottomCirleWidth)
            let dotTopCirleRect = CGRect(x: (dotBottomCirleWidth-dotTopCirleWidth)/2, y: dotBottomCirleRect.minY+(dotBottomCirleWidth-dotTopCirleWidth)/2, width: dotTopCirleWidth, height: dotTopCirleWidth)
            return (dotLine:dotLineRect, dotBottomCirle:dotBottomCirleRect, dotTopCirle:dotTopCirleRect)
        case .left:
            let dotLineRect = DotLineRect(x: dotBottomCirleWidth, y: dotBottomCirleWidth/2, width: dotlineSize.width, length: dotlineSize.height-dotBottomCirleWidth)
            let dotBottomCirleRect = CGRect(x: 0, y: 0, width: dotBottomCirleWidth, height: dotBottomCirleWidth)
            let dotTopCirleRect = CGRect(x: (dotBottomCirleWidth-dotTopCirleWidth)/2, y: (dotBottomCirleWidth-dotTopCirleWidth)/2, width: dotTopCirleWidth, height: dotTopCirleWidth)
            return (dotLine:dotLineRect, dotBottomCirle:dotBottomCirleRect, dotTopCirle:dotTopCirleRect)
        case .right:
            let dotLineRect = DotLineRect(x: 0, y: dotBottomCirleWidth/2, width: dotlineSize.width, length: dotlineSize.height-dotBottomCirleWidth)
            let dotBottomCirleRect = CGRect(x: dotlineSize.height-dotBottomCirleWidth, y: 0, width: dotBottomCirleWidth, height: dotBottomCirleWidth)
            let dotTopCirleRect = CGRect(x: dotBottomCirleRect.minX+(dotBottomCirleWidth-dotTopCirleWidth)/2, y: (dotBottomCirleWidth-dotTopCirleWidth)/2, width: dotTopCirleWidth, height: dotTopCirleWidth)
            return (dotLine:dotLineRect, dotBottomCirle:dotBottomCirleRect, dotTopCirle:dotTopCirleRect)
        }
    }
    // 更新DotLine图层父视图的坐标
    func updateDotView(dotView: UIView, position: BubblePopupPositionType, targetPoint:CGPoint) {
        switch position {
        case .top:
            dotView.frame = CGRect(x: targetPoint.x-dotBottomCirleWidth/2, y: 0, width: dotBottomCirleWidth, height: dotlineSize.height)
        case .bottom:
            dotView.frame = CGRect(x: targetPoint.x-dotBottomCirleWidth/2, y: bgBubbleView.frame.maxY, width: dotBottomCirleWidth, height: dotlineSize.height)
        case .left:
            dotView.frame = CGRect(x: 0, y:targetPoint.y-dotBottomCirleWidth/2 , width: dotlineSize.height, height: dotBottomCirleWidth)
        case .right:
            dotView.frame = CGRect(x: bgBubbleView.frame.maxX, y:targetPoint.y-dotBottomCirleWidth/2 , width: dotlineSize.height, height: dotBottomCirleWidth)
        }
    }
    // 更新气泡视图的坐标
    func updateBGBubbleView(position: BubblePopupPositionType) {
        switch position {
        case .top:
            bgBubbleView.frame.origin = CGPoint(x: 0, y: self.frame.height-bgBubbleView.frame.height)
        case .bottom:
            bgBubbleView.frame.origin = CGPoint(x: 0, y: 0)
        case .left:
            bgBubbleView.frame.origin = CGPoint(x: dotlineSize.height, y: 0)
        case .right:
            bgBubbleView.frame.origin = CGPoint(x: 0, y: 0)
        }
        contentView?.frame = bgBubbleView.frame
    }
    // 绘制DotLine
    func drawDotLine(position: BubblePopupPositionType) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }){
            let targetPoint = window.convert(linkPoint, to: self)
            let dotView = UIView(frame: .zero)
            updateDotView(dotView: dotView, position: position, targetPoint: targetPoint)
            addSubview(dotView)
             
            let params = getDotLineRectParams(position: position, dotView: dotView)
            let dotColor = UIColor.brown
             
            let dotLineLayer = CAShapeLayer()
            dotLineLayer.frame = dotView.bounds
            let dotLinePath = UIBezierPath()
            dotLinePath.move(to: params.dotLine.startPoint(position: position))
            dotLinePath.addLine(to: params.dotLine.endPoint(position: position))
            dotLineLayer.path = dotLinePath.cgPath
            dotLineLayer.strokeColor = dotColor.cgColor
            dotLineLayer.lineWidth = dotlineSize.width
            let dashes: [NSNumber] = [4] // 虚线的样式
            dotLineLayer.lineDashPattern = dashes
            dotView.layer.addSublayer(dotLineLayer)
             
            let bottomCircleLayer = CAShapeLayer()
            bottomCircleLayer.frame = dotView.bounds
            let bottomCirclePath = UIBezierPath(ovalIn: params.dotBottomCirle)
            bottomCircleLayer.path = bottomCirclePath.cgPath
            bottomCircleLayer.fillColor = dotColor.withAlphaComponent(0.3).cgColor
            dotView.layer.addSublayer(bottomCircleLayer)
             
            let topCircleLayer = CAShapeLayer()
            topCircleLayer.frame = dotView.bounds
            let topCirclePath = UIBezierPath(ovalIn: params.dotTopCirle)
            topCircleLayer.path = topCirclePath.cgPath
            topCircleLayer.fillColor = dotColor.cgColor
            dotView.layer.addSublayer(topCircleLayer)
        }
    }
 
}
 
extension BubblePopup {
    // 获取DotLine绘制坐标
    func getTriangleRectParams(position: BubblePopupPositionType) -> (startPoint: CGPoint, point1: CGPoint, endPoint: CGPoint) {
        switch position {
        case .top:
            let point0 = CGPoint(x: 0, y: triangleDistance.length)
            let point1 = CGPoint(x: triangleDistance.width/2, y: 0)
            let point2 = CGPoint(x: triangleDistance.width, y: triangleDistance.length)
            return (startPoint: point0, point1: point1, endPoint: point2)
        case .bottom:
            let point0 = CGPoint(x: 0, y: 0)
            let point1 = CGPoint(x: triangleDistance.width/2, y: triangleDistance.length)
            let point2 = CGPoint(x: triangleDistance.width, y: 0)
            return (startPoint: point0, point1: point1, endPoint: point2)
        case .left:
            let point0 = CGPoint(x: triangleDistance.width, y: 0)
            let point1 = CGPoint(x: 0, y: triangleDistance.length/2)
            let point2 = CGPoint(x: triangleDistance.width, y: triangleDistance.length)
            return (startPoint: point0, point1: point1, endPoint: point2)
        case .right:
            let point0 = CGPoint(x: 0, y: 0)
            let point1 = CGPoint(x: triangleDistance.width, y: triangleDistance.length/2)
            let point2 = CGPoint(x: 0, y: triangleDistance.length)
            return (startPoint: point0, point1: point1, endPoint: point2)
        }
         
    }
     
    // 更新DotLine图层父视图的坐标
    func updateTriangleView(triangleView: UIView, position: BubblePopupPositionType, targetPoint:CGPoint) {
        switch position {
        case .top:
            triangleView.frame = CGRect(x: targetPoint.x-triangleDistance.width/2, y: 0, width: triangleDistance.width, height: triangleDistance.length)
        case .bottom:
            triangleView.frame = CGRect(x: targetPoint.x-triangleDistance.width/2, y: bgBubbleView.frame.maxY, width: triangleDistance.width, height: triangleDistance.length)
        case .left:
            triangleView.frame = CGRect(x: 0, y: targetPoint.y-triangleDistance.width/2, width: triangleDistance.length, height: triangleDistance.width)
        case .right:
            triangleView.frame = CGRect(x: bgBubbleView.frame.maxX, y:targetPoint.y-triangleDistance.width/2 , width: triangleDistance.length, height: triangleDistance.width)
        }
    }
     
    // 更新气泡视图的坐标
    func updateTriangleBGBubbleView(position: BubblePopupPositionType) {
        switch position {
        case .top:
            bgBubbleView.frame.origin = CGPoint(x: 0, y: triangleDistance.length)
        case .bottom:
            bgBubbleView.frame.origin = CGPoint(x: 0, y: 0)
        case .left:
            bgBubbleView.frame.origin = CGPoint(x: triangleDistance.length, y: 0)
        case .right:
            bgBubbleView.frame.origin = CGPoint(x: 0, y: 0)
        }
        contentView?.frame = bgBubbleView.frame
    }
     
    func drawTriangle(position: BubblePopupPositionType) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }){
            let targetPoint = window.convert(popupPoint, to: self)
            let triangleView = UIView(frame: .zero)
            updateTriangleView(triangleView: triangleView, position: position, targetPoint: targetPoint)
            addSubview(triangleView)
             
            let triangleColor = UIColor.brown
             
            let params = getTriangleRectParams(position: position)
             
            let dotLineLayer = CAShapeLayer()
            dotLineLayer.frame = triangleView.bounds
            let trianglePath = UIBezierPath()
            trianglePath.move(to: params.startPoint)
            trianglePath.addLine(to: params.point1)
            trianglePath.addLine(to: params.endPoint)
            trianglePath.close()
             
            dotLineLayer.path = trianglePath.cgPath
            dotLineLayer.fillColor = triangleColor.cgColor
            triangleView.layer.addSublayer(dotLineLayer)
 
        }
    }
}
 
 
class TextContentView: UIView {
    private let tips: String
    private let maxWidth: Double
    private let maxHeight = 95.0
    let closeButtonWidth = 20.0
    let closeButtonMargin = 5.0
    let textLabelLeft = 10.0
    let textLabelTop = 5.0
 
     
    lazy private var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 4
        return label
    }()
    lazy private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.frame.size = CGSize(width: closeButtonWidth, height: closeButtonWidth)
//        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        return button
    }()
     
    // MARK: - Life Cycle
    init(tips: String, maxWidth: Double) {
        self.tips = tips
        self.maxWidth = maxWidth
        super.init(frame: .zero)
        setupUI()
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    deinit {
         
    }
     
    // MARK: - Private Method
    func setupUI() {
        textLabel.text = tips
        let appendWidth = textLabelLeft + closeButtonMargin + closeButtonWidth
        let maxWidth = maxWidth - appendWidth
        let maxSize = CGSize(width: maxWidth, height: maxHeight)
        let attributes = [NSAttributedString.Key.font: textLabel.font!]
        let textSize = tips.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
        textLabel.frame.size = textSize
        self.frame.size = CGSize(width: textSize.width+appendWidth, height: textSize.height + 10)
         
        textLabel.frame.origin = CGPoint(x: textLabelLeft, y: textLabelTop)
        closeButton.frame.origin = CGPoint(x: self.frame.width - closeButtonMargin - closeButtonWidth, y: self.frame.height/2.0 - closeButtonWidth/2.0)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
 
 
        addSubview(textLabel)
        addSubview(closeButton)
    }
     
    @objc
    func close(sender: UIButton) {
        if self.superview != nil {
            UIView.animate(withDuration: 0.3) {
                self.superview?.alpha = 0.3
            } completion: { res in
                self.superview?.removeFromSuperview()
            }
        }
             
    }
     
    // MARK: - Public Method
     
    // MARK: - Event
     
}
