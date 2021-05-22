//
//  PenMenuViewController.swift
//  KokubanForSwift
//
//  Created by 平塚俊輔 on 2021/05/19.
//  Copyright © 2021 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

enum PenMenuMode: Int{
    case pencil = 1
    case string = 2
}

class PenMenuViewController: UIViewController {

    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var titlePenBold: UILabel!
    @IBOutlet weak var titleColor: UILabel!
    @IBOutlet weak var boldSlider: UISlider!
    @IBOutlet weak var colorPicker: ColorPicker!
    @IBOutlet weak var colorButton: UIButton!
    
    var colorSpace: HRColorSpace = .sRGB
    
    // ペンの値
    var penBold: Float = 5
    var penColor: UIColor = UIColor.white
    
    var intMode: Int = 0
    var strMode: String = "ペン"
    
    weak var delegatePenMenu: PenMenuProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boldSlider.minimumValue = 0.0
        boldSlider.maximumValue = 10.0
        boldSlider.value = penBold
        
        let ciColor = CIColor(cgColor: penColor.cgColor)
        
        boldSlider.addTarget(self, action: #selector(sliderDidChangeValue(_:)), for: .valueChanged)

        colorPicker.addTarget(self, action: #selector(self.handleColorChanged(picker:)), for: .valueChanged)
        colorPicker.set(color: UIColor(displayP3Red: ciColor.red, green: ciColor.green, blue: ciColor.blue, alpha: ciColor.alpha), colorSpace: colorSpace)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    /// modalを閉じる
    /// - Parameter sender: <#sender description#>
    @IBAction func closeModal(sender: AnyObject) {
        
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

