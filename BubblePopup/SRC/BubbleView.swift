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
   let bubbleCloseBtnXColor = UIColor.black
    
   lazy private var textLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 12)
       label.textColor = .black
       label.numberOfLines = 4
       return label
   }()
   lazy private var closeButton: UIButton = {
       let button = UIButton()
       button.frame.size = CGSize(width: closeButtonWidth, height: closeButtonWidth)
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
       addClose2Button(btn: closeButton)

       addSubview(textLabel)
       addSubview(closeButton)
   }
    
    func addClose2Button(btn: UIButton) {
        let dotLineLayer = CAShapeLayer()
        dotLineLayer.frame = btn.bounds
        let dotLinePath = UIBezierPath()
        dotLinePath.move(to: CGPoint(x: btn.bounds.width - closeButtonMargin, y: closeButtonMargin))
        dotLinePath.addLine(to: CGPoint(x: closeButtonMargin, y: btn.bounds.height - closeButtonMargin))
        dotLinePath.move(to: CGPoint(x: closeButtonMargin, y: closeButtonMargin))
        dotLinePath.addLine(to: CGPoint(x: btn.bounds.width - closeButtonMargin, y: btn.bounds.height - closeButtonMargin))
        dotLineLayer.path = dotLinePath.cgPath
        dotLineLayer.strokeColor = bubbleCloseBtnXColor.cgColor
        dotLineLayer.lineWidth = dotlineDistance.width
        btn.layer.addSublayer(dotLineLayer)
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
