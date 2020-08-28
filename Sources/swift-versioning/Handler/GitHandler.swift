//
// Created by NanoGiants GmbH on 28.08.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

final class GitHandler {
    // MARK: - Properties

    public var majorVersion: String {
        ""
    }

    public var minorVersion: String {
        ""
    }

    public var patchVersion: String {
        ""
    }

    public var buildNumber: String {
        launch(command: "git", arguments: ["rev-list", "--count", "HEAD"])
    }

    public var branchName: String {
        launch(command: "git", arguments: ["rev-parse", "--abbrev-ref", "HEAD"])
    }

    // MARK: - Private Properties

    private var tag: String

    // MARK: - Init

    init() {
        // get tag
    }
}
