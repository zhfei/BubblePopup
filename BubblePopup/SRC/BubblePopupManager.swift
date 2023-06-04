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
                popup = DotLineTopBubblePopupBuilder(tips: "弹了一个窗", customContentView: nil, maxWidth: 300, linkPoint: linkPoint!).getBubblePopup()
            case .bottom:
                popup = DotLineBottomBubblePopupBuilder(tips: "弹了一个窗", customContentView: nil, maxWidth: 300, linkPoint: linkPoint!).getBubblePopup()
            case .left:
                popup = DotLineLeftBubblePopupBuilder(tips: "弹了一个窗", customContentView: nil, maxWidth: 300, linkPoint: linkPoint!).getBubblePopup()
            case .right:
                popup = DotLineRightBubblePopupBuilder(tips: "弹了一个窗", customContentView: nil, maxWidth: 300, linkPoint: linkPoint!).getBubblePopup()
            
            }
            
        } else if popupType == .triangle {
            switch positionType {
            case .top:
                popup = TriangleTopBubblePopupBuilder(tips: "弹了一个窗", customContentView: nil, maxWidth: 300, popupPoint: popupPoint!).getBubblePopup()
            case .bottom:
                popup = TriangleBottomBubblePopupBuilder(tips: "弹了一个窗", customContentView: nil, maxWidth: 300, popupPoint: popupPoint!).getBubblePopup()
            case .left:
                popup = TriangleLeftBubblePopupBuilder(tips: "弹了一个窗", customContentView: nil, maxWidth: 300, popupPoint: popupPoint!).getBubblePopup()
            case .right:
                popup = TriangleRightBubblePopupBuilder(tips: "弹了一个窗", customContentView: nil, maxWidth: 300, popupPoint: popupPoint!).getBubblePopup()
            }
        }
         
        if let popupSub = popup {
            toView.addSubview(popupSub)
        }
    }
     
}
