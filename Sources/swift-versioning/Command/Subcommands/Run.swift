//
// Created by NanoGiants GmbH on 28.08.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import ArgumentParser

struct Run: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: Abstract.SwiftVersioning.run)

    @Argument(help: "\(Help.SwiftVersioning.Run.path)")
    private var path: String

    @Flag(name: .shortAndLong, help: ArgumentHelp(Help.SwiftVersioning.Run.branch, discussion: "", shouldDisplay: true))
    private var branch: Bool = false

    @Flag(name: .long, help: ArgumentHelp(Help.SwiftVersioning.Run.verbose, discussion: "", shouldDisplay: true))
    private var verbose: Bool = false

    func run() throws {
        let gitHandler = GitHandler()

        let majorVersion = gitHandler.majorVersion
        let minorVersion = gitHandler.minorVersion
        let patchVersion = gitHandler.patchVersion

        let buildNumber = gitHandler.buildNumber
        var branchName: String?
        if branch {
            branchName = gitHandler.branchName
        }

        if verbose {
            print("Path: \(path)")
            print("appendBranch: \(branch)")
        }
    }
}
