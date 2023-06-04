//
//  TriangleBubbleBuilder.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/3.
//

import UIKit

class TriangleBubblePopupBuilder: BubblePopupBuilder {
    private let popupPoint: CGPoint
    
    lazy var targetPoint: CGPoint = {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }){
            let targetPoint = window.convert(popupPoint, to: getBubblePopup())
            return targetPoint
        }
        return CGPoint.zero
    }()
    
    init(tips: String?, customContentView: UIView? = nil, maxWidth: Double, popupPoint: CGPoint) {
        self.popupPoint = popupPoint
        super.init(tips: tips, customContentView: customContentView, maxWidth: maxWidth)
        
    }
    
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
    func getTriangleViewFrame(position: BubblePopupPositionType, targetPoint:CGPoint) -> CGRect {
        switch position {
        case .top:
            return CGRect(x: targetPoint.x-triangleDistance.width/2, y: 0, width: triangleDistance.width, height: triangleDistance.length)
        case .bottom:
            return CGRect(x: targetPoint.x-triangleDistance.width/2, y: targetPoint.y-triangleDistance.length, width: triangleDistance.width, height: triangleDistance.length)
        case .left:
            return CGRect(x: 0, y: targetPoint.y-triangleDistance.width/2, width: triangleDistance.length, height: triangleDistance.width)
        case .right:
            return CGRect(x: targetPoint.x-triangleDistance.length, y:targetPoint.y-triangleDistance.width/2 , width: triangleDistance.length, height: triangleDistance.width)
        }
    }
    
    func layoutTriangleBubblePopupView(bubblePopup: BubblePopup, positionType: BubblePopupPositionType) {
        guard let contentViewSub = bubblePopup.bubbleContentView else { return }
        guard let bubbleBGViewSub = bubblePopup.bubbleBGView else { return }

        
        switch positionType {
        case .top:
            let pY = popupPoint.y
            let pMaxX = popupPoint.x+bubblePopup.frame.width/2
            var pMinX = popupPoint.x-bubblePopup.frame.width/2
            if pMaxX > UIScreen.main.bounds.width {
                pMinX = pMinX - (pMaxX-UIScreen.main.bounds.width)
            } else if pMinX < 0 {
                pMinX = 0
            }
 
            bubblePopup.frame.origin = CGPoint(x: pMinX, y: pY)
             
            bubblePopup.frame.size = CGSize(width: contentViewSub.frame.width, height: contentViewSub.frame.height+triangleDistance.length)
            
            
        case .bottom:
            let pY = popupPoint.y-triangleDistance.length-bubblePopup.frame.height
            let pMaxX = popupPoint.x+bubblePopup.frame.width/2
            var pMinX = popupPoint.x-bubblePopup.frame.width/2
            if pMaxX > UIScreen.main.bounds.width {
                pMinX = pMinX - (pMaxX-UIScreen.main.bounds.width)
            } else if pMinX < 0 {
                pMinX = 0
            }
 
            bubblePopup.frame.origin = CGPoint(x: pMinX, y: pY)
             
            bubblePopup.frame.size = CGSize(width: contentViewSub.frame.width, height: contentViewSub.frame.height+triangleDistance.length)
        case .left:
            let pY = popupPoint.y-bubblePopup.frame.height/2
//            let pMaxX = popupPoint.x+self.frame.width+triangleDistance.length
            let pMinX = popupPoint.x
 
            bubblePopup.frame.origin = CGPoint(x: pMinX, y: pY)
             
            bubblePopup.frame.size = CGSize(width: contentViewSub.frame.width+triangleDistance.length, height: contentViewSub.frame.height)
        case .right:
            let pY = popupPoint.y-bubblePopup.frame.height/2
//            let pMaxX = popupPoint.x
            let pMinX = popupPoint.x-triangleDistance.length-bubblePopup.frame.width
            bubblePopup.frame.origin = CGPoint(x: pMinX, y: pY)
             
            bubblePopup.frame.size = CGSize(width: contentViewSub.frame.width+triangleDistance.length, height: contentViewSub.frame.height)
        }
        updateTriangleBGBubbleView(position: positionType, bgBubbleView: bubbleBGViewSub)
        bubblePopup.bubbleContentView?.frame = bubbleBGViewSub.frame
    }
     
    // 更新气泡视图的坐标
    func updateTriangleBGBubbleView(position: BubblePopupPositionType, bgBubbleView: UIView) {
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
    }

}

