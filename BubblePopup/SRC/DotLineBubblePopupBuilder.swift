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
    
    // 获取DotLine绘制相关坐标
    func getDrawDotLineLayerRectParams(position: BubblePopupPositionType) -> (dotLine:DotLineRect, dotBottomCirle:CGRect, dotTopCirle:CGRect) {
        switch position {
        case .top:
            let dotLineRect = DotLineRect(x: dotLineBottomCircleDiameter/2, y: dotLineBottomCircleDiameter, width: dotlineDistance.width, length: dotlineDistance.length-dotLineBottomCircleDiameter)
            let dotBottomCirleRect = CGRect(x: 0, y: 0, width: dotLineBottomCircleDiameter, height: dotLineBottomCircleDiameter)
            let dotTopCirleRect = CGRect(x: (dotLineBottomCircleDiameter-dotLineTopCircleDiameter)/2, y: (dotLineBottomCircleDiameter-dotLineTopCircleDiameter)/2, width: dotLineTopCircleDiameter, height: dotLineTopCircleDiameter)
            return (dotLine:dotLineRect, dotBottomCirle:dotBottomCirleRect, dotTopCirle:dotTopCirleRect)
        case .bottom:
            let dotLineRect = DotLineRect(x: dotLineBottomCircleDiameter/2, y: 0, width: dotlineDistance.width, length: dotlineDistance.length-dotLineBottomCircleDiameter)
            let dotBottomCirleRect = CGRect(x: 0, y: dotlineDistance.length-dotLineBottomCircleDiameter, width: dotLineBottomCircleDiameter, height: dotLineBottomCircleDiameter)
            let dotTopCirleRect = CGRect(x: (dotLineBottomCircleDiameter-dotLineTopCircleDiameter)/2, y: dotBottomCirleRect.minY+(dotLineBottomCircleDiameter-dotLineTopCircleDiameter)/2, width: dotLineTopCircleDiameter, height: dotLineTopCircleDiameter)
            return (dotLine:dotLineRect, dotBottomCirle:dotBottomCirleRect, dotTopCirle:dotTopCirleRect)
        case .left:
            let dotLineRect = DotLineRect(x: 0, y: dotLineBottomCircleDiameter/2, width: dotlineDistance.width, length: dotlineDistance.length-dotLineBottomCircleDiameter)
            let dotBottomCirleRect = CGRect(x: dotlineDistance.length-dotLineBottomCircleDiameter, y: 0, width: dotLineBottomCircleDiameter, height: dotLineBottomCircleDiameter)
            let dotTopCirleRect = CGRect(x: dotBottomCirleRect.minX+(dotLineBottomCircleDiameter-dotLineTopCircleDiameter)/2, y: (dotLineBottomCircleDiameter-dotLineTopCircleDiameter)/2, width: dotLineTopCircleDiameter, height: dotLineTopCircleDiameter)
            return (dotLine:dotLineRect, dotBottomCirle:dotBottomCirleRect, dotTopCirle:dotTopCirleRect)
        case .right:
            let dotLineRect = DotLineRect(x: dotLineBottomCircleDiameter, y: dotLineBottomCircleDiameter/2, width: dotlineDistance.width, length: dotlineDistance.length-dotLineBottomCircleDiameter)
            let dotBottomCirleRect = CGRect(x: 0, y: 0, width: dotLineBottomCircleDiameter, height: dotLineBottomCircleDiameter)
            let dotTopCirleRect = CGRect(x: (dotLineBottomCircleDiameter-dotLineTopCircleDiameter)/2, y: (dotLineBottomCircleDiameter-dotLineTopCircleDiameter)/2, width: dotLineTopCircleDiameter, height: dotLineTopCircleDiameter)
            return (dotLine:dotLineRect, dotBottomCirle:dotBottomCirleRect, dotTopCirle:dotTopCirleRect)
        }
    }
    // 获取DotLine图层父视图的坐标
    func getDotLineLayerContainerViewFrame(position: BubblePopupPositionType, targetPoint:CGPoint) -> CGRect {
        switch position {
        case .top:
            return CGRect(x: targetPoint.x-dotLineBottomCircleDiameter/2, y: 0, width: dotLineBottomCircleDiameter, height: dotlineDistance.length)
        case .bottom:
            return CGRect(x: targetPoint.x-dotLineBottomCircleDiameter/2, y: targetPoint.y-dotlineDistance.length+dotLineBottomCircleDiameter/2, width: dotLineBottomCircleDiameter, height: dotlineDistance.length)
        case .left:
            return CGRect(x: targetPoint.x-dotlineDistance.length+dotLineBottomCircleDiameter/2, y:targetPoint.y-dotLineBottomCircleDiameter/2 , width: dotlineDistance.length, height: dotLineBottomCircleDiameter)
        case .right:
            return CGRect(x: 0, y:targetPoint.y-dotLineBottomCircleDiameter/2 , width: dotlineDistance.length, height: dotLineBottomCircleDiameter)
        }
    }
    // 对气泡弹框布局做更新
    func layoutDotLineBubblePopupView(bubblePopup: BubblePopup, positionType: BubblePopupPositionType) {
        guard let contentViewSub = bubblePopup.bubbleContentView else { return }
        guard let bubbleBGViewSub = bubblePopup.bubbleBGView else { return }

        
        switch positionType {
        case .top:
            let pY = linkPoint.y-dotLineBottomCircleDiameter/2
            let pMaxX = linkPoint.x+bubblePopup.frame.width/2
            var pMinX = linkPoint.x-bubblePopup.frame.width/2
            if pMaxX > UIScreen.main.bounds.width {
                pMinX = pMinX - (pMaxX-UIScreen.main.bounds.width)
            } else if pMinX < 0 {
                pMinX = 0
            }
 
            bubblePopup.frame.origin = CGPoint(x: pMinX, y: pY)
             
            bubblePopup.frame.size = CGSize(width: contentViewSub.frame.width, height: contentViewSub.frame.height+dotlineDistance.length)
        case .bottom:
            let pY = linkPoint.y-dotlineDistance.length-bubblePopup.frame.height+dotLineBottomCircleDiameter/2
            let pMaxX = linkPoint.x+bubblePopup.frame.width/2
            var pMinX = linkPoint.x-bubblePopup.frame.width/2
            if pMaxX > UIScreen.main.bounds.width {
                pMinX = pMinX - (pMaxX-UIScreen.main.bounds.width)
            } else if pMinX < 0 {
                pMinX = 0
            }
 
            bubblePopup.frame.origin = CGPoint(x: pMinX, y: pY)
             
            bubblePopup.frame.size = CGSize(width: contentViewSub.frame.width, height: contentViewSub.frame.height+dotlineDistance.length)
        case .left:
            let pY = linkPoint.y-bubblePopup.frame.height/2
            let pMinX = linkPoint.x-bubblePopup.frame.width-dotlineDistance.length+dotLineBottomCircleDiameter/2
 
            bubblePopup.frame.origin = CGPoint(x: pMinX, y: pY)
            bubblePopup.frame.size = CGSize(width: contentViewSub.frame.width+dotlineDistance.length, height: contentViewSub.frame.height)
        case .right:
            let pY = linkPoint.y-bubblePopup.frame.height/2
            let pMinX = linkPoint.x-dotLineBottomCircleDiameter/2
 
            bubblePopup.frame.origin = CGPoint(x: pMinX, y: pY)
            bubblePopup.frame.size = CGSize(width: contentViewSub.frame.width+dotlineDistance.length, height: contentViewSub.frame.height)
        }
        updateBGBubbleViewFrame(position: positionType, bgBubbleView: bubbleBGViewSub)
        bubblePopup.bubbleContentView?.frame = bubbleBGViewSub.frame
    }
    // 更新气泡背景视图的坐标
    func updateBGBubbleViewFrame(position: BubblePopupPositionType, bgBubbleView: UIView) {
        switch position {
        case .top:
            bgBubbleView.frame.origin = CGPoint(x: 0, y: dotlineDistance.length)
        case .bottom:
            bgBubbleView.frame.origin = CGPoint(x: 0, y: 0)
        case .left:
            bgBubbleView.frame.origin = CGPoint(x: 0, y: 0)
        case .right:
            bgBubbleView.frame.origin = CGPoint(x: dotlineDistance.length, y: 0)
        }
    }
}

