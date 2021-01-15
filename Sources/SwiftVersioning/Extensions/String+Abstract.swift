//
// Created by NanoGiants GmbH on 28.08.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

internal enum Abstract {
    internal static let swiftVersioning = "A Swift command-line tool to add git versioning to your Xcode project."
    internal enum SwiftVersioning {
        internal static let run = "Let swiftversioning run through your repository and add specifics as new keys to your projects plist."
        internal static let bundle = "Let swiftversioning run through your repository, update `CFBundleShortVersionString` and `CFBundleVersion` and add new version specifics as new keys to your projects plist."
    }
}
