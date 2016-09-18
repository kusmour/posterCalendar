//
//  ImageContainerView.swift
//  Neon
//
//  Created by Mike on 9/26/15.
//  Copyright © 2015 Mike Amaral. All rights reserved.
//

import UIKit
import Neon

class ImageContainerView: UIView {
    let imageView : UIImageView = UIImageView()
    let label : UILabel = UILabel()

    convenience init() {
        self.init(frame: CGRectZero)

        self.backgroundColor = UIColor.whiteColor()
//        self.layer.cornerRadius = 4.0
//        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(white: 0.68, alpha: 1.0).CGColor
        self.clipsToBounds = true

//        imageView.contentMode = .ScaleAspectFill
        imageView.contentMode = .ScaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.image = resizeImage(imageView.image!, targetSize: CGSizeMake(20.0, 20.0))
        self.addSubview(imageView)

//        label.textAlignment = .Center
//        label.textColor = UIColor.blackColor()
//        label.font = UIFont.boldSystemFontOfSize(14.0)
//        self.addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imageView.anchorAndFillEdge(.Top, xPad: 0, yPad: 0, otherSize: self.height)
//        label.alignAndFill(align: .UnderCentered, relativeTo: imageView, padding: 0)
    }
    
    // resize the image to target size
    //    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    //        let size = image.size
    //
    //        let widthRatio  = targetSize.width  / image.size.width
    //        let heightRatio = targetSize.height / image.size.height
    //
    //        // Figure out what our orientation is, and use that to form the rectangle
    //        var newSize: CGSize
    //        if(widthRatio > heightRatio) {
    //            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
    //        } else {
    //            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
    //        }
    //
    //        // This is the rect that we've calculated out and this is what is actually used below
    //        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
    //
    //        // Actually do the resizing to the rect using the ImageContext stuff
    //        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    //        image.drawInRect(rect)
    //        let newImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //        
    //        return newImage
    //    }
}

