![HBC Digital logo](https://raw.githubusercontent.com/gilt/Cleanroom/master/Assets/hbc-digital-logo.png)     
![Gilt Tech logo](https://raw.githubusercontent.com/gilt/Cleanroom/master/Assets/gilt-tech-logo.png)

# CleanroomCLI

Tools for handling command line arguments in Swift.

CleanroomCLI is part of [the Cleanroom Project](https://github.com/gilt/Cleanroom) from [Gilt Tech](http://tech.gilt.com).


### Swift compatibility

This is the `master` branch. It uses **Swift 4.0** and **requires Xcode 9.0** to compile.


#### Current status

Branch|Build status
--------|------------------------
[`master`](https://github.com/emaloney/CleanroomCLI)|[![Build status: master branch](https://travis-ci.org/emaloney/CleanroomCLI.svg?branch=master)](https://travis-ci.org/emaloney/CleanroomCLI)


### License

CleanroomCLI is distributed under [the MIT license](https://github.com/emaloney/CleanroomCLI/blob/master/LICENSE).

CleanroomCLI is provided for your use—free-of-charge—on an as-is basis. We make no guarantees, promises or apologies. *Caveat developer.*


### Adding CleanroomCLI to your project

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

The simplest way to integrate CleanroomCLI is with the [Carthage](https://github.com/Carthage/Carthage) dependency manager.

First, add this line to your [`Cartfile`](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile):

```
github "emaloney/CleanroomCLI" ~> 0.4.0
```

Then, use the `carthage` command to [update your dependencies](https://github.com/Carthage/Carthage#upgrading-frameworks).

Finally, you’ll need to [integrate CleanroomCLI into your project](https://github.com/emaloney/CleanroomCLI/blob/master/INTEGRATION.md) in order to use [the API](https://rawgit.com/emaloney/CleanroomCLI/master/Documentation/API/index.html) it provides.

Once successfully integrated, just add the following statement to any Swift file where you want to use CleanroomCLI:

```swift
import CleanroomCLI
```

See [the Integration document](https://github.com/emaloney/CleanroomCLI/blob/master/INTEGRATION.md) for additional details on integrating CleanroomCLI into your project.

### API documentation

For detailed information on using CleanroomCLI, [API documentation](https://rawgit.com/emaloney/CleanroomCLI/master/Documentation/API/index.html) is available.


## About

The Cleanroom Project began as an experiment to re-imagine Gilt’s iOS codebase in a legacy-free, Swift-based incarnation.

Since then, we’ve expanded the Cleanroom Project to include multi-platform support. Much of our codebase now supports tvOS in addition to iOS, and our lower-level code is usable on macOS and watchOS as well.

Cleanroom Project code serves as the foundation of Gilt on TV, our tvOS app [featured by Apple during the launch of the new Apple TV](http://www.apple.com/apple-events/september-2015/). And as time goes on, we'll be replacing more and more of our existing Objective-C codebase with Cleanroom implementations.

In the meantime, we’ll be tracking the latest releases of Swift & Xcode, and [open-sourcing major portions of our codebase](https://github.com/gilt/Cleanroom#open-source-by-default) along the way.


### Contributing

CleanroomCLI is in active development, and we welcome your contributions.

If you’d like to contribute to this or any other Cleanroom Project repo, please read [the contribution guidelines](https://github.com/gilt/Cleanroom#contributing-to-the-cleanroom-project). If you have any questions, please reach out to project owner [Paul Lee](http://github.com/pauljlee).


### Acknowledgements

API documentation is generated using [Realm](http://realm.io)’s [jazzy](https://github.com/realm/jazzy/) project, maintained by [JP Simard](https://github.com/jpsim) and [Samuel E. Giddins](https://github.com/segiddins).
