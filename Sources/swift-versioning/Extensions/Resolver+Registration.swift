//
// Created by NanoGiants GmbH on 22.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { CommandHandler() as CommandHandlerProtocol }
        register { VersionHandler(for: Git()) as VersionHandlerProtocol }
        register { PlistHandler() as PlistHandlerProtocol }
        register { VersionManager() as VersionManagerProtocol }
    }
}
