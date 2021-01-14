//
// Created by NanoGiants GmbH on 25.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

public protocol VersionControlSystem {
    var command: String { get }
    var tagArguments: [String] { get }
    var buildArguments: [String] { get }
    var branchArguments: [String] { get }
    var repositoryCheckArguments: [String] { get }
    var isRepositoryOutput: String { get }
}

public struct Git: VersionControlSystem {
    public var command: String {
        "git"
    }

    public var tagArguments: [String] {
        ["describe", "--abbrev=0", "--tags"]
    }

    public var buildArguments: [String] {
        ["rev-list", "--count", "HEAD"]
    }

    public var branchArguments: [String] {
        ["rev-parse", "--abbrev-ref", "HEAD"]
    }
    
    public var repositoryCheckArguments: [String] {
        ["rev-parse", "--git-dir"]
    }
    
    public var isRepositoryOutput: String {
        ".git"
    }
}
