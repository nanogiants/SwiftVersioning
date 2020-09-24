//
// Created by NanoGiants GmbH on 24.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

extension PropertyListSerialization {
    class func dictionary(from data: Data) throws -> [String: Any]? {
        do {
            var format: PropertyListSerialization.PropertyListFormat = .xml
            let options: PropertyListSerialization.MutabilityOptions = .mutableContainersAndLeaves
            let plist: Any = try PropertyListSerialization.propertyList(from: data, options: options, format: &format)
            let dictionary = plist as? [String: Any]
            
            return dictionary
        } catch {
            Log.verbose("Error: couldn't read plist: \(error)")
            return nil
        }
    }
}
