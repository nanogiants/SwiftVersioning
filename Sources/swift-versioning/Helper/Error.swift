//
// Created by NanoGiants GmbH on 24.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

enum SVError: Error {
    case plistNotFound
    case plistNotReadable
    case plistNotConvertedToDict
    case versionNotConvertedToDict
}
