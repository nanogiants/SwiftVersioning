//
// Created by NanoGiants GmbH on 15.01.21.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

struct BundleVersion: Codable, Version {
    var bundleShortVersion: String?
    var bundleBuildVersion: String?

    var branch: String?
    var branchLong: String?
    var branchFlow: String?

    enum CodingKeys: String, CodingKey {
        case bundleShortVersion = "CFBundleShortVersionString"
        case bundleBuildVersion = "CFBundleVersion"

        case branch = "SVBranch"
        case branchLong = "SVBranchLong"
        case branchFlow = "SVBranchFlow"
    }
}
