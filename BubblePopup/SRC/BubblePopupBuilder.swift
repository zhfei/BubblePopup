//
//  BubbleBuilder.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/3.
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

class BubblePopupBuilder {
    private let bubblePopup = BubblePopup1()
    private let tips: String?
    private let maxWidth: Double
    private var contentView: UIView?
    init(tips: String?, customContentView: UIView? = nil, maxWidth: Double) {
        self.tips = tips
        self.maxWidth = maxWidth
        self.contentView = customContentView;
        setupUI()
    }
    
    func setupUI() {
        addBubbleContentView(to: bubblePopup)
        addBubbleBGView(to: bubblePopup)
        updateLayout(to: bubblePopup)
        addBubbleFlagView(to: bubblePopup)
    }
    
    func addBubbleContentView(to bubblePopup: BubblePopup1) {
        if let tipsSub = tips {
            let contentView = BubbleViewFactory.generateTextContentView(tipText: tipsSub, maxWidth: maxWidth)
            bubblePopup.bubbleContentView = contentView
            bubblePopup.frame.size = contentView.frame.size
            bubblePopup.addSubview(contentView)
        }
    }
    func addBubbleBGView(to bubblePopup: BubblePopup1) {
        let bgBubble = BubbleViewFactory.generateBGBubbleView(bubbleSize: bubblePopup.frame.size)
        bubblePopup.bubbleBGView = bgBubble
        bubblePopup.insertSubview(bgBubble, at: 0)
        
    }
    func updateLayout(to bubblePopup: BubblePopup1) {
        fatalError("must override")
    }
    func addBubbleFlagView(to bubblePopup: BubblePopup1) {
        fatalError("must override")
    }
    func getBubblePopup() -> BubblePopup1 {
        return bubblePopup
    }
}
