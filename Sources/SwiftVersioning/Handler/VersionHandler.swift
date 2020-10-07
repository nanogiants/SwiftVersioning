//
// Created by NanoGiants GmbH on 28.08.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation
import Resolver

protocol VersionHandlerProtocol {
    var version: String? { get }
    var major: String? { get }
    var minor: String? { get }
    var patch: String? { get }
    var build: String { get }

    var branch: String { get }
    var branchLong: String { get }
    var branchFlow: String? { get }
}

final class VersionHandler: VersionHandlerProtocol {
    // MARK: - Properties
    
    var version: String?
    var major: String?
    var minor: String?
    var patch: String?
    var build: String { invokeBuildCommand() }

    var branch: String {
        let separator = "/"
        let branchComponents = branchCommandOutput.components(separatedBy: separator)
        if !(branchComponents.count <= 1) {
            branchFlow = branchComponents.first
            return branchComponents[1]
        }
        
        return branchComponents.joined(separator: separator)
    }
    
    var branchLong: String { branchCommandOutput }
    var branchFlow: String?

    // MARK: - Private Properties

    private var tag: String { invokeTagCommand() }
    private lazy var branchCommandOutput: String = {
        invokeBranchCommand()
    }()

    private var tagBits: [String]?
    private var isReleaseCandidate: Bool = false
    private var tool: VersionControlSystem
    
    // MARK: - Dependencies
    
    @Injected private var commandHandler: CommandHandlerProtocol

    // MARK: - Init

    init(for tool: VersionControlSystem) {
        self.tool = tool

        checkVersionControlSystem()
        bootstrap()
    }
    
    private func checkVersionControlSystem() {
        if isVersionControlSystemInstalled() {
            if !isRepository() {
                Log.error("Unable to read version from directory that is not a repository!")
            }
        } else {
            Log.error("\(tool.command) not installed!")
        }
    }

    // MARK: - Setup

    private func bootstrap() {
        setupVersion()
        setupSemantics()
    }

    private func setupVersion() {
        version = tag
        if branch.contains("release/") || branch.contains("hotfix/") {
            version = versionFromBranch()
            isReleaseCandidate = true
        }

        tagBits = version?.components(separatedBy: ".")
    }

    // TODO: for the love of god, use regex
    private func versionFromBranch() -> String {
        branch
            .components(separatedBy: "_")[0]
            .components(separatedBy: "/")[1]
    }

    private func setupSemantics() {
        if let tagBits = tagBits {
            major = !tagBits.isEmpty ? tagBits[0] : nil
            minor = tagBits.count >= 2 ? tagBits[1] : nil
            patch = tagBits.count >= 3 ? tagBits[2] : nil
        } else {
            Log.error("Unable to retrieve semantics from tag.")
        }
    }
}

// MARK: - Command Helper

extension VersionHandler {
    func invokeBuildCommand() -> String {
        commandHandler.invoke(tool.command, with: tool.buildArguments)
    }
    
    func invokeBranchCommand() -> String {
        commandHandler.invoke(tool.command, with: tool.branchArguments)
    }
    
    func invokeTagCommand() -> String {
        commandHandler.invoke(tool.command, with: tool.tagArguments)
    }
    
    func isVersionControlSystemInstalled() -> Bool {
        let whichCommand = "which"
        let whichCommandResult = commandHandler.invoke(whichCommand, with: [tool.command])
        let whichCommandFailureResult = "\(tool.command) not found"
        return whichCommandResult != whichCommandFailureResult
    }
    
    func isRepository() -> Bool {
        commandHandler.invoke(tool.command, with: tool.repositoryCheckArguments) == tool.isRepositoryOutput
    }
}
