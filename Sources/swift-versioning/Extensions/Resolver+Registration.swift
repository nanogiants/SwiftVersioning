//
// Created by NanoGiants GmbH on 22.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { VersionManager() as VersionManagerProtocol }
            .implements(VersionHandlerProtocol.self)
        
        register { VersionHandler(for: .git) as VersionHandlerProtocol }
        register { PlistHandler() as PlistHandlerProtocol }
    }
}
