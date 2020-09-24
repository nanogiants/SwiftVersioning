//
// Created by NanoGiants GmbH on 22.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation
import Resolver

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
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        var format: PropertyListSerialization.PropertyListFormat = .xml
        
        do {
            let data = try encoder.encode(self)
            let plist = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: &format)
            if let dict = plist as? [String: Any] {
                return dict
            } else {
                // TODO:
            }
        } catch {
            return nil
        }
        
        return nil
    }
}

protocol VersionManagerProtocol {
    func version() -> Version
}

final class VersionManager: VersionManagerProtocol {
    // MARK: - Dependencies
    
    @Injected var versionHandler: VersionHandlerProtocol
    
    // MARK: - Methods
    
    func version() -> Version {
        Version(version: versionHandler.version,
                branch: versionHandler.branch,
                major: versionHandler.major,
                minor: versionHandler.minor,
                patch: versionHandler.patch,
                build: versionHandler.build,
                attachments: versionHandler.attachments)
    }
}
