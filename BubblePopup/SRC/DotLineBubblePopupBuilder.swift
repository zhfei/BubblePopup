//
//  DotLineBubbleBuilder.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/3.
//

import UIKit

class DotLineBubblePopupBuilder: BubblePopupBuilder {
    private let linkPoint: CGPoint
    
    lazy var targetPoint: CGPoint = {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }){
            let targetPoint = window.convert(linkPoint, to: getBubblePopup())
            return targetPoint
        }
        return CGPoint.zero
    }()
    
    init(tips: String?, customContentView: UIView? = nil, maxWidth: Double, linkPoint: CGPoint) {
        self.linkPoint = linkPoint
        super.init(tips: tips, customContentView: customContentView, maxWidth: maxWidth)
        
    }
    
    
    // 获取DotLine绘制坐标
    func getDotLineRectParams(position: BubblePopupPositionType) -> (dotLine:DotLineRect, dotBottomCirle:CGRect, dotTopCirle:CGRect) {
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
    func getDotViewFrame(position: BubblePopupPositionType, targetPoint:CGPoint) -> CGRect {
        switch position {
        case .top:
            return CGRect(x: targetPoint.x-dotBottomCirleWidth/2, y: 0, width: dotBottomCirleWidth, height: dotlineSize.height)
        case .bottom:
            return CGRect(x: targetPoint.x-dotBottomCirleWidth/2, y: targetPoint.y-dotlineSize.height+dotBottomCirleWidth/2, width: dotBottomCirleWidth, height: dotlineSize.height)
        case .left:
            return CGRect(x: 0, y:targetPoint.y-dotBottomCirleWidth/2 , width: dotlineSize.height, height: dotBottomCirleWidth)
        case .right:
            return CGRect(x: targetPoint.x-dotlineSize.height+dotBottomCirleWidth/2, y:targetPoint.y-dotBottomCirleWidth/2 , width: dotlineSize.height, height: dotBottomCirleWidth)
        }
    }
    
    func layoutDotLineBubblePopupView(bubblePopup: BubblePopup, positionType: BubblePopupPositionType) {
        guard let contentViewSub = bubblePopup.bubbleContentView else { return }
        guard let bubbleBGViewSub = bubblePopup.bubbleBGView else { return }

        
        switch positionType {
        case .top:
            let pY = linkPoint.y-dotBottomCirleWidth/2
            let pMaxX = linkPoint.x+bubblePopup.frame.width/2
            var pMinX = linkPoint.x-bubblePopup.frame.width/2
            if pMaxX > UIScreen.main.bounds.width {
                pMinX = pMinX - (pMaxX-UIScreen.main.bounds.width)
            } else if pMinX < 0 {
                pMinX = 0
            }
 
            bubblePopup.frame.origin = CGPoint(x: pMinX, y: pY)
             
            bubblePopup.frame.size = CGSize(width: contentViewSub.frame.width, height: contentViewSub.frame.height+dotlineSize.height)
        case .bottom:
            let pY = linkPoint.y-dotlineSize.height-bubblePopup.frame.height+dotBottomCirleWidth/2
            let pMaxX = linkPoint.x+bubblePopup.frame.width/2
            var pMinX = linkPoint.x-bubblePopup.frame.width/2
            if pMaxX > UIScreen.main.bounds.width {
                pMinX = pMinX - (pMaxX-UIScreen.main.bounds.width)
            } else if pMinX < 0 {
                pMinX = 0
            }
 
            bubblePopup.frame.origin = CGPoint(x: pMinX, y: pY)
             
            bubblePopup.frame.size = CGSize(width: contentViewSub.frame.width, height: contentViewSub.frame.height+dotlineSize.height)
        case .left:
            let pY = linkPoint.y-bubblePopup.frame.height/2
            let pMinX = linkPoint.x-dotBottomCirleWidth/2
 
            bubblePopup.frame.origin = CGPoint(x: pMinX, y: pY)
            bubblePopup.frame.size = CGSize(width: contentViewSub.frame.width+dotlineSize.height, height: contentViewSub.frame.height)
        case .right:
            let pY = linkPoint.y-bubblePopup.frame.height/2
            let pMinX = linkPoint.x-bubblePopup.frame.width-dotlineSize.height+dotBottomCirleWidth/2
 
            bubblePopup.frame.origin = CGPoint(x: pMinX, y: pY)
            bubblePopup.frame.size = CGSize(width: contentViewSub.frame.width+dotlineSize.height, height: contentViewSub.frame.height)
        }
        updateBGBubbleView(position: positionType, bgBubbleView: bubbleBGViewSub)
        bubblePopup.bubbleContentView?.frame = bubbleBGViewSub.frame
    }
    // 更新气泡视图的坐标
    func updateBGBubbleView(position: BubblePopupPositionType, bgBubbleView: UIView) {
        switch position {
        case .top:
            bgBubbleView.frame.origin = CGPoint(x: 0, y: dotlineSize.height)
        case .bottom:
            bgBubbleView.frame.origin = CGPoint(x: 0, y: 0)
        case .left:
            bgBubbleView.frame.origin = CGPoint(x: dotlineSize.height, y: 0)
        case .right:
            bgBubbleView.frame.origin = CGPoint(x: 0, y: 0)
        }
    }
}

