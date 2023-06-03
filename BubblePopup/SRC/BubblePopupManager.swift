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
            popup = BubblePopup(tips: tips, dotLinePositionType: positionType, linkPoint: linkPoint!, maxWidth: maxWidth)
        } else if popupType == .triangle {
            popup = BubblePopup(tips: tips, trianglePositionType: positionType, popupPoint: popupPoint!, maxWidth: maxWidth)
        }
         
        if let popupSub = popup {
            toView.addSubview(popupSub)
        }
    }
     
}
