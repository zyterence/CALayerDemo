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
        addProcessLabel(percentage: percentage)
        if percentage == 0.0 { return }
        
        spotsFrontAnimate(count: count)
        circleAnimate(percentage: percentage)
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
        circleLayer.frame = layer.bounds
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.orange.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.lineCap = kCALineCapRound
        layer.addSublayer(circleLayer)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = layer.bounds
        let startColor = UIColor(red: 0.930, green: 0.280, blue: 0.200, alpha: 1.00)
        let endColor = UIColor(red: 0.920, green: 0.738, blue: 0.040, alpha: 1.00)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.mask = circleLayer
        layer.addSublayer(gradientLayer)
        
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
        
        let processLabel = UILabel(frame: CGRect(x: superWidth*0.075, y: superWidth*0.3, width: superWidth*0.5, height: superWidth*0.25))
        processLabel.text = String(Int(percentage*100))
        processLabel.textAlignment = .right
        processLabel.textColor = pvColor
        processLabel.font = UIFont(name: "Helvetica-Bold", size: superWidth/6)
        self.addSubview(processLabel)
        
        let signLabel = UILabel(frame: CGRect(x: superWidth*0.575, y: superWidth*0.3, width: superWidth*0.125, height: superWidth*0.25))
        signLabel.text = "%"
        signLabel.textAlignment = .center
        signLabel.textColor = pvColor
        signLabel.font = UIFont(name: "Helvetica-Bold", size: superWidth/12)
        self.addSubview(signLabel)
        
        let titleLabel = UILabel(frame: CGRect(x: superWidth*0.2, y: superWidth*0.55, width: superWidth*0.6, height: superWidth*0.15))
        titleLabel.text = "投资进度"
        titleLabel.textAlignment = .center
        titleLabel.textColor = pvColor
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: superWidth/10)
        self.addSubview(titleLabel)

    }

}
