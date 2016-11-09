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
        let origin1 = CGPoint(x: 50, y: 50)
        let processView1 = ProcessView(origin: origin1, width: 120)
        view.addSubview(processView1)
        processView1.animate(percentage: 0.8)
        
        let origin2 = CGPoint(x: 200, y: 50)
        let processView2 = ProcessView(origin: origin2, width: 120)
        view.addSubview(processView2)
        processView2.animate(percentage: 1)

        let origin3 = CGPoint(x: 50, y: 200)
        let processView3 = ProcessView(origin: origin3, width: 120)
        view.addSubview(processView3)
        processView3.animate(percentage: 0)

        let origin4 = CGPoint(x: 200, y: 200)
        let processView4 = ProcessView(origin: origin4, width: 120)
        view.addSubview(processView4)
        processView4.animate(percentage: 0.22)

    }


}

