//
// Created by NanoGiants GmbH on 20.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

public struct Version: Codable {
    var ngVersion: String
    var ngBranch: String
    var ngMajor: String?
    var ngMinor: String?
    var ngPatch: String?
    var ngBuild: String
    var ngAttachments: String?
}

protocol PlistHandlerProtocol {
    func write(_ version: Version)
}

final class PlistHandler: PlistHandlerProtocol {
    // MARK: - Properties
    
    private var pathUrl: URL? = nil
    private var encoder: PropertyListEncoder {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        return encoder
    }
    
    // MARK: - Init
    
    init(pathToPlist: String) {
        if FileManager.default.fileExists(atPath: pathToPlist) {
            self.pathUrl = URL(fileURLWithPath: pathToPlist)
        } else {
            //TODO: error handling
        }
    }
    
    // MARK: - Methode
    
    func write(_ version: Version) {
        if let data = try? encoder.encode(version), let pathUrl = pathUrl {
            try? data.write(to: pathUrl, options: .atomic)
        } else {
            // TODO: handle error
            print("could not encode version")
        }
    }
}
