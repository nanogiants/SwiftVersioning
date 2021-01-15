# SwiftVersioning

[![build](https://github.com/nanogiants/SwiftVersioning/workflows/build/badge.svg)](https://github.com/nanogiants/SwiftVersioning/actions)

A `Swift` command-line tool to add version information from your repository to your Xcode project.

`swiftversioning` extracts specific version information from your git repository and writes them into a given .plist file. The corresponding build can use these information at runtime for advanced version checks or other general applications.

# Installation

## Using [Homebrew](http://brew.sh/):

tbd.

## Compiling from Source:

Installing `swiftversioning` from source only requires cloning this repository and building it for release. Running the following commands will get you there:
```
git clone https://github.com/nanogiants/swiftversioning.git
cd swiftversioning

swift build -c release
cp -f .build/release/swiftversioning /usr/local/bin/swiftversioning
```

# Usage

## Xcode

Integrate `swiftversioning` into your Xcode scheme via adding a new 'Run Script Phase' with:
```
if which swiftversioning >/dev/null; then
  swiftversioning run ${PATH_TO_PLIST}
else
  echo "warning: swiftversioning not installed"
  echo "swiftversioning wasn't installed correctly or couldn't be found, download or reinstall from https://github.com/nanogiants/swiftversioning"
fi
```
Where `${PATH_TO_PLIST}` the path to a .plist file is from which you want to read the freshly saved version information.

## Command Line

tbd.

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

