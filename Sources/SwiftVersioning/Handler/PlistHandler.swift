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
        Log.debug("Begin writing version to given plist path.")
        if let plistUrl = plistPathString.validPath() {
            save(version, to: plistUrl)
        }
    }

    // MARK: - Private Methods

    private func save(_ version: Version, to plistUrl: URL) {
        Log.debug("Begin saving version to valid plist URL.")
        do {
            if let plistDict = read(plistUrl) {
                if let versionDict = version.dictionary() {
                    Log.debug("... merging plist and version dictionaries.")
                    let mergedDict = plistDict.merging(versionDict) { (_, new) in new }
                    let mergedData = try PropertyListSerialization.data(fromPropertyList: mergedDict, format: .xml, options: .max)
                    Log.debug("... beginn writing to plist.")
                    try mergedData.write(to: plistUrl, options: .atomic)
                    Log.debug("Done!")
                    exit(EXIT_SUCCESS)
                }
            }
        } catch {
            Log.error("Unable to write merged plist and version data to plist: \(error)")
        }
    }

    private func read(_ plistUrl: URL) -> [String : Any]? {
        Log.debug("Reading plist from given URL.")

        if let plist = FileManager.default.contents(atPath: plistUrl.path) {
            Log.debug("... successfully getting content from plist!")
            return PropertyListSerialization.dictionary(from: plist)
        }

        Log.error("Unable to get content from plist.")
        return nil
    }
}

fileprivate extension String {
    func validPath() -> URL? {
        Log.debug("Checking validity of given plist URL.")
        if FileManager.default.fileExists(atPath: self) {
            Log.debug("... file exists!")
            let url: URL = URL(fileURLWithPath: self, isDirectory: false)
            if url.pathExtension == "plist" {
                Log.debug("... file is a plist file!")
                return url
            }
        }

        Log.error("No plist file at given path.")
        return nil
    }
}
