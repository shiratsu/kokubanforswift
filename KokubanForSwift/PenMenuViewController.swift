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
    
    weak var delegatePenMenu: PenMenuProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boldSlider.minimumValue = 0.0
        boldSlider.maximumValue = 10.0
        boldSlider.value = Float(PencilValue.penBold)
        
        let ciColor = CIColor(cgColor: PencilValue.penColor.cgColor)
        
        boldSlider.addTarget(self, action: #selector(sliderDidChangeValue(_:)), for: .valueChanged)

        colorPicker.addTarget(self, action: #selector(self.handleColorChanged(picker:)), for: .valueChanged)
        colorPicker.set(color: UIColor(displayP3Red: ciColor.red, green: ciColor.green, blue: ciColor.blue, alpha: ciColor.alpha), colorSpace: colorSpace)
        
        view.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeThisPage))
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    // このページ閉じる
    @objc func closeThisPage(gesture: UITapGestureRecognizer) -> Void {
    //Write your code here
        dismiss(animated: false, completion: nil)
    }

    
    /// ペンの太さを変えた時
    /// - Parameter sender: <#sender description#>
    @objc func sliderDidChangeValue(_ sender: UISlider) {
        PencilValue.penBold = CGFloat(sender.value)
        delegatePenMenu?.updatePencilSetting()
    }

    
    /// 色変える時
    /// - Parameter picker: <#picker description#>
    @objc func handleColorChanged(picker: ColorPicker) {
        PencilValue.penColor = picker.color
        delegatePenMenu?.updatePencilSetting()
    }
}

protocol PenMenuProtocol: class {
    
    
    /// ペンの情報を更新
    func updatePencilSetting()
}