class TriangleTopBubblePopupBuilder: TriangleBubblePopupBuilder {
    override func updateLayout(to bubblePopup: BubblePopup) {
        layoutTriangleBubblePopupView(bubblePopup: bubblePopup, positionType: .top)
    }
    override func addBubbleFlagView(to bubblePopup: BubblePopup) {
        assert(!self.targetPoint.equalTo(.zero), "气泡提示点无效")
        
        let flagFrame = getTriangleViewFrame(position: .top, targetPoint: self.targetPoint)
        let params = getTriangleRectParams(position: .top)
        let flagBubbleView = BubbleViewFactory.generateTriangleBubbleFlagView(flagFrame: flagFrame, position: .top, params: params)
        bubblePopup.bubbleFlagView = flagBubbleView
        bubblePopup.addSubview(flagBubbleView)
    }
}

class TriangleBottomBubblePopupBuilder: TriangleBubblePopupBuilder {
    override func updateLayout(to bubblePopup: BubblePopup) {
        layoutTriangleBubblePopupView(bubblePopup: bubblePopup, positionType: .bottom)
    }
    override func addBubbleFlagView(to bubblePopup: BubblePopup) {
        assert(!self.targetPoint.equalTo(.zero), "气泡提示点无效")
        
        let flagFrame = getTriangleViewFrame(position: .bottom, targetPoint: self.targetPoint)
        let params = getTriangleRectParams(position: .bottom)
        let flagBubbleView = BubbleViewFactory.generateTriangleBubbleFlagView(flagFrame: flagFrame, position: .bottom, params: params)
        bubblePopup.bubbleFlagView = flagBubbleView
        bubblePopup.addSubview(flagBubbleView)
    }
}

class TriangleLeftBubblePopupBuilder: TriangleBubblePopupBuilder {
    override func updateLayout(to bubblePopup: BubblePopup) {
        layoutTriangleBubblePopupView(bubblePopup: bubblePopup, positionType: .left)
    }
    override func addBubbleFlagView(to bubblePopup: BubblePopup) {
        assert(!self.targetPoint.equalTo(.zero), "气泡提示点无效")
        
        let flagFrame = getTriangleViewFrame(position: .left, targetPoint: self.targetPoint)
        let params = getTriangleRectParams(position: .left)
        let flagBubbleView = BubbleViewFactory.generateTriangleBubbleFlagView(flagFrame: flagFrame, position: .left, params: params)
        bubblePopup.bubbleFlagView = flagBubbleView
        bubblePopup.addSubview(flagBubbleView)
    }
}

class TriangleRightBubblePopupBuilder: TriangleBubblePopupBuilder {
    override func updateLayout(to bubblePopup: BubblePopup) {
        layoutTriangleBubblePopupView(bubblePopup: bubblePopup, positionType: .right)
    }
    override func addBubbleFlagView(to bubblePopup: BubblePopup) {
        assert(!self.targetPoint.equalTo(.zero), "气泡提示点无效")
        
        let flagFrame = getTriangleViewFrame(position: .right, targetPoint: self.targetPoint)
        let params = getTriangleRectParams(position: .right)
        let flagBubbleView = BubbleViewFactory.generateTriangleBubbleFlagView(flagFrame: flagFrame, position: .right, params: params)
        bubblePopup.bubbleFlagView = flagBubbleView
        bubblePopup.addSubview(flagBubbleView)
    }
}

