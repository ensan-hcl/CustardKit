import XCTest

import CustardKitTests

var tests = [XCTestCaseEntry]()
tests += ConstantsTest.allTests()
tests += DecodeCodableActionTest.allTests()
test += EncodeCodableActionTest.allTests()
test += TabDataTest.allTests()
test += CustardVariationKeyDesignTest.allTests()
XCTMain(tests)
