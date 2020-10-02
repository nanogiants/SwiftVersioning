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
    var build: String {
        commandHandler.invoke(tool.command, with: tool.buildArguments)
    }

    var branch: String {
        let separator = "/"
        let branchComponents = branchCommandOutput.components(separatedBy: separator)
        if !(branchComponents.count <= 1) {
            branchFlow = branchComponents.first
            return branchComponents[1]
        }
        
        return branchComponents.joined(separator: separator)
    }
    
    var branchLong: String {
        branchCommandOutput
    }
    
    var branchFlow: String?

    // MARK: - Private Properties

    private var tag: String {
        commandHandler.invoke(tool.command, with: tool.tagArguments)
    }
    
    private lazy var branchCommandOutput: String = {
        commandHandler.invoke(tool.command, with: tool.branchArguments)
    }()

    private var tagBits: [String]?
    private var isReleaseCandidate: Bool = false
    private var tool: VersionControlSystem
    
    // MARK: - Dependencies
    
    @Injected private var commandHandler: CommandHandlerProtocol

    // MARK: - Init

    init(for tool: VersionControlSystem) {
        self.tool = tool

        bootstrap()
    }

    // MARK: - Private Methods

    private func bootstrap() {
        checkVersionControlSystem()
        
        setupVersion()
        setupSemantics()
    }
    
    private func checkVersionControlSystem() {
        let whichCommand = "which"
        let isToolInstalled = commandHandler.invoke(whichCommand, with: [tool.command]) != "\(tool.command) not found"
        let isRepository = commandHandler.invoke(tool.command, with: tool.repositoryCheckArguments) == tool.isRepositoryOutput
        if isToolInstalled {
            if !isRepository {
                Log.error("Unable to read version from directory that is not a repository!")
            }
        } else {
            Log.error("\(tool.command) not installed!")
        }
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
