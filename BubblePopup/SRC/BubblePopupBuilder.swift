//
//  BubbleBuilder.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/3.
//

import UIKit


class BubblePopupBuilder {
    private let bubblePopup = BubblePopup()
    private let tips: String?
    private let maxWidth: Double
    private var contentView: UIView?
    init(tips: String?, customContentView: UIView? = nil, maxWidth: Double) {
        self.tips = tips
        self.maxWidth = maxWidth
        self.contentView = customContentView;
        bubblePopup.bubbleContentView = customContentView
        setupUI()
    }
    
    func setupUI() {
        addBubbleContentView(to: bubblePopup)
        addBubbleBGView(to: bubblePopup)
        updateLayout(to: bubblePopup)
        addBubbleFlagView(to: bubblePopup)
    }
    
    func addBubbleContentView(to bubblePopup: BubblePopup) {
        if let tipsSub = tips {
            let contentView = BubbleViewFactory.generateTextContentView(tipText: tipsSub, maxWidth: maxWidth)
            self.contentView = contentView;
            bubblePopup.bubbleContentView = contentView
        }
 
        contentView!.frame.origin = .zero
        bubblePopup.frame.size = contentView!.frame.size
        bubblePopup.addSubview(contentView!)
    }
    func addBubbleBGView(to bubblePopup: BubblePopup) {
        let bgBubble = BubbleViewFactory.generateBGBubbleView(bubbleSize: bubblePopup.frame.size)
        bubblePopup.bubbleBGView = bgBubble
        bubblePopup.insertSubview(bgBubble, at: 0)
        
    }
    func updateLayout(to bubblePopup: BubblePopup) {
        fatalError("must override")
    }
    func addBubbleFlagView(to bubblePopup: BubblePopup) {
        fatalError("must override")
    }
    func getBubblePopup() -> BubblePopup {
        return bubblePopup
    }
}
