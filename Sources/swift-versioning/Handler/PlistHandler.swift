//
// Created by NanoGiants GmbH on 20.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

protocol PlistHandlerProtocol {
    func write(_ version: Version, to plistPathString: String)
}

final class PlistHandler: PlistHandlerProtocol {
    // MARK: - Methode
    
    func write(_ version: Version, to plistPathString: String) {
        Log.verbose("Write version:")
        if let plistUrl = plistPathString.validPath() {
            save(version, to: plistUrl)
        }
    }
    
    // MARK: - Private Methods
    
    private func save(_ version: Version, to plistUrl: URL) {
        do {
            if let plistDict = read(plistUrl) {
                if let versionDict = version.dictionary() {
                    let mergedDict = plistDict.merging(versionDict) { (_, new) in new }
                    let mergedData = try PropertyListSerialization.data(fromPropertyList: mergedDict, format: .xml, options: .max)
                    Log.verbose("... beginn writing to plist.")
                    try mergedData.write(to: plistUrl, options: .atomic)
                    Log.verbose("... done!")
                }
            }
        } catch {
            Log.error("Unable to write merged plist and version data to plist: \(error)")
        }
    }
    
    private func read(_ plistUrl: URL) -> [String : Any]? {
        Log.verbose("... reading existing plist.")
        
        if let plist = FileManager.default.contents(atPath: plistUrl.path) {
            return PropertyListSerialization.dictionary(from: plist)
        }

        Log.error("Unable to read content from plist.")
        return nil
    }
}

fileprivate extension String {
    func validPath() -> URL? {
        if FileManager.default.fileExists(atPath: self) {
            let url: URL = URL(fileURLWithPath: self, isDirectory: false)
            if url.pathExtension == "plist" {
                return url
            }
        }

        Log.error("No file at given path.")
        return nil
    }
}
