//
//  ViewController.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/2.
//

import UIKit
 
class ViewController: UIViewController {
    
    enum BubblePopupType: Int {
        case triangle = 11
        case dotline
        case custome
        
    }

    @IBOutlet weak var btns: UIStackView!
    private var isDotLine = false
    private var showType: BubblePopupType = .dotline
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        switchAction(btns.arrangedSubviews.first as! UIButton)
    }

     
    @IBAction func showPopup(_ sender: UIButton) {
        switch showType {
        case .dotline:
            showDotLineBubblePopup(sender: sender)
        case .triangle:
            showTriangleBubblePopup(sender: sender)
        case .custome:
            showCustomContentBubblePopup(sender: sender)
        }
    }
    
    func showDotLineBubblePopup(sender: UIButton) {
        switch sender.tag {
        case 1:
            BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .dotLine, positionType: .bottom, popupPoint: nil, linkPoint: CGPoint(x: sender.frame.midX, y: sender.frame.minY), maxWidth: 200.0)
        case 2:
            BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .dotLine, positionType: .top, popupPoint: nil, linkPoint: CGPoint(x: sender.frame.midX, y: sender.frame.maxY), maxWidth: 200.0)
        case 3:
            BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .dotLine, positionType: .left, popupPoint: nil, linkPoint: CGPoint(x: sender.frame.minX, y: sender.frame.midY), maxWidth: 200.0)
        case 4:
            BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .dotLine, positionType: .right, popupPoint: nil, linkPoint: CGPoint(x: sender.frame.maxX, y: sender.frame.midY), maxWidth: 200.0)
        default:
            break
        }
    }
    
    func showTriangleBubblePopup(sender: UIButton) {
        switch sender.tag {
        case 1:
            BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .triangle, positionType: .bottom, popupPoint: CGPoint(x: sender.frame.midX, y: sender.frame.minY), linkPoint: nil, maxWidth: 200.0)
        case 2:
            BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .triangle, positionType: .top, popupPoint: CGPoint(x: sender.frame.midX, y: sender.frame.maxY), linkPoint: nil, maxWidth: 200.0)
        case 3:
            BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .triangle, positionType: .left, popupPoint: CGPoint(x: sender.frame.minX, y: sender.frame.midY), linkPoint: nil, maxWidth: 200.0)
        case 4:
            BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .triangle, positionType: .right, popupPoint: CGPoint(x: sender.frame.maxX, y: sender.frame.midY), linkPoint: nil, maxWidth: 200.0)
        default:
            break
        }
    }
    
    func showCustomContentBubblePopup(sender: UIButton) {
        let myContentView = CustomContentView()
        switch sender.tag {
        case 1:
            BubblePopupManager.shared.addPopup(toView: self.view, customContentView: myContentView, popupType: .dotLine, positionType: .bottom, popupPoint: nil, linkPoint: CGPoint(x: sender.frame.midX, y: sender.frame.minY), maxWidth: 200.0)
        case 2:
            
            BubblePopupManager.shared.addPopup(toView: self.view, customContentView: myContentView, popupType: .dotLine, positionType: .top, popupPoint: nil, linkPoint: CGPoint(x: sender.frame.midX, y: sender.frame.maxY), maxWidth: 200.0)
        case 3:
            BubblePopupManager.shared.addPopup(toView: self.view, customContentView: myContentView, popupType: .dotLine, positionType: .left, popupPoint: nil, linkPoint: CGPoint(x: sender.frame.minX, y: sender.frame.midY), maxWidth: 200.0)
        case 4:
            BubblePopupManager.shared.addPopup(toView: self.view, customContentView: myContentView, popupType: .dotLine, positionType: .right, popupPoint: nil, linkPoint: CGPoint(x: sender.frame.maxX, y: sender.frame.midY), maxWidth: 200.0)
        default:
            break
        }
        
    }
    
    @IBAction func switchAction(_ sender: UIButton) {
        btns.arrangedSubviews.forEach { item in
            if let btn = item as? UIButton {
                btn.isEnabled = true
            }
        }
        sender.isEnabled = false
        showType = BubblePopupType(rawValue: sender.tag)!
    }
    
    
}
