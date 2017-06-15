//
//  ArgumentParser.swift
//  CleanroomCLI
//
//  Created by Evan Maloney on 10/13/16.
//  Copyright © 2016 Gilt Groupe. All rights reserved.
//

/**
 Used to parse command-line arguments, optionally enforcing one or more
 explicit `ArgumentDeclaration`s.
 */
public struct ArgumentParser
{
    private let namesToDeclarations: [String: ArgumentDeclaration]
    private let argsToDeclarations: [String: ArgumentDeclaration]

    internal enum ArgumentError: Error
    {
        case invalidArgumentPrefix(String)
        case invalidArgumentDeclaration(String)
        case conflictingArgumentDeclaration(String)
        case invalidCommandLineInput(String)
        case requiredValueNotPresent
    }

    /**
     Constructs an `ArgumentParser` with the given argument declarations.
     
     - parameter declarations: An array of declarations representing
     the arguments that may be be encountered on the command line.

     - parameter shortFormPrefix: A string prefix used on the command line
     to signal a short-form argument. Defaults to "`-`".

     - parameter longFormPrefix: A string prefix used on the command line
     to signal a long-form argument. This string must be longer than
     `shortFormPrefix`. Defaults to "`--`".

     - throws: If one or more `ArgumentDeclaration` contains invalid or 
     conflicting values, or if `shortFormPrefix` is not a shorter string than
     `longFormPrefix`.
     */
    public init(declarations: [ArgumentDeclaration], shortFormPrefix: String = "-", longFormPrefix: String = "--")
        throws
    {
        guard shortFormPrefix.characters.count < longFormPrefix.characters.count else {
            throw ArgumentError.invalidArgumentPrefix("The longFormPrefix string must be longer than shortFormPrefix")
        }

        let names = declarations.map { $0.name }
        guard names.count == Set(names).count else {
            throw ArgumentError.conflictingArgumentDeclaration("Argument names must be unique")
        }

        let hasSingleCharLongForm = declarations
            .flatMap { $0.longForm }
            .map { $0.characters.count == 0 }
            .reduce(false) { $0 || $1 }
        guard !hasSingleCharLongForm else {
            throw ArgumentError.invalidArgumentDeclaration("An ArgumentDeclaration may not contain a single-character longForm representation; single characters representations are reserved for shortForm")
        }

        var namesToDecls = [String: ArgumentDeclaration]()
        var argsToDecls = [String: ArgumentDeclaration]()
        for decl in declarations {
            namesToDecls[decl.name] = decl
            if let short = decl.shortForm {
                let key = "\(shortFormPrefix)\(short)"
                guard argsToDecls[key] == nil else {
                    throw ArgumentError.invalidArgumentDeclaration("Multiple arguments declared for \(key)")
                }
                argsToDecls[key] = decl
            }
            if let long = decl.longForm {
                let key = "\(longFormPrefix)\(long)"
                guard argsToDecls[key] == nil else {
                    throw ArgumentError.invalidArgumentDeclaration("Multiple arguments declared for \(key)")
                }
                argsToDecls[key] = decl
            }
        }
        self.namesToDeclarations = namesToDecls
        self.argsToDeclarations = argsToDecls
    }

    /**
     Attempts to parse the given command-line arguments.

     - parameter arguments: An array of command-line arguments, such as those
     returned by `ProcessInfo.processInfo.arguments`. Must contain at least
     one element, the name of the command itself.

     - returns: The parsed `CommandLineArguments`.

     - throws: If `arguments` does not contain at least one element.
     */
    public func parse(arguments: [String])
        throws
        -> CommandLineArguments
    {
        guard let command = arguments.first else {
            throw ArgumentError.invalidCommandLineInput("Command-line arguments are expected to contain at least one element, the invoked command itself.")
        }

        var parsedArgs = [Argument]()
        var collectArgumentsFor: ArgumentDeclaration?
        var collected = [String]()

        for arg in arguments {
            //
            // make sure we obey any argument collection rules
            //
            if let collectFor = collectArgumentsFor,
                collectFor.type == .singleValue,
                collected.count == 2
            {
                parsedArgs += [Argument(argument: collected[0], values: [collected[1]], declaration: collectFor)]
                collectArgumentsFor = nil
                collected = []
            }

            if let decl = argsToDeclarations[arg] {
                if let collectFor = collectArgumentsFor {
                    parsedArgs += [Argument(argument: collected[0], values: Array(collected[1..<collected.endIndex]), declaration: collectFor)]
                    collectArgumentsFor = nil
                    collected = []
                }

                if decl.type == .flag {
                    parsedArgs += [Argument(argument: arg, values: [], declaration: decl)]
                }
                else {
                    collected += [arg]
                    collectArgumentsFor = decl
                }
            }
            else if collectArgumentsFor != nil {
                collected += [arg]
            }
            else {
                parsedArgs += [Argument(argument: arg, values: [], declaration: nil)]
            }
        }

        if let collectFor = collectArgumentsFor {
            parsedArgs += [Argument(argument: collected[0], values: Array(collected[1..<collected.endIndex]), declaration: collectFor)]
        }

        return CommandLineArgumentsImpl(command: command, arguments: parsedArgs)
    }
}
