//
//  ViewController.swift
//  CALayerDemo
//
//  Created by zhangyang on 2016/11/1.
//  Copyright © 2016年 zhangyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let origin1 = CGPoint(x: 20, y: 50)
        let processView1 = ProcessView(origin: origin1, width: 150)
        view.addSubview(processView1)
        processView1.animate(percentage: 0.1)
        
        let origin2 = CGPoint(x: 200, y: 50)
        let processView2 = ProcessView(origin: origin2, width: 150)
        view.addSubview(processView2)
        processView2.animate(percentage: 1)

        let origin3 = CGPoint(x: 20, y: 250)
        let processView3 = ProcessView(origin: origin3, width: 150)
        view.addSubview(processView3)
        processView3.animate(percentage: 0)

        let origin4 = CGPoint(x: 200, y: 250)
        let processView4 = ProcessView(origin: origin4, width: 150)
        view.addSubview(processView4)
        processView4.animate(percentage: 0.22)
        
        let origin5 = CGPoint(x: 20, y: 500)
        let circle1 = CircleView(origin: origin5, width: 80)
        circle1.title = "立即投资"
        view.addSubview(circle1)
        circle1.animate(percentage: 0.80)
        
        let origin6 = CGPoint(x: 120, y: 500)
        let circle2 = CircleView(origin: origin6, width: 80)
        circle2.title = "还款中"
        view.addSubview(circle2)
        circle2.animate(percentage: 1)
        
        let origin7 = CGPoint(x: 220, y: 500)
        let circle3 = CircleView(origin: origin7, width: 80)
        circle3.title = "满标待审"
        view.addSubview(circle3)
        circle3.animate(percentage: 1)
        
        let origin8 = CGPoint(x: 320, y: 500)
        let circle4 = CircleView(origin: origin8, width: 80)
        circle4.title = "已完毕"
        view.addSubview(circle4)
        circle4.animate(percentage: 1)

    }


}

