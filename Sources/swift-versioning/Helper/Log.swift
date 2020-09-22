//
// Created by NanoGiants GmbH on 22.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

public struct Log {
    static var verbose: Bool = false
    
    static func verbose(_ items: Any...) {
        if Log.verbose {
            print(items)
        }
    }
}
