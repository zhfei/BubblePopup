//
//  BubblePopup.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/3.
//

import UIKit

class BubblePopup1: UIView {
    var bubbleBGView: UIView?
    var bubbleContentView: UIView?
    var bubbleFlagView: UIView?
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
}
