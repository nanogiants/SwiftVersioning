//
// Created by NanoGiants GmbH on 24.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

extension PropertyListSerialization {
    class func dictionary(from data: Data) -> [String: Any]? {
        do {
            var format: PropertyListSerialization.PropertyListFormat = .xml
            let options: PropertyListSerialization.MutabilityOptions = .mutableContainersAndLeaves
            let plist: Any = try PropertyListSerialization.propertyList(from: data, options: options, format: &format)
            if let dictionary = plist as? [String: Any] {
                return dictionary
            }
        } catch {
            Log.error("Unable to convert plist file into data: \(error)")
            return nil
        }

        Log.error("Unable to convert plist data into dictionary.")
        return nil
    }
}
