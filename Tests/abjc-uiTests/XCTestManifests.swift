import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(abjc_uiTests.allTests),
    ]
}
#endif
