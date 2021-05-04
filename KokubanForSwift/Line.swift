//
//  Line.swift
//  KokubanForSwift
//
//  Created by HIRATSUKA SHUNSUKE on 2015/02/19.
//  Copyright (c) 2015年 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

class Line: UIViewController,UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cellの.を取得する.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) 
        
        // Cellに値を設定する.
        
        
        if indexPath.row == 0{
            cell.imageView!.image = UIImage(named:"sen5.png")
            cell.textLabel!.text = "5mm幅"
        }
        if indexPath.row == 1{
            cell.imageView!.image = UIImage(named:"sen10.png")
            cell.textLabel!.text = "10mm幅(デフォルト)"
        }
        return cell
    }
    
    
    var lineView:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    Cellが選択された際に呼び出される.
    */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let myUserDafault:UserDefaults = UserDefaults()
        
        if indexPath.row == 0{
            
            myUserDafault.set(5, forKey: "linedepth")
            
        }
        if indexPath.row == 1{
            myUserDafault.set(10, forKey: "linedepth")
            
        }
    }
    
    /*
    Cellの総数を返す.
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
}
