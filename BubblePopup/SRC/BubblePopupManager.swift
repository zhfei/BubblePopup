//
//  BubblePopupManager.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/2.
//

import UIKit

@objcMembers
class BubblePopupManager: NSObject {
     
    static let shared = BubblePopupManager()
    private var closeCallBack: (() -> Void)?
     
    func addPopup(toView: UIView, tips: String, popupType:BubblePopupType, positionType: BubblePopupPositionType, popupPoint: CGPoint?, linkPoint: CGPoint?, maxWidth: Double) {
         
        var popup: BubblePopup?;
         
        if popupType == .dotLine {
            switch positionType {
            case .top:
                popup = DotLineTopBubblePopupBuilder(tips: tips, customContentView: nil, maxWidth: maxWidth, linkPoint: linkPoint!).getBubblePopup()
            case .bottom:
                popup = DotLineBottomBubblePopupBuilder(tips: tips, customContentView: nil, maxWidth: maxWidth, linkPoint: linkPoint!).getBubblePopup()
            case .left:
                popup = DotLineLeftBubblePopupBuilder(tips: tips, customContentView: nil, maxWidth: maxWidth, linkPoint: linkPoint!).getBubblePopup()
            case .right:
                popup = DotLineRightBubblePopupBuilder(tips: tips, customContentView: nil, maxWidth: maxWidth, linkPoint: linkPoint!).getBubblePopup()
            
            }
            
        } else if popupType == .triangle {
            switch positionType {
            case .top:
                popup = TriangleTopBubblePopupBuilder(tips: tips, customContentView: nil, maxWidth: maxWidth, popupPoint: popupPoint!).getBubblePopup()
            case .bottom:
                popup = TriangleBottomBubblePopupBuilder(tips: tips, customContentView: nil, maxWidth: maxWidth, popupPoint: popupPoint!).getBubblePopup()
            case .left:
                popup = TriangleLeftBubblePopupBuilder(tips: tips, customContentView: nil, maxWidth: maxWidth, popupPoint: popupPoint!).getBubblePopup()
            case .right:
                popup = TriangleRightBubblePopupBuilder(tips: tips, customContentView: nil, maxWidth: maxWidth, popupPoint: popupPoint!).getBubblePopup()
            }
        }
         
        if let popupSub = popup {
            toView.addSubview(popupSub)
        }
    }
     
    func addPopup(toView: UIView, customContentView: UIView, popupType:BubblePopupType, positionType: BubblePopupPositionType, popupPoint: CGPoint?, linkPoint: CGPoint?, maxWidth: Double) {
              
            var popup: BubblePopup?;
              
            if popupType == .dotLine {
                switch positionType {
                case .top:
                    popup = DotLineTopBubblePopupBuilder(tips: nil, customContentView: customContentView, maxWidth: maxWidth, linkPoint: linkPoint!).getBubblePopup()
                case .bottom:
                    popup = DotLineBottomBubblePopupBuilder(tips: nil, customContentView: customContentView, maxWidth: maxWidth, linkPoint: linkPoint!).getBubblePopup()
                case .left:
                    popup = DotLineLeftBubblePopupBuilder(tips: nil, customContentView: customContentView, maxWidth: maxWidth, linkPoint: linkPoint!).getBubblePopup()
                case .right:
                    popup = DotLineRightBubblePopupBuilder(tips: nil, customContentView: customContentView, maxWidth: maxWidth, linkPoint: linkPoint!).getBubblePopup()
                 
                }
                 
            } else if popupType == .triangle {
                switch positionType {
                case .top:
                    popup = TriangleTopBubblePopupBuilder(tips: nil, customContentView: customContentView, maxWidth: maxWidth, popupPoint: popupPoint!).getBubblePopup()
                case .bottom:
                    popup = TriangleBottomBubblePopupBuilder(tips: nil, customContentView: customContentView, maxWidth: maxWidth, popupPoint: popupPoint!).getBubblePopup()
                case .left:
                    popup = TriangleLeftBubblePopupBuilder(tips: nil, customContentView: customContentView, maxWidth: maxWidth, popupPoint: popupPoint!).getBubblePopup()
                case .right:
                    popup = TriangleRightBubblePopupBuilder(tips: nil, customContentView: customContentView, maxWidth: maxWidth, popupPoint: popupPoint!).getBubblePopup()
                }
            }
              
            if let popupSub = popup {
                toView.addSubview(popupSub)
            }
        }
}
