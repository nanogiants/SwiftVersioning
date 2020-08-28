//
// Created by NanoGiants GmbH on 28.08.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import ArgumentParser

struct Run: ParsableCommand {
    public static let configuration = CommandConfiguration(
        abstract: "Let the tool run through your repository and add specifics to your apps plist.")

    @Argument(help: "Path to plist.")
    private var path: String

    @Flag(name: .shortAndLong, help: "Append branch name of the current head branch.")
    private var branch: Bool = false

    @Flag(name: .long, help: "Show extra logging for debugging purposes.")
    private var verbose: Bool = false

    func run() throws {
        if verbose {
            print("Path: \(path)")
            print("appendBranch: \(branch)")
        }
    }
}
