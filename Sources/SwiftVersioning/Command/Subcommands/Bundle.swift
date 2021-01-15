//
// Created by NanoGiants GmbH on 15.01.21.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import ArgumentParser

struct Bundle: ParsableCommand {
    // MARK: - Properties

    public static let configuration = CommandConfiguration(abstract: Abstract.SwiftVersioning.bundle)

    // MARK: - Command

    @Argument(help: "\(Help.SwiftVersioning.Bundle.path)")
    private var path: String

    @Flag(name: .long, help: ArgumentHelp(Help.SwiftVersioning.General.verbose, discussion: "", shouldDisplay: true))
    private var verbose: Bool = false

    // MARK: - Run

    func run() throws {
        Log.isVerbose = verbose
        Log.debug("Checking arguments:")
        Log.debug("... path: \(path)")
        Log.debug("... verbose: \(verbose)")

        let versionHandler: VersionHandlerProtocol = VersionHandler(
            commandHandler: CommandHandler(),
            for: Git()
        )
        let versionManager: VersionManagerProtocol = VersionManager(versionHandler: versionHandler)
        let plistHandler: PlistHandlerProtocol = PlistHandler()

        plistHandler.write(versionManager.bundleVersion(), to: path)
    }
}
