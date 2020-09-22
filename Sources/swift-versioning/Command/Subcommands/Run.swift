//
// Created by NanoGiants GmbH on 28.08.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import ArgumentParser
import Resolver

struct Run: ParsableCommand {
    // MARK: - Properties
    
    public static let configuration = CommandConfiguration(abstract: Abstract.SwiftVersioning.run)

    // MARK: - Command
    
    @Argument(help: "\(Help.SwiftVersioning.Run.path)")
    private var path: String

    @Flag(name: .shortAndLong, help: ArgumentHelp(Help.SwiftVersioning.Run.branch, discussion: "", shouldDisplay: true))
    private var branch: Bool = false

    @Flag(name: .long, help: ArgumentHelp(Help.SwiftVersioning.Run.verbose, discussion: "", shouldDisplay: true))
    private var verbose: Bool = false
    
    // MARK: - Run

    func run() throws {
        Log.verbose = verbose
        
        let versionManager: VersionManagerProtocol = Resolver.resolve()
        let plistHandler: PlistHandlerProtocol = Resolver.resolve()
        
        plistHandler.write(versionManager.version(attachBranch: branch), to: path)

        Log.verbose("Checking arguments:")
        Log.verbose("... path: \(path)")
        Log.verbose("... append branch: \(branch)")
    }
}
