//
//  Timer+VGPlayer.swift
//  Ai-Learn
//
//  Created by vmio vmio on 11/7/19.
//  Copyright © 2019 VmioSystem. All rights reserved.
//
import Foundation

extension Timer {
    class func vgPlayer_scheduledTimerWithTimeInterval(_ timeInterval: TimeInterval, block: @escaping ()->(), repeats: Bool) -> Timer {
        return self.scheduledTimer(timeInterval: timeInterval, target:
            self, selector: #selector(self.vgPlayer_blcokInvoke(_:)), userInfo: block, repeats: repeats)
    }
    
    @objc class func vgPlayer_blcokInvoke(_ timer: Timer) {
        let block: ()->() = timer.userInfo as! ()->()
        block()
    }

}

