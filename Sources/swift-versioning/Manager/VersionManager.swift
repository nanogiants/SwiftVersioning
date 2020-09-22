//
// Created by NanoGiants GmbH on 22.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation
import Resolver

struct Version: Codable {
    var NGVersion: String
    var NGBranch: String
    var NGMajor: String?
    var NGMinor: String?
    var NGPatch: String?
    var NGBuild: String
    var NGAttachments: String?
}

protocol VersionManagerProtocol {
    func version(attachBranch: Bool) -> Version
}

final class VersionManager: VersionManagerProtocol {
    // MARK: - Dependencies
    
    @Injected var versionHandler: VersionHandlerProtocol
    
    // MARK: - Methods
    
    func version(attachBranch: Bool) -> Version {
        Version(NGVersion: versionHandler.version,
                NGBranch: versionHandler.branch,
                NGMajor: versionHandler.major,
                NGMinor: versionHandler.minor,
                NGPatch: versionHandler.patch,
                NGBuild: versionHandler.build,
                NGAttachments: versionHandler.attachments)
    }
}
