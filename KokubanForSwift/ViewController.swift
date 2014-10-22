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

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

