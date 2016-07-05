//
//  ViewController.swift
//  selectImageView
//
//  Created by Eriko Ichinohe on 2016/07/04.
//  Copyright © 2016年 Eriko Ichinohe. All rights reserved.
//

import UIKit
import QBImagePickerController

class ViewController: UIViewController,QBImagePickerControllerDelegate {

    //画面に表示するためひとまず4つ設置
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    var imagecount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func tapBtn(sender: UIButton) {
        
        let picker = QBImagePickerController()
        picker.delegate = self
        
        picker.allowsMultipleSelection = true;
//        picker.minimumNumberOfSelection = 1;
//        picker.maximumNumberOfSelection = 1;
        
        picker.assetCollectionSubtypes = [
            PHAssetCollectionSubtype.SmartAlbumUserLibrary.rawValue,
            PHAssetCollectionSubtype.AlbumMyPhotoStream.rawValue
        ];
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func qb_imagePickerController(imagePickerController: QBImagePickerController, didFinishPickingAssets assets: [AnyObject]) {
        
        imagecount = 0
        for asset in assets {
            var asset_each = asset as! PHAsset
            imagecount++
            //URL取得の場合
            print(asset_each.description)
            
            let urlArray = asset_each.description.componentsSeparatedByString("/")
            
            let urlArray2 = urlArray[0].componentsSeparatedByString(" ")
            
            let assetURL = "assets-library://asset/asset.JPG?id="+urlArray2[2]+"&ext=JPG"
            print(assetURL)
            
            //画像表示の場合
            let manager: PHImageManager = PHImageManager()
            manager.requestImageForAsset(asset as! PHAsset,targetSize: CGSizeMake(200, 200),contentMode: .AspectFit,options: nil) { (image, info) -> Void in
                
                switch self.imagecount {
                case 1:
                    self.imageView1.image = image
                    break
                case 2:
                    self.imageView2.image = image
                    break
                case 3:
                    self.imageView3.image = image
                    break
                case 4:
                    self.imageView4.image = image
                    break
                default:
                    break
                }
                
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

