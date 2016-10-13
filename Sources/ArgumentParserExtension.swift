//
//  ArgumentParserExtension.swift
//  CleanroomCLI
//
//  Created by Evan Maloney on 10/13/16.
//  Copyright © 2016 Gilt Groupe. All rights reserved.
//

import Foundation

extension ArgumentParser
{
    /**
     Parses the command-line arguments of the currently-executing
     process, as identified by `ProcessInfo.processInfo.arguments`.
     */
    public func parse()
        -> CommandLineArguments
    {
        // ProcessInfo.processInfo.arguments should always contain
        // at least one element, so this exception should never be thrown
        return try! parse(arguments: ProcessInfo.processInfo.arguments)
    }

    /**
     Parses the passed-in command-line arguments.
     
     - parameter commandLine: A string containing the command line. This
     must include at least one non-space character, the command itself.
     
     - throws: If `commandLine` doesn't contain at least one non-space
     character, an exception is raised.
     */
    public func parse(commandLine: String)
        throws
        -> CommandLineArguments
    {
        // ProcessInfo.processInfo.arguments should always contain
        // at least one element, so this exception should never be thrown
        return try! parse(arguments: commandLine.components(separatedBy: " "))
    }
}
