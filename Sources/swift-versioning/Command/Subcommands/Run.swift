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
        let versionHandler: VersionHandlerProtocol = VersionHandler(for: .git)

        let majorVersion = versionHandler.major
        let minorVersion = versionHandler.minor
        let patchVersion = versionHandler.patch
        let attachments = versionHandler.attachments

        let buildNumber = versionHandler.build
        var branchName: String?
        if branch {
            branchName = versionHandler.branch
        }

        if verbose {
            print("Checking arguments:")
            print("... path: \(path)")
            print("... append branch: \(branch)")

            print("Checking version:")
            print("... majorVersion: \(majorVersion ?? "")")
            print("... minorVersion: \(minorVersion ?? "")")
            print("... patchVersion: \(patchVersion ?? "")")
            print("... patchVersion: \(attachments ?? "")")
            print("... buildNumber: \(buildNumber)")
            print("... branchName: \(branchName ?? "")")
        }
    }
}
