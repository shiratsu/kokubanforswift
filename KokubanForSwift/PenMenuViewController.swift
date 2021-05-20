//
//  PenMenuViewController.swift
//  KokubanForSwift
//
//  Created by 平塚俊輔 on 2021/05/19.
//  Copyright © 2021 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

class PenMenuViewController: UIViewController {

    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var titlePenBold: UILabel!
    @IBOutlet weak var titleColor: UILabel!
    @IBOutlet weak var boldSlider: UISlider!
    @IBOutlet weak var colorPicker: ColorPicker!
    
    var colorSpace: HRColorSpace = .sRGB
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boldSlider.minimumValue = 0.0
        boldSlider.maximumValue = 10.0
        boldSlider.value = 5
        
        boldSlider.addTarget(self, action: #selector(sliderDidChangeValue(_:)), for: .valueChanged)

        colorPicker.addTarget(self, action: #selector(self.handleColorChanged(picker:)), for: .valueChanged)
        colorPicker.set(color: UIColor(displayP3Red: 1.0, green: 1.0, blue: 0, alpha: 1), colorSpace: colorSpace)
        
        // Do any additional setup after loading the view.
    }

    @objc func sliderDidChangeValue(_ sender: UISlider) {
        let value = sender.value
        
    }

    @objc func handleColorChanged(picker: ColorPicker) {
        
    }
}


