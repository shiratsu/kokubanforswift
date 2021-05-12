//
//  DragableDrawingView.swift
//  KokubanForSwift
//
//  Created by 平塚俊輔 on 2021/05/13.
//  Copyright © 2021 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

class DragableDrawingView: DrawingView{
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            // [1]
        dragMoved(touches, with: event)
    }
    
    open override func addSubview(_ view: UIView){
        super.addSubview(view)
        view.center = center
    }
}
