//
// Created by NanoGiants GmbH on 22.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation
import Resolver

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
