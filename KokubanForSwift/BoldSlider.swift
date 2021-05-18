//
//  BoldSlider.swift
//  KokubanForSwift
//
//  Created by 平塚俊輔 on 2021/05/18.
//  Copyright © 2021 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

class BoldSlidder: UISlider{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupTextChangeNotification()
        setUpAction()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setupTextChangeNotification()
        setUpAction()
    }
    
    func setUpAction(){
        addTarget(self, action: #selector(sliderDidChangeValue(_:)), for: .valueChanged)

    }
    
    @objc func sliderDidChangeValue(_ sender: UISlider) {
        let value = sender.value
        
    }
}
