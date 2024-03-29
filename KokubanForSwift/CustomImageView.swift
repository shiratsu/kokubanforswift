//
//  CustomImageView.swift
//  KokubanForSwift
//
//  Created by 平塚俊輔 on 2021/05/12.
//  Copyright © 2021 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            // [1]
        dragMoved(touches, with: event)
    }
    
    open override func addSubview(_ view: UIView){
        super.addSubview(view)
        view.center = center
    }

}
