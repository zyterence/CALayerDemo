//
//  ProcessView.swift
//  CALayerDemo
//
//  Created by zhangyang on 2016/11/1.
//  Copyright © 2016年 zhangyang. All rights reserved.
//

import UIKit

class ProcessView: UIView {
    
    let angle = Float(M_PI * 2.0) / 20
    let instanceFrame: CGRect
    let tick = CFTimeInterval(0.1)
    var lineWidth: CGFloat
    var pvColor: UIColor = UIColor.orange
    var pvBackgroundColor: UIColor = UIColor.lightGray
    
    init(origin: CGPoint, width: CGFloat) {

        lineWidth = width / 20.0
        
        let instanceOrigin = CGPoint(x: width/2.0, y: 0)
        let InstanceSize = CGSize(width: lineWidth, height: lineWidth)
        instanceFrame = CGRect(origin: instanceOrigin, size: InstanceSize)
        
        let size = CGSize(width: width, height: width)
        let frame = CGRect(origin: origin, size: size)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(percentage: Double) {
        let count = Int(percentage * 20) + 1
        addBackground()
        spotsFrontAnimate(count: count)
        circleAnimate(percentage: percentage)
        addProcessLabel(percentage: percentage)
    }
    
    func addBackground() {
        self.layer.addSublayer(spotsBackgroundLayer())
        self.layer.addSublayer(circleBackgroundLayer())
    }
    
    func spotsBackgroundLayer() -> CAReplicatorLayer {
        let background = CAReplicatorLayer()
        background.frame = self.bounds
        background.instanceCount = 20
        background.instanceDelay = CFTimeInterval(0.01)
        background.preservesDepth = false
        background.instanceColor = pvBackgroundColor.cgColor
        
        let backgroundInstance = CALayer()
        backgroundInstance.frame = instanceFrame
        backgroundInstance.cornerRadius = instanceFrame.size.width / 2.0
        backgroundInstance.backgroundColor = UIColor.white.cgColor
        
        background.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
        self.layer.addSublayer(background)
        background.addSublayer(backgroundInstance)
        return background
    }
    
    func spotsFrontAnimate(count: Int) {
        if count == 1 { return }
        
        let front = CAReplicatorLayer()
        front.frame = self.bounds
        front.instanceCount = count
        front.instanceDelay = tick
        front.preservesDepth = false
        front.instanceColor = pvColor.cgColor

        front.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
        self.layer.addSublayer(front)

        let frontInstance = CALayer()
        frontInstance.frame = instanceFrame
        frontInstance.cornerRadius = instanceFrame.size.width / 2.0
        frontInstance.backgroundColor = UIColor.white.cgColor
        front.addSublayer(frontInstance)

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 1.0
        animation.duration = Double(count) * tick
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        frontInstance.opacity = 0.0
        frontInstance.add(animation, forKey: "AppearAnimation")
    }

    func circleBackgroundLayer() -> CALayer {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width * 0.4), startAngle: CGFloat(M_PI * -0.5), endAngle: CGFloat(M_PI * 1.5), clockwise: true)
        
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = circlePath.cgPath
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = pvBackgroundColor.cgColor
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.strokeEnd = 1.0
        layer.addSublayer(backgroundLayer)
        return backgroundLayer
    }
    
    func circleAnimate(percentage: Double) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width * 0.4), startAngle: CGFloat(M_PI * -0.5), endAngle: CGFloat(M_PI * 1.5), clockwise: true)
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = pvColor.cgColor
        circleLayer.lineWidth = lineWidth
        layer.addSublayer(circleLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = percentage * 20 * tick
        animation.fromValue = 0
        animation.toValue = percentage
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        circleLayer.strokeEnd = CGFloat(percentage)
        circleLayer.add(animation, forKey: "CircleAnimation")
    }
    
    func addProcessLabel(percentage: Double) {
        let superWidth = self.frame.width
        
        let processLabel = UILabel(frame: CGRect(x: superWidth*0.1, y: superWidth*0.3, width: superWidth*0.8, height: superWidth*0.25))
        processLabel.text = String(percentage*100) + " %"
        processLabel.textAlignment = .center
        processLabel.textColor = pvColor
        processLabel.font = UIFont(name: "Helvetica-Bold", size: superWidth/6)
        self.addSubview(processLabel)
        
        let titleLabel = UILabel(frame: CGRect(x: superWidth*0.2, y: superWidth*0.55, width: superWidth*0.6, height: superWidth*0.15))
        titleLabel.text = "投资进度"
        titleLabel.textAlignment = .center
        titleLabel.textColor = pvColor
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: superWidth/10)
        self.addSubview(titleLabel)

    }

}
