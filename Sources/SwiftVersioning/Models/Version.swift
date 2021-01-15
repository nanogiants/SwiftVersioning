//
// Created by NanoGiants GmbH on 15.01.21.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

protocol Version: Codable {}

extension Version {
    func dictionary() -> [String: Any]? {
        Log.debug("Converting version to mergable dictionary.")
        do {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml

            Log.debug("... encoding version to data.")
            let data = try encoder.encode(self)
            Log.debug("... converting data to dictionary.")
            let plist = PropertyListSerialization.dictionary(from: data)

            return plist
        } catch {
            Log.error("Unable to encode `Version` to data: \(error)")
            return nil
        }
    }
}
