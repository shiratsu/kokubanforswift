//
//  Line.swift
//  KokubanForSwift
//
//  Created by HIRATSUKA SHUNSUKE on 2015/02/19.
//  Copyright (c) 2015年 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

class Line: UIViewController,UITableViewDataSource,UITableViewDelegate,GADBannerViewDelegate{
    
    var lineView:UITableView!
    var bannerView_:GADBannerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone || UIDevice.currentDevice().userInterfaceIdiom == .Unspecified {
            
            bannerView_ = GADBannerView()
            
            bannerView_ = GADBannerView(adSize:kGADAdSizeBanner)
            
            bannerView_.frame.origin = CGPointMake(0, 0)
            bannerView_.frame.size = CGSizeMake(self.view.frame.size.width,50)
            
        }else{
            
            bannerView_ = GADBannerView()
            
            bannerView_ = GADBannerView(adSize:kGADAdSizeBanner)
            
            bannerView_.frame.origin = CGPointMake(0, 0)
            bannerView_.frame.size = CGSizeMake(self.view.frame.size.width,90)
            
            
        }
        
        bannerView_.adUnitID = "a14ec8b1eda2dca"
        bannerView_.delegate = self
        bannerView_.rootViewController = self
        
        var request:GADRequest = GADRequest()
        request.testDevices = [GAD_SIMULATOR_ID]
        
        bannerView_.loadRequest(request)
        self.view.addSubview(bannerView_)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    Cellが選択された際に呼び出される.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var myUserDafault:NSUserDefaults = NSUserDefaults()
        
        if indexPath.row == 0{
            myUserDafault.setObject(5, forKey: "linedepth")
            
        }
        if indexPath.row == 1{
            myUserDafault.setObject(10, forKey: "linedepth")
            
        }
    }
    
    /*
    Cellの総数を返す.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    /*
    Cellに値を設定する.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Cellの.を取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! UITableViewCell
        
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
    
}