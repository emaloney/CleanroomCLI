//
//  CommandLineArgumentsImpl.swift
//  CleanroomCLI
//
//  Created by Evan Maloney on 10/13/16.
//  Copyright © 2016 Gilt Groupe. All rights reserved.
//

internal struct CommandLineArgumentsImpl: CommandLineArguments
{
    let command: String
    let names: [String]
    let namesToArguments: [String: Argument]

    init(command: String, arguments: [Argument])
    {
        var names = [String]()
        var namesToArguments = [String: Argument]()
        for val in arguments {
            names += [val.name]
            namesToArguments[val.name] = val
        }
        self.command = command
        self.names = names
        self.namesToArguments = namesToArguments
    }

    func argument(_ name: String)
        -> Argument?
    {
        return namesToArguments[name]
    }

    func has(argument name: String)
        -> Bool
    {
        return namesToArguments[name] != nil
    }

    func has(declaredArgument name: String)
        -> Bool
    {
        guard let val = namesToArguments[name] else {
            return false
        }

        return val.declaration != nil
    }

    func declaredType(_ name: String)
        -> ArgumentDeclaration.DeclaredType?
    {
        return namesToArguments[name]?.declaration?.type
    }

    func value(_ name: String)
        -> String?
    {
        guard let val = namesToArguments[name] else {
            return nil
        }

        return val.values.first
    }

    func required(_ name: String)
        throws
        -> String
    {
        guard let val = value(name) else {
            throw ArgumentParser.ArgumentError.requiredValueNotPresent(name)
        }

        return val
    }

    func has(value name: String) -> Bool
    {
        return namesToArguments[name]?.values.first != nil
    }

    func has(multipleValues name: String) -> Bool
    {
        guard let val = namesToArguments[name] else {
            return false
        }

        return val.values.count > 1
    }

    func allValues(_ name: String) -> [String]
    {
        guard let val = namesToArguments[name] else {
            return []
        }
        
        return val.values
    }
}
