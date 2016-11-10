//
//  CircleView.swift
//  CALayerDemo
//
//  Created by zhangyang on 2016/11/9.
//  Copyright © 2016年 zhangyang. All rights reserved.
//

import UIKit

class CircleView: UIView {

    var tick = CFTimeInterval(0.1)
    var lineWidth: CGFloat
    var cvColor: UIColor = UIColor.red
    var cvBackgroundColor: UIColor = UIColor.lightGray
    var title: String?
    
    
    init(origin: CGPoint, width: CGFloat) {
        lineWidth = width / 16.0
        let size = CGSize(width: width, height: width)
        let frame = CGRect(origin: origin, size: size)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animate(percentage: Double) {
        addBackground()
        circleAnimate(percentage: percentage)
        guard let title = title else { return }
        if percentage == 1 {
            addTitleLabel(title: title, color: cvBackgroundColor)
        } else {
            addTitleLabel(title: title, color: cvColor)
        }
    }

    func addBackground() {
        self.layer.addSublayer(circleBackgroundLayer())
    }

    func circleBackgroundLayer() -> CALayer {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width * 0.45), startAngle: CGFloat(M_PI * -0.5), endAngle: CGFloat(M_PI * 1.5), clockwise: true)
        
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = circlePath.cgPath
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = cvBackgroundColor.cgColor
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.strokeEnd = 1.0
        layer.addSublayer(backgroundLayer)
        return backgroundLayer
    }
    
    func addTitleLabel(title:String, color:UIColor) {
        let superWidth = self.frame.width
        let label = UILabel(frame: CGRect(x: superWidth*0.25, y: superWidth*0.25, width: superWidth*0.5, height: superWidth*0.5))
        label.text = title
        label.textAlignment = .center
        label.textColor = color
        label.numberOfLines = 2
        label.font = UIFont(name: "Helvetica-Bold", size: 17)
        self.addSubview(label)
    }
    
    func circleAnimate(percentage: Double) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width * 0.45), startAngle: CGFloat(M_PI * -0.5), endAngle: CGFloat(M_PI * 1.5), clockwise: true)
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = cvColor.cgColor
        circleLayer.lineWidth = lineWidth
        layer.addSublayer(circleLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = percentage * 10 * tick
        animation.fromValue = 0
        animation.toValue = percentage
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        circleLayer.strokeEnd = CGFloat(percentage)
        circleLayer.add(animation, forKey: "CircleAnimation")
    }

}
