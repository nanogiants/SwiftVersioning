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
        let plistHandler: PlistHandlerProtocol = PlistHandler(pathToPlist: path)
        
        let version = Version(ngVersion: versionHandler.version,
                              ngBranch: versionHandler.branch,
                              ngMajor: versionHandler.major,
                              ngMinor: versionHandler.minor,
                              ngPatch: versionHandler.patch,
                              ngBuild: versionHandler.build,
                              ngAttachments: versionHandler.attachments)
        
        plistHandler.write(version)

        if verbose {
            print("Checking arguments:")
            print("... path: \(path)")
            print("... append branch: \(branch)")

            print("Checking version:")
            print("...: \(version)")
        }
    }
}