class DotLineTopBubblePopupBuilder: DotLineBubblePopupBuilder {
    
    override func updateLayout(to bubblePopup: BubblePopup) {
        layoutDotLineBubblePopupView(bubblePopup: bubblePopup, positionType: .top)
    }
    
    override func addBubbleFlagView(to bubblePopup: BubblePopup) {
        assert(!self.targetPoint.equalTo(.zero), "气泡提示点无效")
        
        let flagFrame = getDotViewFrame(position: .top, targetPoint: self.targetPoint)
        let params = getDotLineRectParams(position: .top)
        let flagBubbleView = BubbleViewFactory.generateDotLineBubbleFlagView(flagFrame: flagFrame, position: .top, params: params)
        bubblePopup.bubbleFlagView = flagBubbleView
        bubblePopup.addSubview(flagBubbleView)
    }
    
}

class DotLineBottomBubblePopupBuilder: DotLineBubblePopupBuilder {
    
    override func updateLayout(to bubblePopup: BubblePopup) {
        layoutDotLineBubblePopupView(bubblePopup: bubblePopup, positionType: .bottom)
    }
    
    override func addBubbleFlagView(to bubblePopup: BubblePopup) {
        assert(!self.targetPoint.equalTo(.zero), "气泡提示点无效")
        
        let flagFrame = getDotViewFrame(position: .bottom, targetPoint: self.targetPoint)
        let params = getDotLineRectParams(position: .bottom)
        let flagBubbleView = BubbleViewFactory.generateDotLineBubbleFlagView(flagFrame: flagFrame, position: .bottom, params: params)
        bubblePopup.bubbleFlagView = flagBubbleView
        bubblePopup.addSubview(flagBubbleView)
    }
    
}

class DotLineLeftBubblePopupBuilder: DotLineBubblePopupBuilder {
    
    override func updateLayout(to bubblePopup: BubblePopup) {
        layoutDotLineBubblePopupView(bubblePopup: bubblePopup, positionType: .left)
    }
    
    override func addBubbleFlagView(to bubblePopup: BubblePopup) {
        assert(!self.targetPoint.equalTo(.zero), "气泡提示点无效")
        
        let flagFrame = getDotViewFrame(position: .left, targetPoint: self.targetPoint)
        let params = getDotLineRectParams(position: .left)
        let flagBubbleView = BubbleViewFactory.generateDotLineBubbleFlagView(flagFrame: flagFrame, position: .left, params: params)
        bubblePopup.bubbleFlagView = flagBubbleView
        bubblePopup.addSubview(flagBubbleView)
    }
    
}

class DotLineRightBubblePopupBuilder: DotLineBubblePopupBuilder {
    
    override func updateLayout(to bubblePopup: BubblePopup) {
        layoutDotLineBubblePopupView(bubblePopup: bubblePopup, positionType: .right)
    }
    
    override func addBubbleFlagView(to bubblePopup: BubblePopup) {
        assert(!self.targetPoint.equalTo(.zero), "气泡提示点无效")
        
        let flagFrame = getDotViewFrame(position: .right, targetPoint: self.targetPoint)
        let params = getDotLineRectParams(position: .right)
        let flagBubbleView = BubbleViewFactory.generateDotLineBubbleFlagView(flagFrame: flagFrame, position: .right, params: params)
        bubblePopup.bubbleFlagView = flagBubbleView
        bubblePopup.addSubview(flagBubbleView)
    }
    
}
