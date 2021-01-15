//
// Created by NanoGiants GmbH on 24.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

struct Version: Codable {
    var version: String?
    var versionLong: String?
    var major: String?
    var minor: String?
    var patch: String?
    var build: String?

    var branch: String?
    var branchLong: String?
    var branchFlow: String?

    enum CodingKeys: String, CodingKey {
        case version = "SVVersion"
        case versionLong = "SVVersionLong"
        case major = "SVMajorVersion"
        case minor = "SVMinorVersion"
        case patch = "SVPatchVersion"
        case build = "SVBuildNumber"

        case branch = "SVBranch"
        case branchLong = "SVBranchLong"
        case branchFlow = "SVBranchFlow"
    }

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