class DotLineTopBubblePopupBuilder: DotLineBubblePopupBuilder {
    
    override func updateLayout(to bubblePopup: BubblePopup) {
        layoutDotLineBubblePopupView(bubblePopup: bubblePopup, positionType: .top)
    }
    
    override func addBubbleFlagView(to bubblePopup: BubblePopup) {
        assert(!self.targetPoint.equalTo(.zero), "气泡提示点无效")
        
        let flagFrame = getDotLineLayerContainerViewFrame(position: .top, targetPoint: self.targetPoint)
        let params = getDrawDotLineLayerRectParams(position: .top)
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
        
        let flagFrame = getDotLineLayerContainerViewFrame(position: .bottom, targetPoint: self.targetPoint)
        let params = getDrawDotLineLayerRectParams(position: .bottom)
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
        
        let flagFrame = getDotLineLayerContainerViewFrame(position: .left, targetPoint: self.targetPoint)
        let params = getDrawDotLineLayerRectParams(position: .left)
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
        
        let flagFrame = getDotLineLayerContainerViewFrame(position: .right, targetPoint: self.targetPoint)
        let params = getDrawDotLineLayerRectParams(position: .right)
        let flagBubbleView = BubbleViewFactory.generateDotLineBubbleFlagView(flagFrame: flagFrame, position: .right, params: params)
        bubblePopup.bubbleFlagView = flagBubbleView
        bubblePopup.addSubview(flagBubbleView)
    }
    
}
