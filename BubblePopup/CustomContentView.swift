//
//  CustomContentView.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/5.
//

import Foundation
import UIKit

class CustomContentView: UIView {
    
    init() {
        super.init(frame: .zero)
        if let contentView = Bundle.main.loadNibNamed("CustomContentView", owner: self, options: nil)?.first as? UIView {
            addSubview(contentView)
            self.frame.size = CGSize(width: 200, height: 100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
