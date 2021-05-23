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
        setUpAccessoryView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setupTextChangeNotification()
        setUpDragable()
        setUpAccessoryView()
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
    
    
    /// ツールを一緒に表示する
    func setUpAccessoryView(){
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        
        let button1 = UIBarButtonItem(title: "＜", style: UIBarButtonItem.Style.done, target: self, action: #selector(prevChar))
        let button2 = UIBarButtonItem(title: "＞", style: UIBarButtonItem.Style.done, target: self, action: #selector(nextChar))
        let button3 = UIBarButtonItem(title: "C_Line", style: UIBarButtonItem.Style.done, target: self, action: #selector(addCancelLine))
        let button4 = UIBarButtonItem(title: "U_Line", style: UIBarButtonItem.Style.done, target: self, action: #selector(addUnderLine))
        
        toolBar.setItems([button1, button2, button3,button4], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()

        inputAccessoryView = toolBar
    }
    
    

}


extension CustomTextField{
    
    
    /// 前の文字
    @objc func prevChar(){
        if let selectedRange = selectedTextRange {

            let cursorPosition = offset(from: beginningOfDocument, to: selectedRange.start)
            // and only if the new position is valid
            if let newPosition = position(from: selectedRange.start, offset: cursorPosition-1) {

                // set the new position
                selectedTextRange = textRange(from: newPosition, to: newPosition)
            }
            
        }
    }
    
    // 次の文字
    @objc func nextChar(){
        if let selectedRange = selectedTextRange {

            let cursorPosition = offset(from: beginningOfDocument, to: selectedRange.start)
            // and only if the new position is valid
            if let newPosition = position(from: selectedRange.start, offset: cursorPosition+1) {

                // set the new position
                selectedTextRange = textRange(from: newPosition, to: newPosition)
            }
            
        }
    }
    
    
    /// 打ち消し戦
    @objc func addCancelLine(){
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text ?? "")
//        // 全体に共通して付けたいレイアウトを設定
//        attributeString.addAttribute(.font,value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, attributeString.length))

        // 取り消し線部分の設定
        attributeString.addAttributes([
            .foregroundColor : UIColor.red,
            // 取り消し線の太さを決める
            .strikethroughStyle: 1
        // 取り消し線を反映したい部分を設定
        // NSMakeRange(何文字目から, 何文字間)
        ], range: NSMakeRange(1, attributeString.length))
        
        attributedText = attributeString
    }
    
    /// 下線
    @objc func addUnderLine(){
        
    }
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
