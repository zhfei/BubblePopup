//
//  BubbleFlagViewFactory.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/3.
//

import UIKit


class BubbleViewFactory {
    class func generateTextContentView(tipText: String, maxWidth: Double) -> UIView {
        let contentView = TextContentView(tips: tipText, maxWidth: maxWidth)
        return contentView
    }
    
    class func generateBGBubbleView(bubbleSize: CGSize) -> UIView{
        let bgBubbleView = UIView()
        bgBubbleView.frame = CGRect(x: 0, y: 0, width: bubbleSize.width, height: bubbleSize.height)
         
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bubbleSize.width, height: bubbleSize.height)
        gradientLayer.colors = [UIColor.yellow.cgColor,
                                UIColor.brown.cgColor].compactMap({ $0 })
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        bgBubbleView.layer.insertSublayer(gradientLayer, at: 0)
        bgBubbleView.layer.cornerRadius = 8
        bgBubbleView.layer.masksToBounds = true
        return bgBubbleView
    }
    
}

extension BubbleViewFactory {
    // DotLine
    class func generateDotLineBubbleFlagView(flagFrame: CGRect, position: BubblePopupPositionType, params: (dotLine:DotLineRect, dotBottomCirle:CGRect, dotTopCirle:CGRect)) -> UIView {
        
        let dotView = UIView(frame: flagFrame)
        
        let dotColor = UIColor.brown
         
        let dotLineLayer = CAShapeLayer()
        dotLineLayer.frame = dotView.bounds
        let dotLinePath = UIBezierPath()
        dotLinePath.move(to: params.dotLine.startPoint(position: position))
        dotLinePath.addLine(to: params.dotLine.endPoint(position: position))
        dotLineLayer.path = dotLinePath.cgPath
        dotLineLayer.strokeColor = dotColor.cgColor
        dotLineLayer.lineWidth = dotlineDistance.width
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
        return dotView
    }
}

extension BubbleViewFactory {
    // 三角形
    class func generateTriangleBubbleFlagView(flagFrame: CGRect, position: BubblePopupPositionType, params: (startPoint: CGPoint, point1: CGPoint, endPoint: CGPoint)) -> UIView {
        
        let triangleView = UIView(frame: flagFrame)
        let triangleColor = UIColor.brown

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
        
        return triangleView
    }
}

