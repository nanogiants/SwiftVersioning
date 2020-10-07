# swift-versioning

A `Swift` command-line tool to add version information from your repository to your Xcode project.

`swift-versioning` extracts specific version information from your git repository and writes them into a given .plist file. The corresponding build can use these information at runtime for advanced version checks or other general applications.

# Installation

## Using [Homebrew](http://brew.sh/):

tbd.

## Compiling from Source:

Installing `swift-versioning` from source only requires cloning this repository and building it for release. Running the following commands will get you there:
```
git clone https://github.com/nanogiants/swift-versioning.git
cd swift-versioning

swift build -c release
cp -f .build/release/swift-versioning /usr/local/bin/swift-versioning
```

# Usage

## Xcode

Integrate `swift-versioning` into your Xcode scheme via adding a new 'Run Script Phase' with:
```
if which swift-versioning >/dev/null; then
  swift-versioning run ${PATH_TO_PLIST}
else
  echo "warning: swift-versioning not installed"
  echo "swift-versioning wasn't installed correctly or couldn't be found, download or reinstall from https://github.com/nanogiants/swift-versioning"
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

`swift-versioning` is maintained with :heart: by [NanoGiants GmbH.](https://www.nanogiants.de/)

Say hi on twitter [@wearenanogiants](https://twitter.com/wearenanogiants) or visit our other [open sourced](https://www.github.com/nanogiants/) projects.

