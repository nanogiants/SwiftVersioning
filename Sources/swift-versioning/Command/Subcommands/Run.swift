//
// Created by NanoGiants GmbH on 28.08.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import ArgumentParser

struct Run: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: Abstract.SwiftVersioning.run)

    @Argument(help: ArgumentHelp.SwiftVersioning.Run.path)
    private var path: String

    @Flag(name: .shortAndLong, help: ArgumentHelp.SwiftVersioning.Run.branch)
    private var branch: Bool = false

    @Flag(name: .long, help: ArgumentHelp.SwiftVersioning.Run.verbose)
    private var verbose: Bool = false

    func run() throws {
        if verbose {
            print("Path: \(path)")
            print("appendBranch: \(branch)")
        }
    }
}
