# SwiftVersioning

![swift](https://img.shields.io/badge/Swift-5.2-F16D39.svg?style=flat)
[![spm](https://img.shields.io/badge/Supports-_Swift_Package_Manager-F16D39.svg?style=flat)](https://swift.org/package-manager/)
[![build](https://github.com/nanogiants/SwiftVersioning/workflows/build/badge.svg)](https://github.com/nanogiants/SwiftVersioning/actions)

A `Swift` command-line tool to add version information from your repository to your Xcode project.

`swiftversioning` extracts specific version information from your git repository and writes them into a given .plist file. The corresponding build can use these information at runtime for advanced version checks or other general applications.

# Installation

## Using Swift Package Manager

With Xcode you can add this package using the Swift Package Manager via this link:

```
https://github.com/nanogiants/SwiftVersioning.git
```

You can add this package to your `Package.swift` file, too:

```
```swift
dependencies: [
    .package(url: "https://github.com/nanogiants/SwiftVersioning.git", .from: "1.0.0")
]
```

When integration `SwiftVersioning` via SPM, you can use the following path to the binary:

```
${BUILD_DIR%Build/*}SourcePackages/checkouts/SwiftVersioning/bin/swiftversioning
```

## Compiling from Source:

Installing `swiftversioning` from source only requires cloning this repository and building it for release. Running the following commands will get you there:

```
git clone https://github.com/nanogiants/swiftversioning.git
cd swiftversioning

swift build -c release
cp -f .build/release/swiftversioning /usr/local/bin/swiftversioning
```

When compiling the package from source and adding the binary to your local binaries like above, you are not required to add a
path to the `swiftversioning` call.

```
swiftversioning run ${PATH_TO_PLIST}
```

# Usage

## Xcode

Integrate `swiftversioning` into your Xcode scheme via adding a new 'Run Script Phase' with:

```
if which swiftversioning >/dev/null; then
  ${PATH_TO_BINARY}/swiftversioning run ${PATH_TO_PLIST}
else
  echo "warning: swiftversioning not installed"
  echo "swiftversioning wasn't installed correctly or couldn't be found, download or reinstall from https://github.com/nanogiants/swiftversioning"
fi
```

## Command Line

```
$ swiftversioning
OVERVIEW: A Swift command-line tool to add git versioning to your Xcode project.

USAGE: swiftversioning <subcommand>

OPTIONS:
  -h, --help              Show help information.

SUBCOMMANDS:
  run                     Let swiftversioning run through your repository and add version specifics as new keys to your
                          projects plist.
  bundle                  Let swiftversioning run through your repository, update `CFBundleShortVersionString` and
                          `CFBundleVersion` and add additional branch specifics as new keys to your projects plist.
```

Update bundle information in your .plist and branch specifics as new keys to your projects .plist.

```
$ swiftversioning bundle
OVERVIEW: Let swiftversioning run through your repository, update `CFBundleShortVersionString` and
`CFBundleVersion` and add additional branch specifics as new keys to your projects plist.

USAGE: swiftversioning bundle <path> [--verbose]

ARGUMENTS:
  <path>                  Path to plist.

OPTIONS:
  --verbose               Show extra logging for debugging purposes.
  -h, --help              Show help information.
```

Let  `swiftversioning` run over you .plist and add multiple version and branch information as new keys with `SV` as prefix to it.

```
$ swiftversioning run
OVERVIEW: Let swiftversioning run through your repository and add version specifics as new keys to your projects plist.

USAGE: swiftversioning run <path> [--verbose]

ARGUMENTS:
  <path>                  Path to plist.

OPTIONS:
  --verbose               Show extra logging for debugging purposes.
  -h, --help              Show help information.
```

### Version Specifics

```swift
enum CodingKeys: String, CodingKey {
    case version = "SVVersion" // e.g. 1.0.1
    case versionLong = "SVVersionLong" // e.g. 1.0.1 (5)
    case major = "SVMajorVersion"
    case minor = "SVMinorVersion"
    case patch = "SVPatchVersion"
    case build = "SVBuildNumber"

    case branch = "SVBranch" // e.g. SV-10_update-usage-doc
    case branchLong = "SVBranchLong" // e.g. feature/SV-10_update-usage-doc
    case branchFlow = "SVBranchFlow" // e.g. feature
}
```

# License

```
Copyright (C) 2020 NanoGiants GmbH

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

# About

`swiftversioning` is maintained with :heart: by [NanoGiants GmbH.](https://www.nanogiants.de/)

Say hi on twitter [@wearenanogiants](https://twitter.com/wearenanogiants) or visit our other [open sourced](https://www.github.com/nanogiants/) projects.

