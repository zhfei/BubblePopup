//
//  BubbleView.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/4.
//

import UIKit

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
