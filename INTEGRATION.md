![Gilt Tech logo](https://raw.githubusercontent.com/gilt/Cleanroom/universal-framework/Assets/gilt-tech-logo.png)

# CleanroomCLI Integration Notes

This document describes how to integrate CleanroomCLI into your application.

CleanroomCLI is designed as a *universal Swift framework* with support for the following platforms within a single binary:

Platform|Latest supported OS|Oldest supported OS
--------|-------------------|-------------------
iPhone/iPad|iOS 10.0|iOS 8.0
Macintosh|macOS 10.12|macOS 10.10
Apple TV|tvOS 10.0|tvOS 9.0
Apple Watch|watchOS 3.0|watchOS 2.0

**This is the `universal-framework` branch of CleanroomCLI.** It uses **Swift 3.0** and **requires Xcode 8** to compile.

### Options for integration

There are two supported options for integration:

- **[Carthage integration](#carthage-integration)** uses the [Carthage](https://github.com/Carthage/Carthage) dependency manager to add CleanroomCLI to your project.

- **[Manual integration](#manual-integration)** involves embedding the `CleanroomCLI.xcodeproj` file within your project’s Xcode workspace.

## Carthage Integration

Carthage is a third-party package dependency manager for Apple platforms. As of this writing, the current supported version of Carthage is 0.17.2.

Installing and using Carthage is beyond the scope of this document. If you do not have Carthage installed but would like to use it, [you can find installation instructions on the project page](https://github.com/Carthage/Carthage#installing-carthage). 

### 1. Add CleanroomCLI to Cartfile

Within to your project’s root directory, Carthage-based projects will store a file named "[`Cartfile`](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile)".

To integrate CleanroomCLI in your workspace, you would start by adding the following line to the `Cartfile`:

```
github "emaloney/CleanroomCLI" ~> 0.1.0
```

This specifies that Carthage use the latest version of CleanroomCLI that is API-compatible with 0.1, i.e. any 0.1.*x* version.

**Note:** Be sure to check the [latest releases](https://github.com/emaloney/CleanroomCLI/releases); there may be a newer version than 0.1 that is no longer API-compatible.

### 2. Download CleanroomCLI using Carthage

Once added to your `Cartfile`, you can use Carthage to download CleanroomCLI to your machine:

```
carthage bootstrap --no-build
```

Normally, Carthage automatically builds framework binaries for all dependencies in the `Cartfile`. By passing the `--no-build` argument to `carthage bootstrap`, Carthage only downloads the dependencies; it doesn't build them. This preserves your option of building the dependencies directly within your own Xcode workspace.

> If you do not wish to have Carthage build dependencies that it has downloaded, you can proceed to the [Manual Integration](#manual-integration) section.

### 3. Build CleanroomCLI using Carthage

To have Carthage build (or re-build) CleanroomCLI, issue the command:

```
carthage build CleanroomCLI
```

You can also use the `--platform` argument to speed up build times by limiting the set of processor architectures that need to be built.

To build for|Supply the argument
------------|-------------------
iPhone/iPad|`--platform ios`
Macintosh|`--platform mac`
Apple TV|`--platform tvos`
Apple Watch|`--platform watchos`


Even though CleanroomCLI is designed as a universal framework, during the build process, Carthage splits the framework into separate binaries for each Apple platform.

The binary for|Is located at
--------------|-------------
iPhone/iPad|`Carthage/Build/iOS/CleanroomCLI.framework`
Macintosh|`Carthage/Build/Mac/CleanroomCLI.framework`
Apple TV|`Carthage/Build/tvOS/CleanroomCLI.framework`
Apple Watch|`Carthage/Build/watchOS/CleanroomCLI.framework`


For further information on integrating Carthage-built frameworks, see the section on "[Adding frameworks to an application](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)" in the [Carthage documentation](https://github.com/Carthage/Carthage#carthage--).

### 4. Add the import statement

Once properly integrated, you can make use of [the API](https://rawgit.com/emaloney/CleanroomCLI/universal-framework/Documentation/API/index.html) provided by CleanroomCLI using the statement:

```swift
import CleanroomCLI
```

## Manual Integration

Manual integration involves embedding `CleanroomCLI.xcodeproj` directly in your own Xcode workspace.

> **Note:** You *must* use an Xcode workspace specifically—and not just a project file—in order to integrate CleanroomCLI manually.

### Integration possibilities

There are several possibilities for manually integrating CleanroomCLI with your workspace.

#### Carthage

If you use Carthage only for downloading dependencies—and not for building them—you will want to integrate the project file found at:

```
Carthage/Checkouts/CleanroomCLI/CleanroomCLI.xcodeproj
```

#### Git Submodules

If you’re not using Carthage, the recommended integration mechanism is to add CleanroomCLI to your git repo as a submodule. (This, of course, assumes that your project is stored in a git repo.)

For example, to install CleanroomCLI at `Libraries/CleanroomCLI`, you could issue the command:

```bash
git submodule add https://github.com/emaloney/CleanroomCLI Libraries/CleanroomCLI
```

Upon successful completion, the project file would be found at:

```
Libraries/CleanroomCLI/CleanroomCLI.xcodeproj
```

#### Other

If you acquired the CleanroomCLI’s source code through some other means, locate the `CleanroomCLI.xcodeproj` file.

### 1. Embed CleanroomCLI.xcodeproj in your workspace

In Finder, located the `CleanroomCLI.xcodeproj` file that you’ll be integrating. Then, drag it into *the top level* of Xcode’s Project Navigator pane for your workspace, being careful not to drag the file *into* any other projects listed there.

### 2. Perform a test build

Select the "CleanroomCLI" build scheme, and then invoke *Build* (⌘B) from the *Product* menu.

If there are no buld errors, `CleanroomCLI.xcodeproj` was correctly added to the workspace.

### 3. Add the necessary dependencies to your target

In Xcode, select the *General* tab in the build settings for your application target. Scroll to the bottom of the screen to reveal the section entitled *Embedded Binaries* (the second-to-last section).

Go back to Finder, select the file `CleanroomCLI.framework`, and then drag it into the list area directly below *Embedded Binaries*.

If successful, you should see `CleanroomCLI.framework` listed under both the *Embedded Binaries* and *Linked Frameworks and Libraries* sections.

### 4. Add the import statement

You can then make use of [the API](https://rawgit.com/emaloney/CleanroomCLI/universal-framework/Documentation/API/index.html) provided by CleanroomCLI using the statement:

```swift
import CleanroomCLI
```

## Further Reading

Want to learn more about CleanroomCLI? Check out [the README](https://github.com/emaloney/CleanroomCLI/blob/universal-framework/README.md).

**_Happy coding!_**
