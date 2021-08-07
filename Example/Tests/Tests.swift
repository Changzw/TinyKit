import XCTest
import TinyKit

class Tests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testExample() {
    // This is an example of a functional test case.
    XCTAssert(true, "Pass")
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure() {
      // Put the code you want to measure the time of here.
    }
  }
  
}

import XCTest
class StateRealWorld: XCTestCase {
  func test() {
    print("Client: I'm starting working with a location tracker")
    let tracker = LocationTracker()
    print()
    tracker.startTracking()
    print()
    tracker.pauseTracking(for: 2)
    print()
    tracker.makeCheckIn()
    print()
    tracker.findMyChildren()
    print()
    tracker.stopTracking()
  }
}
