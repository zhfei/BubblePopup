//
//  BubblePopup.swift
//  BubblePopup
//
//  Created by zhoufei on 2023/6/3.
//

import UIKit

//MARK: 常量
//虚线图层容器的尺寸：length为linkPoint与气泡的连线长度，与气泡垂直。width为容器的宽度，与气泡平行。
let dotlineDistance = BubbleDistance(width: 2, length: 35)
//虚线底部浅色大圆直径
let dotLineBottomCircleDiameter = 10.0
//虚线顶部浅色小圆直径
let dotLineTopCircleDiameter = 6.0
//三角形图层容器的尺寸：length为popupPoint与气泡的连线长度，与气泡垂直。width为容器的宽度，与气泡平行。
let triangleDistance = BubbleDistance(width: 10, length: 10)

//MARK: 结构体
enum BubblePopupType {
    // 虚线
    case dotLine
    // 三角形
    case triangle
}
 
enum BubblePopupPositionType {
    case top
    case bottom
    case left
    case right
}
 
struct DotLineRect {
    let x:Double;
    let y:Double;
    let width:Double;
    let length:Double; //代表linkPoint与气泡连线的长度
     
    func startPoint(position:BubblePopupPositionType) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    func endPoint(position:BubblePopupPositionType) -> CGPoint {
        switch position {
        case .top,.bottom:
            return CGPoint(x: x, y: length+y)
        case .left,.right:
            return CGPoint(x: x+length, y: y)
        }
    }
}
 
struct BubbleDistance {
    let width:Double;  //宽度
    let length:Double; //代表point与气泡连线的长度
}

//MARK: 气泡View
class BubblePopup: UIView {
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
