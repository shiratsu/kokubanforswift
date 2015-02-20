//
//  ViewController.swift
//  KokubanForSwift
//
//  Created by HIRATSUKA SHUNSUKE on 2014/10/21.
//  Copyright (c) 2014年 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,GADBannerViewDelegate {
    
    @IBOutlet weak var chook1: UIButton!
    @IBOutlet weak var elaser: UIButton!
    @IBOutlet weak var chook2: UIButton!
    @IBOutlet weak var chook3: UIButton!
    @IBOutlet weak var chook4: UIButton!
    @IBOutlet weak var chook5: UIButton!
    @IBOutlet weak var tab: UIButton!
    @IBOutlet weak var aImageView: UIImageView!
    @IBOutlet var pastDrawingView: DrawingView!
    @IBOutlet var curDrawingView: DrawingView!
    var bannerView_:GADBannerView!
    var penWhite:CGFloat
    var penRed:CGFloat
    var penYellow:CGFloat
    var penBlue:CGFloat
    var penBlack:CGFloat
    var penGreen:CGFloat
    var penAlpha:CGFloat
    var select_chook:Int
    var kokubanMode:Bool
    var billingMode:Bool
    var yukiMode:Bool
    var aryStroke:NSMutableArray
    var sourceType:UIImagePickerControllerSourceType
    
    

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
        Allstand(1)
        setPenColor(index: 0)
        kokubanMode = true
    }
    @IBAction func chook2(sender: AnyObject) {
        Allstand(2)
        setPenColor(index: 1)
        kokubanMode = true
    }
    @IBAction func chook3(sender: AnyObject) {
        Allstand(3)
        setPenColor(index: 2)
        kokubanMode = true
    }
    @IBAction func chook4(sender: AnyObject) {
        Allstand(4)
        setPenColor(index: 3)
        kokubanMode = true
    }
    @IBAction func chook5(sender: AnyObject) {
        Allstand(5)
        setPenColor(index: 4)
        kokubanMode = true
        
    }
    
    func elase() {
        Allstand(10)
        setPenColor(index: 5)
        kokubanMode = true
        
    }
    @IBAction func showEraseSheet(sender: AnyObject) {
        
        let alert = UIAlertController(title: "どうする？？", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let okButton = UIAlertAction(title: "一つ前に戻る", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
            println("Ok Selected")
            self.kokubanMode = true
            if self.aryStroke.count > 0 {
                self.aryStroke.removeLastObject()
                self.pastDrawingView.aryData = self.aryStroke
                self.pastDrawingView.setNeedsDisplay()
            }
            
        }
        let cancelButton = UIAlertAction(title: "全消し", style: UIAlertActionStyle.Cancel) { (cancelSelected) -> Void in
            println("Cancel Selected")
            
            self.kokubanMode = true
            if self.aryStroke.count > 0 {
                self.aryStroke.removeAllObjects()
                self.pastDrawingView.aryData = self.aryStroke
                self.pastDrawingView.setNeedsDisplay()
            }
        }
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    @IBAction func showActionSheet(sender: AnyObject) {
        if !self.billingMode {
            let alert = UIAlertController(title: "どうする？？", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            let button1 = UIAlertAction(title: "写真を選ぶ", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                self.selectLibraly()
                
                
            }
            let button2 = UIAlertAction(title: "ライブラリに保存", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                self.onTouchUpInsideBtnCapture()
            }
            let button3 = UIAlertAction(title: "黒板を表示", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
                self.aImageView.frame = CGRectMake(0, 0, myBoundSize.width, myBoundSize.height)
                self.aImageView.image = UIImage(named: "back.png")
            }
            let button4 = UIAlertAction(title: "ひまわり", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                self.kokubanMode = false
                self.yukiMode = true
            }
            let button5 = UIAlertAction(title: "チョークを使う", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                self.kokubanMode = true
                self.yukiMode = false
            }
            let button6 = UIAlertAction(title: "線の太さを変える", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                
            }
            let button7 = UIAlertAction(title: "黒板の有料版を購入", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                
            }
    
            alert.addAction(button1)
            alert.addAction(button2)
            alert.addAction(button3)
            alert.addAction(button4)
            alert.addAction(button5)
            alert.addAction(button6)
            alert.addAction(button7)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }else{
            let alert = UIAlertController(title: "どうする？？", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            let button1 = UIAlertAction(title: "写真を選ぶ", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                self.selectLibraly()
                
            }
            let button2 = UIAlertAction(title: "ライブラリに保存", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                self.onTouchUpInsideBtnCapture()
                
            }
            let button3 = UIAlertAction(title: "黒板を表示", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
                self.aImageView.frame = CGRectMake(0, 0, myBoundSize.width, myBoundSize.height)
                self.aImageView.image = UIImage(named: "back.png")
            }
            let button4 = UIAlertAction(title: "ひまわり", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                self.kokubanMode = false
                self.yukiMode = true
                
            }
            let button5 = UIAlertAction(title: "チョークを使う", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                self.kokubanMode = true
                self.yukiMode = false
                
            }
            let button6 = UIAlertAction(title: "線の太さを変える", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                
            }
            
            
            alert.addAction(button1)
            alert.addAction(button2)
            alert.addAction(button3)
            alert.addAction(button4)
            alert.addAction(button5)
            alert.addAction(button6)
            
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func selectLibraly() {
        self.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        if !UIImagePickerController.isSourceTypeAvailable(self.sourceType) {
            return
        }
        
        var imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func takeGrabScreenImage() -> UIImage {
        UIGraphicsBeginImageContext(aImageView.frame.size)
        
        var image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func Allstand(stand:Int){
        
        switch select_chook{
            case 1:
                self.chook1.transform = CGAffineTransformMakeRotation(0)
            break
            case 2:
                self.chook2.transform = CGAffineTransformMakeRotation(0)
            break
            case 3:
                self.chook3.transform = CGAffineTransformMakeRotation(0)
            break
            case 4:
                self.chook4.transform = CGAffineTransformMakeRotation(0)
            break
            case 5:
                self.chook5.transform = CGAffineTransformMakeRotation(0)
            break
            case 6:
                self.tab.enabled		= true
            break
            default:
            break;
            
        }
        switch select_chook{
            case 1:
                self.chook1.transform = CGAffineTransformMakeRotation(10)
                break
            case 2:
                self.chook2.transform = CGAffineTransformMakeRotation(10)
                break
            case 3:
                self.chook3.transform = CGAffineTransformMakeRotation(10)
                break
            case 4:
                self.chook4.transform = CGAffineTransformMakeRotation(10)
                break
            case 5:
                self.chook5.transform = CGAffineTransformMakeRotation(10)
                break
            case 6:
                self.tab.enabled		= false
                break
            default:
                break
            
        }
        select_chook = stand
        
    }
    
    
    
    func onTouchUpInsideBtnCapture(){
        elaser.hidden=true
        chook1.hidden=true
        chook2.hidden=true
        chook3.hidden=true
        chook4.hidden=true
        chook5.hidden=true
        tab.hidden=true
        bannerView_.hidden=true
        
        var img:UIImage = takeGrabScreenImage()
        UIImageWriteToSavedPhotosAlbum(img, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        
        elaser.hidden=false
        chook1.hidden=false
        chook2.hidden=false
        chook3.hidden=false
        chook4.hidden=false
        chook5.hidden=false
        tab.hidden=false
        bannerView_.hidden=false
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        if error != nil {
            //プライバシー設定不許可など書き込み失敗時は -3310 (ALAssetsLibraryDataUnavailableError)
            println(error.code)
            
            let alert = UIAlertController(title: "エラー", message: "保存に失敗しました", preferredStyle: UIAlertControllerStyle.Alert)
            let button1 = UIAlertAction(title: "閉じる", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                
            }
            alert.addAction(button1)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }else{
            
            let alert = UIAlertController(title: "成功", message: "保存しました", preferredStyle: UIAlertControllerStyle.Alert)
            let button1 = UIAlertAction(title: "閉じる", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                
            }
            alert.addAction(button1)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //白固定
        self.setPenColor(index: 0)
        
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
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func gotoNext(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

