//
//  ViewController.swift
//  KokubanForSwift
//
//  Created by HIRATSUKA SHUNSUKE on 2014/10/21.
//  Copyright (c) 2014年 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var chook1: UIButton!
    @IBOutlet weak var elaser: UIButton!
    @IBOutlet weak var chook2: UIButton!
    @IBOutlet weak var chook3: UIButton!
    @IBOutlet weak var chook4: UIButton!
    @IBOutlet weak var tab: UIButton!
    @IBOutlet weak var aImageView: UIImageView!
    @IBOutlet var pastDrawingView: DrawingView!
    @IBOutlet var curDrawingView: DrawingView!
    var penWhite:CGFloat
    var penRed:CGFloat
    var penYellow:CGFloat
    var penBlue:CGFloat
    var penBlack:CGFloat
    var penGreen:CGFloat
    var penAlpha:CGFloat
    var select_chook:Int
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPenColor(index idx:NSInteger){
        var components:[CGFloat] = [
            1.0, 1.0, 1.0, 1.0,
            246 / 255.0, 171 / 255.0, 171 / 255.0,  1.0,	// 0:ピンク
            171 / 255.0, 177 / 255.0, 244 / 255.0, 1.0,	// 1:青
            238 / 255.0, 241 / 255.0, 174 / 255.0, 1.0,	// 2:き色
            171 / 255.0, 244 / 255.0, 177 / 255.0, 1.0,	// 3:緑
            0.0, 0.0, 0.0, 0.0,	// 0:消す
        ]
        if (idx >= 0) && (idx <= 5) {
            penRed		= components[idx*4+0]
            penGreen	= components[idx*4+1]
            penBlue     = components[idx*4+2]
            penAlpha	= components[idx*4+3]
        }
        
    }
    
    @IBAction func chook1(sender: AnyObject) {
    }
    @IBAction func chook2(sender: AnyObject) {
    }
    @IBAction func chook3(sender: AnyObject) {
    }
    @IBAction func chook4(sender: AnyObject) {
    }
    @IBAction func chook5(sender: AnyObject) {
    }
    @IBAction func elase(sender: AnyObject) {
    }
    
    func Allstand(stand:Int){
        
        switch select_chook{
            case 1:
            break
            case 2:
            break
            default:
            break;
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

