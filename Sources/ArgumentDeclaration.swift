//
//  ArgumentDeclaration.swift
//  CleanroomCLI
//
//  Created by Evan Maloney on 10/13/16.
//  Copyright © 2016 Gilt Groupe. All rights reserved.
//

/**
 Represents an argument that might be encountered on the command line.
 */
public struct ArgumentDeclaration
{
    /**
     Identifies the declared type of an argument.
     */
    public enum DeclaredType
    {
        /** An argument that takes no follow-on parameters. A flag can be
         thought of as a boolean value; if it is present, the value is `true`;
         if the flag is not present, the value is `false`. */
        case flag

        /** An argument that takes a single follow-on parameter value. */
        case singleValue

        /** An argument that takes multiple follow-on parameter values. */
        case multiValue
    }

    /** The programmatic name of the argument, which may or may not reflect
     it's short- or long-form representation on the command line. */
    public let name: String

    /** The argument's type, which determines how the argument (and any
     expected parameters) gets parsed. */
    public let type: DeclaredType

    /** The short-form representation of the argument, a single character. On
     the command-line, the short form typically consists of with a single hyphen
     ("`-`") character followed by `shortForm`. If this value is `nil`, then
     `longForm` must be non-`nil`. */
    public let shortForm: Character?

    /** The long-form representation of the argument. On the command-line, 
     the long form typically consists of two hyphen characters ("`--`") 
     followed by `longForm`. If this value is `nil`, then `shortForm` must be
     non-`nil`. */
    public let longForm: String?

    /**
     Creates an argument of the given type.

     Either the `shortForm` or the `longForm` property will be populated,
     given the length of `name`.

     - parameter name: The name by which the argument is known programmatically.
     If `name` is a single character in length, `shortForm` will be populated
     from name and `longForm` will be `nil`; otherwise, `shortForm` will be
     `nil` and `longForm` will be populated from `name`.

     - parameter type: The argument's type.
     */
    public init(name: String, type: DeclaredType)
    {
        if name.count == 1 {
            self.init(name: name, type: type, shortForm: name.first!, longForm: nil)
        } else {
            self.init(name: name, type: type, shortForm: nil, longForm: name)
        }
    }

    /**
     Creates a short-form argument of the given type.

     - parameter name: The name by which the argument is known programmatically.

     - parameter type: The argument's type.
     
     - parameter shortForm: A short-form argument representation. On the 
     command-line, the short form typically consists of with a single hyphen
     ("`-`") character followed by the value of `shortForm`.
     */
    public init(name: String, type: DeclaredType, shortForm: Character)
    {
        self.init(name: name, type: type, shortForm: shortForm, longForm: nil)
    }

    /**
     Creates a long-form argument of the given type.

     - parameter name: The name by which the argument is known programmatically.

     - parameter type: The argument's type.

     - parameter longForm: A long-form argument representation. On the
     command-line, the long form typically consists of two hyphen characters
     ("`--`") followed by the value of `longForm`.
     */
    public init(name: String, type: DeclaredType, longForm: String)
    {
        self.init(name: name, type: type, shortForm: nil, longForm: longForm)
    }

    /**
     Creates a short-form argument of the given type.

     The `name` attribute will be populated by a `String` containing a single
     character: the value of `shortForm`.

     - parameter type: The argument's type.

     - parameter shortForm: A short-form argument representation. On the
     command-line, the short form typically consists of with a single hyphen
     ("`-`") character followed by the value of `shortForm`.
     */
    public init(type: DeclaredType, shortForm: Character)
    {
        self.init(name: String(shortForm), type: type, shortForm: shortForm, longForm: nil)
    }

    /**
     Creates a long-form argument of the given type.

     The `name` attribute will be populated by the value of `longForm`.

     - parameter type: The argument's type.

     - parameter longForm: A long-form argument representation. On the
     command-line, the long form typically consists of two hyphen characters
     ("`--`") followed by the value of `longForm`.
     */
    public init(type: DeclaredType, longForm: String)
    {
        self.init(name: longForm, type: type, shortForm: nil, longForm: longForm)
    }

    /**
     Creates an argument of the given type having both a short- and long-form
     representation on the command line.

     The `name` attribute will be populated by the value of `longForm`.

     - parameter type: The argument's type.

     - parameter shortForm: A short-form argument representation. On the
     command-line, the short form typically consists of with a single hyphen
     ("`-`") character followed by the value of `shortForm`.

     - parameter longForm: A long-form argument representation. On the
     command-line, the long form typically consists of two hyphen characters
     ("`--`") followed by the value of `longForm`.
     */
    public init(type: DeclaredType, shortForm: Character, longForm: String)
    {
        self.init(name: longForm, type: type, shortForm: shortForm, longForm: longForm)
    }

    /**
     Creates an argument of the given type having both a short- and long-form
     representation on the command line.

     - parameter name: The name by which the argument is known programmatically.

     - parameter type: The argument's type.

     - parameter shortForm: A short-form argument representation. On the
     command-line, the short form typically consists of with a single hyphen
     ("`-`") character followed by the value of `shortForm`.

     - parameter longForm: A long-form argument representation. On the
     command-line, the long form typically consists of two hyphen characters 
     ("`--`") followed by the value of `longForm`.
     */
    public init(name: String, type: DeclaredType, shortForm: Character, longForm: String)
    {
        // the use of Optional(...) below is to force the compiler to select the
        // private init(); otherwise, this init() implementation would recurse
        self.init(name: name, type: type, shortForm: Optional(shortForm), longForm: Optional(longForm))
    }

    private init(name: String, type: DeclaredType, shortForm: Character?, longForm: String?)
    {
        // due to the construction of the public init()s, this precondition should never be false
        precondition(shortForm != nil || longForm != nil, "Either shortForm or longForm must be non-nil")

        self.name = name
        self.type = type
        self.shortForm = shortForm
        self.longForm = longForm
    }
}

