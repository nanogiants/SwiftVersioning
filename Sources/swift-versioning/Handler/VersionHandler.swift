//
// Created by NanoGiants GmbH on 28.08.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

enum VersioningTool {
    case git

    var command: String {
        switch self {
        case .git:
            return "git"
        }
    }

    var tagArguments: [String] {
        switch self {
        case .git:
            return ["show-ref", "--tags", " | ", "egrep",  "-q", "refs/tags/$1$"]
        }

        git show-ref --tags | egrep -q "refs/tags/$1$"
    }

    var buildArguments: [String] {
        switch self {
        case .git:
            return ["rev-list", "--count", "HEAD"]
        }
    }

    var branchArguments: [String] {
        switch self {
        case .git:
            return ["rev-parse", "--abbrev-ref", "HEAD"]
        }
    }
}

protocol VersionHandlerProtocol {
    var major: String { get }
    var minor: String { get }
    var patch: String { get }
    var build: String { get }
    var branch: String { get }
}

final class VersionHandler: VersionHandlerProtocol {
    // MARK: - Properties

    public var major: String {
        ""
    }

    public var minor: String {
        ""
    }

    public var patch: String {
        ""
    }

    public var build: String {
        launch(command: tool.command, arguments: tool.buildArguments)
    }

    public var branch: String {
        launch(command: tool.command, arguments: tool.branchArguments)
    }

    // MARK: - Private Properties

    private var tag: String {
        launch(command: tool.command, arguments: tool.tagArguments)
    }
    private var tool: VersioningTool

    // MARK: - Init

    init(for tool: VersioningTool) {
        self.tool = tool
    }
}
