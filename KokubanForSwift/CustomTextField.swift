//
//  CustomTextField.swift
//  KokubanForSwift
//
//  Created by 平塚俊輔 on 2021/05/12.
//  Copyright © 2021 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var textFieldOrigin: CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupTextChangeNotification()
        setUpDragable()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setupTextChangeNotification()
        setUpDragable()
    }
    
    func setUpDragable(){
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(textFieldDrag(pan:)))
        addGestureRecognizer(gesture)
    }
    
    @objc func textFieldDrag(pan: UIPanGestureRecognizer) {
        print("Being Dragged")
        
        
        
        if pan.state == .began {
            print("panIF")
            textFieldOrigin = pan.location(in: self)
        }else {
            print("panELSE")
            let location = pan.location(in: superview) // get pan location
            let xPos = textFieldOrigin?.x ?? 0
            let yPos = textFieldOrigin?.y ?? 0
            self.frame.origin = CGPoint(x: location.x - xPos, y: location.y - yPos)
        }
    }
    
    
//    func enableDoubleClick(){
//        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
//        tap.numberOfTapsRequired = 2
//        addGestureRecognizer(tap)
//    }
//
//    @objc func doubleTapped() {
//        // do something here
//    }
    
//    func setupTextChangeNotification() {
//        NotificationCenter.default.addObserver(
//            forName: UITextField.textDidChangeNotification,
//            object: self,
//            queue: nil) { (notification) in
//                UIView.animate(withDuration: 0.05, animations: {
//                    self.invalidateIntrinsicContentSize()
//                })
//        }
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
//    override var intrinsicContentSize: CGSize {
//        if isEditing {
//            if let text = text,
//                !text.isEmpty {
//                // Convert to NSString to use size(attributes:)
//                let string = text as NSString
//                // Calculate size for current text
//                var size = string.size(withAttributes: typingAttributes)
//                // Add margin to calculated size
//                size.width += 10
//                return size
//            } else {
//                // You can return some custom size in case of empty string
//                return super.intrinsicContentSize
//            }
//        } else {
//            return super.intrinsicContentSize
//        }
//    }
}


/// TextFieldのアクションを定義
class TextFieldCtrl: NSObject,UITextFieldDelegate{
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("textFieldShouldReturn before responder\n")
        
        print("textFieldShouldReturn\n")
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        print("textFieldDidBeginEditing\n")
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing\n")
        return true
    }

    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing\n")
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        print("textFieldDidEndEditing\n")
    }
    
    
    
    

    
}
