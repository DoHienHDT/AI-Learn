//
//  Memo.swift
//  Ai-Learn
//
//  Created by vMio on 8/21/19.
//  Copyright © 2019 VmioSystem. All rights reserved.
//

import Foundation

class Memo {
    var id: Int
    var title: String
    var content: String
    var link_video: String
    var link_pdf: String
    var lat: String
    var lng: String
    var pin_type: String
    
    init(id: Int, title: String,content: String, link_video: String, link_pdf: String, lat: String, lng: String, pin_type: String) {
        self.id = id
        self.title = title
        self.link_video = link_video
        self.link_pdf = link_pdf
        self.lat = lat
        self.lng = lng
        self.pin_type = pin_type
        self.content = content
    }
}
