//
//  DataViewController.swift
//  kuscPosterCalendar
//
//  Created by kusmac on 9/15/16.
//  Copyright © 2016 yip. All rights reserved.
//

import UIKit
import Neon
import SideMenu

class DataViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let dataLabel: UILabel = UILabel()
    var dataObject: String = ""
    var year: Int = 2016
    @IBOutlet weak var button: UIButton!
    
    // MARK: - Top - Photo Display Area - Square
    
//    let photo: UIImageView = UIImageView()
    let photo: ImageContainerView = ImageContainerView()
    let calendar: ImageContainerView = ImageContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // MARK: - set photo
        photo.imageView.image = UIImage(named: dataObject)
        self.view.addSubview(photo)
        
        // MARK: - Load Photo
        
        let gesture0 = UITapGestureRecognizer(target: self, action: Selector("loadPhoto:"))
        self.photo.addGestureRecognizer(gesture0)
        
        
        calendar.imageView.image = UIImage(named: dataObject + "-cal")
        self.view.addSubview(calendar)
        
        dataLabel.backgroundColor = UIColor.lightGrayColor()
        dataLabel.alpha = 0.7
        dataLabel.clipsToBounds = true
        dataLabel.layer.cornerRadius = 10.0
        dataLabel.textAlignment = .Center
        dataLabel.textColor = UIColor.blackColor()
        dataLabel.font = UIFont.boldSystemFontOfSize(16.0)
        self.view.addSubview(dataLabel)
        self.view.bringSubviewToFront(dataLabel)
        
        let gesture1 = UITapGestureRecognizer(target: self, action: Selector("showLabel:"))
        self.view.addGestureRecognizer(gesture1)
        
        self.view.bringSubviewToFront(button)
        
        
        // MARK: - Long Press to Save
        
        let longpressGesutre = UILongPressGestureRecognizer(target: self, action: "downloadSheet:")
        // press time 0.5 sec
        longpressGesutre.minimumPressDuration = 0.5
        // allow 15 sec movement
        longpressGesutre.allowableMovement = 15
        // number of touch
        longpressGesutre.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(longpressGesutre)
        
//        init(rootViewController: UIViewController)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //
        // MARK: - Sidebar Menu Settings
        
        // Define the menus
        let menuLeftNavigationController = UISideMenuNavigationController()
        menuLeftNavigationController.leftSide = true
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration of it here like setting its viewControllers.
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // load layout with Neon
        layoutFrames()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel.text = dataObject
    }
    
    func layoutFrames() {
        let height = self.view.frame.width
        photo.anchorAndFillEdge(.Top, xPad: 0, yPad: 0, otherSize: height)
        calendar.align(.UnderCentered, relativeTo: photo, padding: 0, width: self.view.frame.width - 40, height: 200)
        dataLabel.anchorToEdge(.Top, padding: 50, width: height - 160, height: 30)
    }
    
    func showLabel(sender: AnyObject) {
        if dataLabel.hidden == true {
            dataLabel.fadeIn()
            dataLabel.hidden = false
        } else {
            dataLabel.fadeOut()
//            dataLabel.hidden = true
        }
    }
    
    func downloadSheet(sender: AnyObject)
    {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
//        let saveAction = UIAlertAction(title: "Save", style: .Default, handler:
//            {
//                (alert: UIAlertAction!) -> Void in
//                print("Saved\n")
//        })
        
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler:
            {
                (alert: UIAlertAction!) -> Void in
                self.savePhoto()
                print("Saved\n")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler:
            {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled\n")
        })
        
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    // save photo
    func savePhoto() {
        dataLabel.hidden = true
        // get the screenshot
        screenShotMethod()
        // show result after saving action
        showActionResult(1)
    }
    
    // get current screenshot
    func screenShotMethod() {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
    }
    
    func showActionResult(messageType: Int) {
        var alert = UIAlertController(title: "Image Saved", message: "", preferredStyle: .Alert)
        
            let cancelAction = UIAlertAction(title: "Close",
                style: .Default) { (action: UIAlertAction) -> Void in
            }
        
            alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Load Photo
    
    func loadPhoto(sender: AnyObject) {
//        print("Load Photo\n")
        openPhotoLibrary()
    }
    
    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        photo.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
}
