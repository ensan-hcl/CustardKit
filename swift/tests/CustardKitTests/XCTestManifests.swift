import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ConstantsTest.allTests),
        testCase(DecodeCodableActionTest.allTests),
        testCade(EncodeCodableActionTest.allTests)
    ]
}
#endif
