//
//  Argument.swift
//  CleanroomCLI
//
//  Created by Evan Maloney on 10/13/16.
//  Copyright © 2016 Gilt Groupe. All rights reserved.
//

/**
 Represents an argument encountered by an `ArgumentParser` while parsing
 `CommandLineArguments`.
 */
public struct Argument
{
    /** The first word of the argument, as it appeared on the command line. */
    public let argument: String

    /** The values associated with the argument. */
    public let values: [String]

    /** The declaration associated with the argument, or `nil` if the
     argument was not explicitly declared. */
    public let declaration: ArgumentDeclaration?

    /** The declared name of the argument, or `nil` if the argument was not
     explicitly declared. */
    public var declaredName: String? {
        return declaration?.name
    }

    /** The name of the argument. For declared arguments, this is the same
     as the `declaredName` property; otherwise, it is the same as the 
     `argument` property. */
   public var name: String {
        return declaredName ?? argument
    }
}
