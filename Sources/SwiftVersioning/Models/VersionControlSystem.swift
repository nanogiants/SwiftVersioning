//
// Created by NanoGiants GmbH on 25.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

protocol VersionControlSystem {
    var command: String { get }
    var tagArguments: [String] { get }
    var buildArguments: [String] { get }
    var branchArguments: [String] { get }
    var repositoryCheckArguments: [String] { get }
    var isRepositoryOutput: String { get }
}

struct Git: VersionControlSystem {
    var command: String {
        "git"
    }

    var tagArguments: [String] {
        ["describe", "--abbrev=0", "--tags"]
    }

    var buildArguments: [String] {
        ["rev-list", "--count", "HEAD"]
    }

    var branchArguments: [String] {
        ["rev-parse", "--abbrev-ref", "HEAD"]
    }
    
    var repositoryCheckArguments: [String] {
        ["rev-parse", "--git-dir"]
    }
    
    var isRepositoryOutput: String {
        ".git"
    }
}
