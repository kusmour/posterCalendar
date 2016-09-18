//
//  kuscUIView.swift
//  kuscPosterCalendar
//
//  Created by kusmac on 9/15/16.
//  Copyright © 2016 yip. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 0.7
            // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
            }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: nil)
        // delay 0.5 second
        let seconds = 0.5
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        // hide selection area after selection
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.hidden = true
        })
    }
}