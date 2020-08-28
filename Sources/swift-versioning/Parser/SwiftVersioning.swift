//
// Created by NanoGiants GmbH on 28.08.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import ArgumentParser

struct SwiftVersioning: ParsableCommand {
    public static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to add git versioning to your Xcode project.",
        subcommands: [Run.self])

    init() {}
}
