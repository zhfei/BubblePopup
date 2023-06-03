//
//  ViewController.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/2.
//

import UIKit
 
class ViewController: UIViewController {

    @IBOutlet weak var btns: UIStackView!
    private var isDotLine = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    @IBAction func showTranglePopup(_ sender: UIButton) {
        BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .triangle, positionType: .bottom, popupPoint: CGPoint(x: sender.frame.midX, y: sender.frame.minY), linkPoint: nil, maxWidth: 200.0)
    }
     
    @IBAction func showPopup(_ sender: UIButton) {
        if isDotLine {
            //虚线气泡
            switch sender.tag {
            case 1:
                BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .dotLine, positionType: .bottom, popupPoint: nil, linkPoint: CGPoint(x: sender.frame.midX, y: sender.frame.minY), maxWidth: 200.0)
            case 2:
                BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .dotLine, positionType: .top, popupPoint: nil, linkPoint: CGPoint(x: sender.frame.midX, y: sender.frame.maxY), maxWidth: 200.0)
            case 3:
                BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .dotLine, positionType: .left, popupPoint: nil, linkPoint: CGPoint(x: sender.frame.maxX, y: sender.frame.midY), maxWidth: 200.0)
            case 4:
                BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .dotLine, positionType: .right, popupPoint: nil, linkPoint: CGPoint(x: sender.frame.minX, y: sender.frame.midY), maxWidth: 200.0)
            default:
                break
            }
        } else {
            //三角
            switch sender.tag {
            case 1:
                BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .triangle, positionType: .bottom, popupPoint: CGPoint(x: sender.frame.midX, y: sender.frame.minY), linkPoint: nil, maxWidth: 200.0)
            case 2:
                BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .triangle, positionType: .top, popupPoint: CGPoint(x: sender.frame.midX, y: sender.frame.maxY), linkPoint: nil, maxWidth: 200.0)
            case 3:
                BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .triangle, positionType: .left, popupPoint: CGPoint(x: sender.frame.maxX, y: sender.frame.midY), linkPoint: nil, maxWidth: 200.0)
            case 4:
                BubblePopupManager.shared.addPopup(toView: self.view, tips: "冒泡弹窗", popupType: .triangle, positionType: .right, popupPoint: CGPoint(x: sender.frame.minX, y: sender.frame.midY), linkPoint: nil, maxWidth: 200.0)
            default:
                break
            }
        }
 
    }
    
    @IBAction func switchAction(_ sender: UIButton) {
        btns.arrangedSubviews.forEach { item in
            if let btn = item as? UIButton {
                btn.isEnabled = true
            }
        }
        sender.isEnabled = false
        isDotLine = (sender.tag == 12)
    }
    
    
}
