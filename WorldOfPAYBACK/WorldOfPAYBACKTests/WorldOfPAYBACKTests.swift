//
//  WorldOfPAYBACKTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Mohamad Rahmani on 03.02.23.
//

import XCTest
@testable import WorldOfPAYBACK

class WorldOfPAYBACKTests: XCTestCase {
  func testExample() throws {
    XCTAssertTrue(true)
  }
  
  func test_givenBookingDate_returnCorrectDateForGermanyTimeZone() {
    let bookingDate = TransactionDetail.fixture(bookingDate: "2022-07-24T10:59:05+0200").bookingDate
//    let dateComponents = Calendar.current.dateComponents(in: TimeZone(identifier: "Europe/Berlin")!, from: bookingDate)
    let dateComponents = Calendar.current.dateComponents(in: TimeZone(abbreviation: "CET")!, from: bookingDate)
    do {
      let day = try XCTUnwrap(dateComponents.day)
      let hour = try XCTUnwrap(dateComponents.hour)
      XCTAssertEqual(day, 24)
      XCTAssertEqual(hour, 10)
    } catch {
      XCTFail("Couldn't do the unwrapping.")
    }
  }
  
  func test_givenBookingDate_returnCorrectDateForUSATimeZone() {
    let bookingDate = TransactionDetail.fixture(bookingDate: "2022-07-24T10:59:05+0200").bookingDate
//    let dateComponents = Calendar.current.dateComponents(in: TimeZone(identifier: "Europe/Berlin")!, from: bookingDate)
    let dateComponents = Calendar.current.dateComponents(in: TimeZone(abbreviation: "EST")!, from: bookingDate)
    do {
      let day = try XCTUnwrap(dateComponents.day)
      let hour = try XCTUnwrap(dateComponents.hour)
      XCTAssertEqual(day, 24)
      XCTAssertEqual(hour, 4)
    } catch {
      XCTFail("Couldn't do the unwrapping.")
    }
  }
  
  func test_givenBookingDate_returnCorrectDateForCurrentTimeZone() {
    let bookingDate = TransactionDetail.fixture(bookingDate: "2022-07-24T10:59:05+0200").bookingDate
//    let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: bookingDate)
    let dateComponents = Calendar.current.dateComponents(in: TimeZone(identifier: "Asia/Tehran")!, from: bookingDate)
    do {
      let day = try XCTUnwrap(dateComponents.day)
      let hour = try XCTUnwrap(dateComponents.hour)
      XCTAssertEqual(day, 24)
      XCTAssertEqual(hour, 13)
    } catch {
      XCTFail("Couldn't do the unwrapping.")
    }
  }
}

extension TransactionDetail {
  static func fixture(bookingDate: String) -> Self {
    let dateFormatter = DateFormatter.iso8601Full
    guard let bookingDate = dateFormatter.date(from: bookingDate) else {
      return TransactionDetail(description: "a description", bookingDate: Date(), value: Value(amount: 123, currency: "a currency"))
    }
    return TransactionDetail(description: "a description", bookingDate: bookingDate, value: Value(amount: 123, currency: "a currency"))
  }
}
