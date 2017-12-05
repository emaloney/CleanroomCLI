//
//  CleanroomCLITests.swift
//  CleanroomCLI
//
//  Created by Evan Maloney on 10/12/16.
//  Copyright (c) 2016 Gilt Groupe. All rights reserved.
//

import XCTest
import CleanroomCLI

class CleanroomCLIUnitTests: XCTestCase
{
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }

    func testShortFormFlag()
    {
        let decl = ArgumentDeclaration(name: "foo", type: .flag, shortForm: "f".first!)

        let parser = try! ArgumentParser(declarations: [decl])

        let args = try! parser.parse(arguments: ["fakeProcess.sh", "-f"])

        XCTAssertTrue(args.has(declaredArgument: "foo"))
        XCTAssertTrue(!args.has(value: "foo"))
        XCTAssertTrue(!args.has(multipleValues: "foo"))
    }

    func testLongFormFlag()
    {
        let decl = ArgumentDeclaration(name: "foo", type: .flag, longForm: "foo")

        let parser = try! ArgumentParser(declarations: [decl])

        let args = try! parser.parse(arguments: ["fakeProcess.sh", "--foo"])

        XCTAssertTrue(args.has(declaredArgument: "foo"))
        XCTAssertTrue(!args.has(value: "foo"))
        XCTAssertTrue(!args.has(multipleValues: "foo"))
    }

    func testMultiFormFlag()
    {
        let decl = ArgumentDeclaration(name: "foo", type: .flag, shortForm: "f".first!, longForm: "foo")

        let parser = try! ArgumentParser(declarations: [decl])

        var args = try! parser.parse(arguments: ["fakeProcess.sh", "-f"])

        XCTAssertTrue(args.has(declaredArgument: "foo"))
        XCTAssertTrue(!args.has(value: "foo"))
        XCTAssertTrue(!args.has(multipleValues: "foo"))

        args = try! parser.parse(arguments: ["fakeProcess.sh", "--foo"])

        XCTAssertTrue(args.has(declaredArgument: "foo"))
        XCTAssertTrue(!args.has(value: "foo"))
        XCTAssertTrue(!args.has(multipleValues: "foo"))
    }

    func testShortFormSingleValueParameter()
    {
        let decl = ArgumentDeclaration(name: "bar", type: .singleValue, shortForm: "b".first!)

        let parser = try! ArgumentParser(declarations: [decl])

        let args = try! parser.parse(arguments: ["fakeProcess.sh", "-b", "foo"])

        XCTAssertTrue(args.has(declaredArgument: "bar"))
        XCTAssertTrue(args.has(value: "bar"))
        XCTAssertTrue(!args.has(multipleValues: "bar"))
        XCTAssertEqual(args.value("bar"), "foo")
        XCTAssertEqual(args.allValues("bar"), ["foo"])
    }

    func testLongFormSingleValueParameter()
    {
        let decl = ArgumentDeclaration(name: "bar", type: .singleValue, longForm: "bar")

        let parser = try! ArgumentParser(declarations: [decl])

        let args = try! parser.parse(arguments: ["fakeProcess.sh", "--bar", "foo"])

        XCTAssertTrue(args.has(declaredArgument: "bar"))
        XCTAssertTrue(args.has(value: "bar"))
        XCTAssertTrue(!args.has(multipleValues: "bar"))
        XCTAssertEqual(args.value("bar"), "foo")
        XCTAssertEqual(args.allValues("bar"), ["foo"])
    }

    func testMultiFormSingleValueParameter()
    {
        let decl = ArgumentDeclaration(name: "bar", type: .singleValue, shortForm: "b".first!, longForm: "bar")

        let parser = try! ArgumentParser(declarations: [decl])

        var args = try! parser.parse(arguments: ["fakeProcess.sh", "-b", "foo"])

        XCTAssertTrue(args.has(declaredArgument: "bar"))
        XCTAssertTrue(args.has(value: "bar"))
        XCTAssertTrue(!args.has(multipleValues: "bar"))
        XCTAssertEqual(args.value("bar"), "foo")
        XCTAssertEqual(args.allValues("bar"), ["foo"])

        args = try! parser.parse(arguments: ["fakeProcess.sh", "--bar", "foo"])

        XCTAssertTrue(args.has(declaredArgument: "bar"))
        XCTAssertTrue(args.has(value: "bar"))
        XCTAssertTrue(!args.has(multipleValues: "bar"))
        XCTAssertEqual(args.value("bar"), "foo")
        XCTAssertEqual(args.allValues("bar"), ["foo"])
    }

    func testShortFormMultiValueParameter()
    {
        let decl = ArgumentDeclaration(name: "bar", type: .multiValue, shortForm: "b".first!)

        let parser = try! ArgumentParser(declarations: [decl])

        let args = try! parser.parse(arguments: ["fakeProcess.sh", "-b", "foo", "baz", "bat"])

        XCTAssertTrue(args.has(declaredArgument: "bar"))
        XCTAssertTrue(args.has(value: "bar"))
        XCTAssertTrue(args.has(multipleValues: "bar"))
        XCTAssertEqual(args.value("bar"), "foo")
        XCTAssertEqual(args.allValues("bar"), ["foo", "baz", "bat"])
    }

    func testLongFormMultiValueParameter()
    {
        let decl = ArgumentDeclaration(name: "bar", type: .multiValue, longForm: "bar")

        let parser = try! ArgumentParser(declarations: [decl])

        let args = try! parser.parse(arguments: ["fakeProcess.sh", "--bar", "foo", "baz", "bat"])

        XCTAssertTrue(args.has(declaredArgument: "bar"))
        XCTAssertTrue(args.has(value: "bar"))
        XCTAssertTrue(args.has(multipleValues: "bar"))
        XCTAssertEqual(args.value("bar"), "foo")
        XCTAssertEqual(args.allValues("bar"), ["foo", "baz", "bat"])
    }

    func testMultiFormMultiValueParameter()
    {
        let decl = ArgumentDeclaration(name: "bar", type: .multiValue, shortForm: "b".first!, longForm: "bar")

        let parser = try! ArgumentParser(declarations: [decl])

        var args = try! parser.parse(arguments: ["fakeProcess.sh", "-b", "foo", "baz", "bat"])

        XCTAssertTrue(args.has(declaredArgument: "bar"))
        XCTAssertTrue(args.has(value: "bar"))
        XCTAssertTrue(args.has(multipleValues: "bar"))
        XCTAssertEqual(args.value("bar"), "foo")
        XCTAssertEqual(args.allValues("bar"), ["foo", "baz", "bat"])

        args = try! parser.parse(arguments: ["fakeProcess.sh", "--bar", "foo", "baz", "bat"])

        XCTAssertTrue(args.has(declaredArgument: "bar"))
        XCTAssertTrue(args.has(value: "bar"))
        XCTAssertTrue(args.has(multipleValues: "bar"))
        XCTAssertEqual(args.value("bar"), "foo")
        XCTAssertEqual(args.allValues("bar"), ["foo", "baz", "bat"])
    }

    func testComplexCommandLines()
    {
        let parser = try! ArgumentParser(declarations: [
            ArgumentDeclaration(name: "foo", type: .flag, shortForm: "f".first!, longForm: "foo"),
            ArgumentDeclaration(name: "bar", type: .singleValue, shortForm: "r".first!, longForm: "bar"),
            ArgumentDeclaration(name: "baz", type: .multiValue, shortForm: "z".first!, longForm: "baz"),
            ArgumentDeclaration(name: "bat", type: .flag, shortForm: "t".first!, longForm: "bat"),
            ArgumentDeclaration(name: "biz", type: .multiValue, shortForm: "i".first!, longForm: "biz")
        ])

        var args = try! parser.parse(commandLine: "fakeProcess.sh -f -r 10 --baz 12 11 12 -i May 3")

        XCTAssertEqual(args.command, "fakeProcess.sh")

        XCTAssertTrue(args.has(declaredArgument: "foo"))
        XCTAssertTrue(args.has(declaredArgument: "bar"))
        XCTAssertTrue(args.has(declaredArgument: "baz"))
        XCTAssertTrue(!args.has(declaredArgument: "bat"))
        XCTAssertTrue(args.has(declaredArgument: "biz"))

        XCTAssertTrue(!args.has(value: "foo"))
        XCTAssertTrue(args.has(value: "bar"))
        XCTAssertTrue(args.has(value: "baz"))
        XCTAssertTrue(!args.has(value: "bat"))
        XCTAssertTrue(args.has(value: "biz"))

        XCTAssertTrue(!args.has(multipleValues: "foo"))
        XCTAssertTrue(!args.has(multipleValues: "bar"))
        XCTAssertTrue(args.has(multipleValues: "baz"))
        XCTAssertTrue(!args.has(multipleValues: "bat"))
        XCTAssertTrue(args.has(multipleValues: "biz"))

        XCTAssertEqual(args.value("foo"), nil)
        XCTAssertEqual(args.value("bar"), "10")
        XCTAssertEqual(args.value("baz"), "12")
        XCTAssertEqual(args.value("bat"), nil)
        XCTAssertEqual(args.value("biz"), "May")

        XCTAssertEqual(args.allValues("foo"), [])
        XCTAssertEqual(args.allValues("bar"), ["10"])
        XCTAssertEqual(args.allValues("baz"), ["12", "11", "12"])
        XCTAssertEqual(args.allValues("bat"), [])
        XCTAssertEqual(args.allValues("biz"), ["May", "3"])

        args = try! parser.parse(commandLine: "fakeProcess.sh ten 20 --bar --baz 12 11 --foo 12 -i May --unknown -? --bat 3")

        XCTAssertEqual(args.command, "fakeProcess.sh")

        XCTAssertTrue(args.has(declaredArgument: "foo"))
        XCTAssertTrue(args.has(declaredArgument: "bar"))
        XCTAssertTrue(args.has(declaredArgument: "baz"))
        XCTAssertTrue(args.has(declaredArgument: "bat"))
        XCTAssertTrue(args.has(declaredArgument: "biz"))

        XCTAssertTrue(args.has(argument: "ten"))
        XCTAssertTrue(args.has(argument: "20"))
        XCTAssertTrue(args.has(argument: "12"))
        XCTAssertTrue(args.has(argument: "3"))

        XCTAssertTrue(!args.has(value: "foo"))
        XCTAssertTrue(!args.has(value: "bar"))
        XCTAssertTrue(args.has(value: "baz"))
        XCTAssertTrue(!args.has(value: "bat"))
        XCTAssertTrue(args.has(value: "biz"))

        XCTAssertTrue(!args.has(multipleValues: "foo"))
        XCTAssertTrue(!args.has(multipleValues: "bar"))
        XCTAssertTrue(args.has(multipleValues: "baz"))
        XCTAssertTrue(!args.has(multipleValues: "bat"))
        XCTAssertTrue(args.has(multipleValues: "biz"))

        XCTAssertEqual(args.value("foo"), nil)
        XCTAssertEqual(args.value("bar"), nil)
        XCTAssertEqual(args.value("baz"), "12")
        XCTAssertEqual(args.value("bat"), nil)
        XCTAssertEqual(args.value("biz"), "May")

        XCTAssertEqual(args.allValues("foo"), [])
        XCTAssertEqual(args.allValues("bar"), [])
        XCTAssertEqual(args.allValues("baz"), ["12", "11"])
        XCTAssertEqual(args.allValues("bat"), [])
        XCTAssertEqual(args.allValues("biz"), ["May", "--unknown", "-?"])
    }
}
