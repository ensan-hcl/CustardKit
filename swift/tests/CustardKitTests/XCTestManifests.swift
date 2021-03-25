import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ConstantsTest.allTests),
        testCade(TabDataTest.allTests),
        testCase(DecodeCodableActionTest.allTests),
        testCade(EncodeCodableActionTest.allTests)
        testCode(CustardVariationKeyDesignTest.allTests)
    ]
}
#endif
