//: Please build the scheme 'SwiftDatePlayground' first
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

import SwiftDate
import Timepiece


Date().today.string(format: .iso8601(options: [.withFullDate]))