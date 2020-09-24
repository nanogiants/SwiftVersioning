//
// Created by NanoGiants GmbH on 22.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

public struct Log {
    static var verbose: Bool = false
    
    static func info(_ item: String) {
        print(item)
    }
    
    static func verbose(_ item: String) {
        if Log.verbose {
            print(item)
        }
    }
    
    static func debug(_ item: String) {
        debugPrint(item)
    }
}
