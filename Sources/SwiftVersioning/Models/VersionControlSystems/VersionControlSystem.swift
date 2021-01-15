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
