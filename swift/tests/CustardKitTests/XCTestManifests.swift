import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ConstantsTest.allTests),
        testCade(TabDataTest.allTests),
        testCase(DecodeCodableActionTest.allTests),
        testCade(EncodeCodableActionTest.allTests),
        testCode(CustardKeyLabelStyleTest.allTests),
        testCode(CustardVariationKeyDesignTest.allTests),
        testCode(CustardInterfaceVariationKeyTest.allTests),
        testCode(CustardInterfaceVariationTest.allTests),
        testCode(CustardInterfaceSystemKeyTest.allTests),
        testCode(CustardKeyDesignTest.allTests),
        testCode(CustardInterfaceCustomKeyTest.allTests)
    ]
}
#endif
