//
//  CommandLineArguments.swift
//  CleanroomCLI
//
//  Created by Evan Maloney on 10/13/16.
//  Copyright © 2016 Gilt Groupe. All rights reserved.
//

/**
 Represents a parsed set of command-line arguments created by an 
 `ArgumentParser`.
*/
public protocol CommandLineArguments
{
    /** The command as invoked from the command line. */
    var command: String { get }

    /** The names of the arguments for which `has(argument:)` would return
     `true`. */
    var names: [String] { get }

    /**
     Returns the `Argument` with the given name.

     - parameter name: The name of the argument.

     - returns: The `Argument`, or `nil` if there wasn't one named `name`.
     */
    func argument(_ name: String) -> Argument?

    /**
     Determines if the argument with the given name was present in the argument
     list.

     - parameter name: The name of the argument.

     - returns: `true` if the argument `name` was present in the argument list;
     `false` otherwise.
     */
    func has(argument name: String) -> Bool

    /**
     Determines if the argument with the given name was present in the argument
     list, and if so, whether it represents an explicitly-declared argument.

     - parameter name: The name of the argument.

     - returns: `true` if `name` represents an declared argument that is present
     in the argument list. Undeclared arguments are usually treated as
     unrecognized by the developer.
     */
    func has(declaredArgument name: String) -> Bool

    /**
     Returns the `DeclaredType` associated with the argument with the given name.

     - parameter name: The name of the argument whose `DeclaredType` is sought.

     - returns: The `DeclaredType`, or `nil` if `isDeclared()` would
     return `false` for `name`.
     */
    func declaredType(_ name: String) -> ArgumentDeclaration.DeclaredType?

    /**
     Determines whether the argument with the specified name has at least one
     value.

     - parameter name: The name of the argument.

     - returns: `true` if the argument `name` has at least one value, `false`
     otherwise.
     */
    func has(value name: String) -> Bool

    /**
     Determines whether the argument with the specified name has multiple
     values.

     - parameter name: The name of the argument.

     - returns: `true` if the argument `name` has multiple values, `false`
     otherwise.
     */
    func has(multipleValues name: String) -> Bool

    /**
     Returns the first string value of the argument with the given name.

     If there are no values named `name`, then this function will return `nil`.

     - parameter name: The name of the argument whose string value is sought.

     - returns: The first string value of the argument `name`. Always `nil` if
     the `declaredType()` of `name` is `.flag`.
     */
    func value(_ name: String) -> String?

    /**
     Returns the first string value of the argument with the given name.

     - throws: When there are no values named `name`, or if `name` represents
     a `.flag`.

     - parameter name: The name of the argument whose string value is sought.

     - returns: The first string value of the argument `name`.
     */
    func required(_ name: String) throws -> String

    /**
     Returns all string values for the argument with the given name.

     - parameter name: The name of the argument whose string values are sought.

     - returns: All string values for the argument `name`.
     */
    func allValues(_ name: String) -> [String]
}
