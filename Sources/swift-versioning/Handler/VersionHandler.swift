//
// Created by NanoGiants GmbH on 28.08.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

protocol VersionHandlerProtocol {
    var version: String { get }
    var branch: String { get }
    
    var major: String? { get }
    var minor: String? { get }
    var patch: String? { get }
    var attachments: String? { get }
    var build: String { get }
}

final class VersionHandler: VersionHandlerProtocol {
    // MARK: - Properties
    
    public var version: String { tag }

    public var major: String? {
        if !tagBits.isEmpty {
            return tagBits[0]
        }

        return nil
    }

    public var minor: String? {
        if tagBits.count > 1 {
            return tagBits[1]
        }

        return nil
    }

    public var patch: String? {
        if tagBits.count > 2 {
            return tagBits[2].components(separatedBy: "_").first
        }

        return nil
    }

    public var attachments: String? {
        if tagBits.count > 2 {
            var attArray = tagBits[2].components(separatedBy: "_")
            attArray.removeFirst()
            return attArray.joined(separator: "_")
        }

        return nil
    }

    public var build: String { launch(command: tool.command, arguments: tool.buildArguments) }
    public var branch: String { launch(command: tool.command, arguments: tool.branchArguments) }

    // MARK: - Private Properties

    private var tag: String { launch(command: tool.command, arguments: tool.tagArguments) }
    private var tagBits: [String] { tag.components(separatedBy: ".") }

    private var tool: VersionControlSystem

    // MARK: - Init

    init(for tool: VersionControlSystem) {
        self.tool = tool
    }
}
