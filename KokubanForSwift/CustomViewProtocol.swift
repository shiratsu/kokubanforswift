//
//  CustomViewProtocol.swift
//  KokubanForSwift
//
//  Created by 平塚俊輔 on 2021/05/12.
//  Copyright © 2021 HIRATSUKA SHUNSUKE. All rights reserved.
//

import Foundation

public protocol CustomViewProtocol: class{
    
    
    /// ドラッグしてviewを動かす処理を定義
    /// - Parameters:
    ///   - touches: <#touches description#>
    ///   - event: <#event description#>
    func dragMoved(_ touches: Set<UITouch>, with event: UIEvent?)
}


extension UIView: CustomViewProtocol{
    
    
    /// ドラッグしてviewを動かす処理を定義
    /// - Parameters:
    ///   - touches: <#touches description#>
    ///   - event: <#event description#>
    public func dragMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // [1]
        guard let touch = touches.first
              , let view = touch.view else { return }

        // [2]
        if view != self {
            view.center = touch.location(in: self)
        }
        
        
    }
    
    
    
    
    
}
