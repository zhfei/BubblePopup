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
    
    /// 添加文字型气泡提示
    /// - Parameters:
    ///   - toView: 要添加到的View
    ///   - tips: 字符串提示
    ///   - popupType: 气泡类型：三角形or虚线型
    ///   - positionType: 气泡类型标志（三角形or虚线型）的位置
    ///   - popupPoint: 三角形标志指示的点
    ///   - linkPoint: 虚线标志连接的点
    ///   - maxWidth: 弹窗的最大宽度，用来设置计算字符串型弹窗
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
     
    /// 添加文字型气泡提示
    /// - Parameters:
    ///   - toView: 要添加到的View
    ///   - customContentView: 自定义View，注意：里面的子视图的位置不能使用约束布局
    ///   - popupType: 气泡类型：三角形or虚线型
    ///   - positionType: 气泡类型标志（三角形or虚线型）的位置
    ///   - popupPoint: 三角形标志指示的点
    ///   - linkPoint: 虚线标志连接的点
    ///   - maxWidth: 弹窗的最大宽度，用来设置计算字符串型弹窗
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
