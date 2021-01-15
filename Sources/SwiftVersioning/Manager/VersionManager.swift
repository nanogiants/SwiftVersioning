//
// Created by NanoGiants GmbH on 22.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

protocol VersionManagerProtocol {
    func version() -> Version
}

final class VersionManager: VersionManagerProtocol {
    // MARK: - Dependencies

    private var versionHandler: VersionHandlerProtocol

    // MARK: - Init

    init(versionHandler: VersionHandlerProtocol) {
        self.versionHandler = versionHandler
    }

    // MARK: - Methods

    func version() -> Version {
        Version(version: versionHandler.version,
                versionLong: versionLong(),
                major: versionHandler.major,
                minor: versionHandler.minor,
                patch: versionHandler.patch,
                build: versionHandler.build,
                branch: versionHandler.branch,
                branchLong: versionHandler.branchLong,
                branchFlow: versionHandler.branchFlow)
    }

    // MARK: - Private Methods

    private func versionLong() -> String? {
        var versionLong: String?
        if let version = versionHandler.version {
            versionLong = "\(version) (\(versionHandler.build))"
        }

        return versionLong
    }
}
