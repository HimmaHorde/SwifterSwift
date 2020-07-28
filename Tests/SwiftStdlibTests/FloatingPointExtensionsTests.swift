//
//  FloatingPointExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 5.04.2018.
//  Copyright © 2018 SwifterSwift
//
import XCTest
@testable import SwifterSwift

final class FloatingPointExtensionsTests: XCTestCase {

    func testAbs() {
        XCTAssertEqual(Float(-9.3).abs, Float(9.3))
        XCTAssertEqual(Double(-9.3).abs, Double(9.3))
    }

    func testCeil() {
        XCTAssertEqual(Float(9.3).ceil, Float(10.0))
        XCTAssertEqual(Double(9.3).ceil, Double(10.0))
    }

    func testDegreesToRadians() {
        XCTAssertEqual(Float(180).degreesToRadians, Float.pi)
        XCTAssertEqual(Double(180).degreesToRadians, Double.pi)
    }

    func testFloor() {
        XCTAssertEqual(Float(9.3).floor, Float(9.0))
        XCTAssertEqual(Double(9.3).floor, Double(9.0))
    }

    func testRadiansToDegrees() {
        XCTAssertEqual(Float.pi.radiansToDegrees, Float(180))
        XCTAssertEqual(Double.pi.radiansToDegrees, Double(180))
    }

    func testOperators() {
        XCTAssert((Float(5.0) ± Float(2.0)) == (Float(3.0), Float(7.0)) || (Float(5.0) ± Float(2.0)) == (Float(7.0), Float(3.0)))
        XCTAssert((±Float(2.0)) == (Float(2.0), Float(-2.0)) || (±Float(2.0)) == (Float(-2.0), Float(2.0)))
        XCTAssertEqual(√Float(25.0), Float(5.0))

        XCTAssert((Double(5.0) ± Double(2.0)) == (Double(3.0), Double(7.0)) || (Double(5.0) ± Double(2.0)) == (Double(7.0), Double(3.0)))
        XCTAssert((±Double(2.0)) == (Double(2.0), Double(-2.0)) || (±Double(2.0)) == (Double(-2.0), Double(2.0)))
        XCTAssertEqual(√Double(25.0), Double(5.0))
    }

}
