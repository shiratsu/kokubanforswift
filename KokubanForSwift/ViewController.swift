//
//  ViewController.swift
//  KokubanForSwift
//
//  Created by HIRATSUKA SHUNSUKE on 2014/10/21.
//  Copyright (c) 2014年 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
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
    var penWhite:CGFloat = 0
    var penRed:CGFloat = 0
    var penYellow:CGFloat = 0
    var penBlue:CGFloat = 0
    var penBlack:CGFloat = 0
    var penGreen:CGFloat = 0
    var penAlpha:CGFloat = 0
    var select_chook:Int = 0
    var lineDepth: Int = 1
    var kokubanMode:Bool = true
    var billingMode:Bool = true
    var yukiMode:Bool = true
    var aryPastStroke:NSMutableArray = NSMutableArray(array: [])
    var aryStroke:NSMutableArray = NSMutableArray(array: [])
    var sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    

    
    func setPenColor(index idx:NSInteger){
        let components:[CGFloat] = [
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
        Allstand(stand: 1)
        setPenColor(index: 0)
        kokubanMode = true
    }
    @IBAction func chook2(sender: AnyObject) {
        Allstand(stand: 2)
        setPenColor(index: 1)
        kokubanMode = true
    }
    @IBAction func chook3(sender: AnyObject) {
        Allstand(stand: 3)
        setPenColor(index: 2)
        kokubanMode = true
    }
    @IBAction func chook4(sender: AnyObject) {
        Allstand(stand: 4)
        setPenColor(index: 3)
        kokubanMode = true
    }
    @IBAction func chook5(sender: AnyObject) {
        Allstand(stand: 5)
        setPenColor(index: 4)
        kokubanMode = true
        
    }
    
    func elase() {
        Allstand(stand: 10)
        setPenColor(index: 5)
        kokubanMode = true
        
    }
    @IBAction func showEraseSheet(sender: AnyObject) {
        
        let alert = UIAlertController(title: "どうする？？", message: nil, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "一つ前に戻る", style: UIAlertAction.Style.default) { [self] (okSelected) -> Void in
            print("Ok Selected")
            kokubanMode = true
            if self.aryStroke.count > 0 {
                aryStroke.removeLastObject()
                pastDrawingView.aryData = aryStroke
                pastDrawingView.setNeedsDisplay()
            }
            
        }
        let cancelButton = UIAlertAction(title: "全消し", style: UIAlertAction.Style.cancel) { [self] (cancelSelected) -> Void in
            print("Cancel Selected")
            
            kokubanMode = true
            if aryStroke.count > 0 {
                aryStroke.removeAllObjects()
                pastDrawingView.aryData = aryStroke
                pastDrawingView.setNeedsDisplay()
            }
        }
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
        
    }
    @IBAction func showActionSheet(sender: AnyObject) {
        if !billingMode {
            let alert = UIAlertController(title: "どうする？？", message: nil, preferredStyle: UIAlertController.Style.alert)
            let button1 = UIAlertAction(title: "写真を選ぶ", style: UIAlertAction.Style.default) { (okSelected) -> Void in
                self.selectLibraly()
                
                
            }
            let button2 = UIAlertAction(title: "ライブラリに保存", style: UIAlertAction.Style.default) { (okSelected) -> Void in
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                self.onTouchUpInsideBtnCapture()
            }
            let button3 = UIAlertAction(title: "黒板を表示", style: UIAlertAction.Style.default) { [self] (okSelected) -> Void in
                let myBoundSize: CGSize = UIScreen.main.bounds.size
                aImageView.frame = CGRect(x:0, y:0, width: myBoundSize.width, height:myBoundSize.height)
                aImageView.image = UIImage(named: "back.png")
            }
            let button4 = UIAlertAction(title: "ひまわり", style: UIAlertAction.Style.default) { [self] (okSelected) -> Void in
                kokubanMode = false
                yukiMode = true
            }
            let button5 = UIAlertAction(title: "チョークを使う", style: UIAlertAction.Style.default) { [self] (okSelected) -> Void in
                kokubanMode = true
                yukiMode = false
            }
            let button6 = UIAlertAction(title: "線の太さを変える", style: UIAlertAction.Style.default) { (okSelected) -> Void in
                
            }
            let button7 = UIAlertAction(title: "黒板の有料版を購入", style: UIAlertAction.Style.default) { (okSelected) -> Void in
                
            }
    
            alert.addAction(button1)
            alert.addAction(button2)
            alert.addAction(button3)
            alert.addAction(button4)
            alert.addAction(button5)
            alert.addAction(button6)
            alert.addAction(button7)
            
            present(alert, animated: true, completion: nil)
            
            
        }else{
            let alert = UIAlertController(title: "どうする？？", message: nil, preferredStyle: UIAlertController.Style.alert)
            let button1 = UIAlertAction(title: "写真を選ぶ", style: UIAlertAction.Style.default) { [self] (okSelected) -> Void in
                selectLibraly()
                
            }
            let button2 = UIAlertAction(title: "ライブラリに保存", style: UIAlertAction.Style.default) { [self] (okSelected) -> Void in
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                onTouchUpInsideBtnCapture()
                
            }
            let button3 = UIAlertAction(title: "黒板を表示", style: UIAlertAction.Style.default) { [self] (okSelected) -> Void in
                let myBoundSize: CGSize = UIScreen.main.bounds.size
                aImageView.frame = CGRect(x:0, y:0, width: myBoundSize.width, height: myBoundSize.height)
                aImageView.image = UIImage(named: "back.png")
            }
            let button4 = UIAlertAction(title: "ひまわり", style: UIAlertAction.Style.default) { [self] (okSelected) -> Void in
                kokubanMode = false
                yukiMode = true
                
            }
            let button5 = UIAlertAction(title: "チョークを使う", style: UIAlertAction.Style.default) { [self] (okSelected) -> Void in
                kokubanMode = true
                yukiMode = false
                
            }
            let button6 = UIAlertAction(title: "線の太さを変える", style: UIAlertAction.Style.default) { (okSelected) -> Void in
                
            }
            
            
            alert.addAction(button1)
            alert.addAction(button2)
            alert.addAction(button3)
            alert.addAction(button4)
            alert.addAction(button5)
            alert.addAction(button6)
            
            
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func selectLibraly() {
        sourceType = UIImagePickerController.SourceType.photoLibrary
        
        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
            return
        }
        
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func takeGrabScreenImage() -> UIImage {
        UIGraphicsBeginImageContext(aImageView.frame.size)
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    
    func Allstand(stand:Int){
        
        switch select_chook{
            case 1:
                chook1.transform = CGAffineTransform(rotationAngle: 0)
            break
            case 2:
                chook2.transform = CGAffineTransform(rotationAngle: 0)
            break
            case 3:
                chook3.transform = CGAffineTransform(rotationAngle: 0)
            break
            case 4:
                chook4.transform = CGAffineTransform(rotationAngle: 0)
            break
            case 5:
                chook5.transform = CGAffineTransform(rotationAngle: 0)
            break
            case 6:
                tab.isEnabled		= true
            break
            default:
            break;
            
        }
        switch stand{
            case 1:
                chook1.transform = CGAffineTransform(rotationAngle: 10)
                break
            case 2:
                chook2.transform = CGAffineTransform(rotationAngle: 10)
                break
            case 3:
                chook3.transform = CGAffineTransform(rotationAngle: 10)
                break
            case 4:
                chook4.transform = CGAffineTransform(rotationAngle: 10)
                break
            case 5:
                chook5.transform = CGAffineTransform(rotationAngle: 10)
                break
            case 6:
                tab.isEnabled		= false
                break
            default:
                break
            
        }
        select_chook = stand
        
    }
    
    
    
    func onTouchUpInsideBtnCapture(){
        elaser.isHidden=true
        chook1.isHidden=true
        chook2.isHidden=true
        chook3.isHidden=true
        chook4.isHidden=true
        chook5.isHidden=true
        tab.isHidden=true
        
        let img:UIImage = takeGrabScreenImage()
        UIImageWriteToSavedPhotosAlbum(img, self, Selector(("image:didFinishSavingWithError:contextInfo:")), nil)
        
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        
        elaser.isHidden=true
        chook1.isHidden=true
        chook2.isHidden=true
        chook3.isHidden=true
        chook4.isHidden=true
        chook5.isHidden=true
        tab.isHidden=true

        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if error != nil {
            //プライバシー設定不許可など書き込み失敗時は -3310 (ALAssetsLibraryDataUnavailableError)
            print(error.code)
            
            let alert = UIAlertController(title: "エラー", message: "保存に失敗しました", preferredStyle: UIAlertController.Style.alert)
            let button1 = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.default) { (okSelected) -> Void in
                
            }
            alert.addAction(button1)
            present(alert, animated: true, completion: nil)
            
        }else{
            
            let alert = UIAlertController(title: "成功", message: "保存しました", preferredStyle: UIAlertController.Style.alert)
            let button1 = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.default) { (okSelected) -> Void in
                
            }
            alert.addAction(button1)
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //白固定
        setPenColor(index: 0)
        
        kokubanMode = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func gotoNext(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if kokubanMode{
            stockStroke(touches)
        }else{
            
        }
    }
    
    func stockStroke(_ touches: Set<UITouch>){
        
        let touch: UITouch? = touches.first
        let point = touch?.location(in: curDrawingView)
        
        if touch?.view != curDrawingView{
            return
            
        }
        
        switch touch?.phase {
        case .began:
            aryStroke = NSMutableArray(array: [])
            aryStroke.add(NSNumber(value: Float(penRed)))
            aryStroke.add(NSNumber(value: Float(penGreen)))
            aryStroke.add(NSNumber(value: Float(penBlue)))
            aryStroke.add(NSNumber(value: Float(penAlpha)))
            aryStroke.add(NSNumber(value: lineDepth))
            aryStroke.add(NSNumber(value: Float(point?.x ?? 0)))
            aryStroke.add(NSNumber(value: Float(point?.y ?? 0)))
            break
        case .moved:
            if aryStroke.count > 0 {
                // 移動先の点を置く
                aryStroke.add(NSNumber(value: Float(point?.x ?? 0)))
                aryStroke.add(NSNumber(value: Float(point?.y ?? 0)))
            }
        case .stationary:
            break
        case .ended:
            drawActionEnded(point: point)
            break
        case .cancelled:
            drawActionEnded(point: point)
            break
        default:
            drawActionEnded(point: point)
            break
        }
        curDrawingView.aryData = aryStroke
        curDrawingView.setNeedsDisplay()
    }
    
    
    /// 描画アクションを終わらせる
    func drawActionEnded(point: CGPoint?){
        if aryStroke.count > 0 {
            aryStroke.add(NSNumber(value: Float(point?.x ?? 0)))
            aryStroke.add(NSNumber(value: Float(point?.y ?? 0)))
            
            // 過去分を蓄積
            aryPastStroke.add(aryStroke)
            
            aryStroke = NSMutableArray(array: [])
            pastDrawingView.aryData = aryPastStroke
            pastDrawingView.setNeedsDisplay()
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if kokubanMode{
            stockStroke(touches)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if kokubanMode{
            stockStroke(touches)
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if kokubanMode{
            stockStroke(touches)
        }
        
    }

}

