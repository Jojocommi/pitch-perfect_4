//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jojo Commi on 3/16/15.
//  Copyright (c) 2015 Jojocommi. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathURL: NSURL!
    var title: String
    
    init (filePathURL: NSURL,title: String){
    self.filePathURL = filePathURL
    self.title = title
    }
}

