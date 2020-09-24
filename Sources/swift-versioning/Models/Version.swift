//
// Created by NanoGiants GmbH on 24.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

struct Version: Codable {
    var version: String
    var branch: String
    var major: String?
    var minor: String?
    var patch: String?
    var build: String
    var attachments: String?
    
    enum CodingKeys: String, CodingKey {
        case version = "NGVersion"
        case branch = "NGBranch"
        case major = "NGMajor"
        case minor = "NGMinor"
        case patch = "NGPatch"
        case build = "NGBuild"
        case attachments = "NGAttachments"
    }
    
    func dictionary() -> [String: Any]? {
        do {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            
            let data = try encoder.encode(self)
            let plist = try PropertyListSerialization.dictionary(from: data)
            
            return plist
        } catch {
            Log.verbose("Error: couldn't read plist: \(error)")
            return nil
        }
    }
}
