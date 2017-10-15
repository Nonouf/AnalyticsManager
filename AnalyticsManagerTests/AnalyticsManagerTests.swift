//
//  AnalyticsManagerTests.swift
//  AnalyticsManagerTests
//
//  Created by Arnaud Schildknecht on 15/10/2017.
//  Copyright © 2017 Arnaud Schildknecht. All rights reserved.
//

import XCTest
@testable import AnalyticsManager

final class MockProvider: AnalyticsProvider {
  var apiKey: String = "123"

  var isConfigured = false
  var identityID = ""
  var identityOptions = [String: Any]()
  var isReset = false
  var trackEvent = ""
  var trackProperties: [String: Any]? = nil

  func configure() {
    isConfigured = true
  }

  func identify(identifier: String, options: [String: Any]) {
    identityID = identifier
    identityOptions = options
  }

  func resetIdentity() {
    isReset = true
  }

  func track(event: String, properties: [String: Any]?) {
    trackEvent = event
    trackProperties = properties
  }
}

class AnalyticsManagerTests: XCTestCase {
  var manager: AnalyticsManager?

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.

    manager = AnalyticsManager()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    manager = nil

    super.tearDown()
  }

  func testSetup() {
    // Given
    let googleAnalytics = MockProvider()
    let segment = MockProvider()

    // When
    manager?.setup(providers: [
      googleAnalytics,
      segment
      ])

    // Then
    XCTAssertTrue(googleAnalytics.isConfigured)
    XCTAssertTrue(segment.isConfigured)
  }

  func testIdentify() {
    // Given
    let googleAnalytics = MockProvider()
    let segment = MockProvider()
    let identifier = "user_identifier"
    let options = ["first_name": "Albert",
                   "last_name": "Einstein"]

    manager?.setup(providers: [
      googleAnalytics,
      segment
      ])

    // When
    manager?.identify(identifier: identifier, options: options)

    // Then
    XCTAssertEqual(googleAnalytics.identityID, identifier)
    XCTAssertEqual(googleAnalytics.identityOptions["first_name"] as? String, options["first_name"])
    XCTAssertEqual(googleAnalytics.identityOptions["last_name"] as? String, options["last_name"])
    XCTAssertEqual(segment.identityID, identifier)
    XCTAssertEqual(segment.identityOptions["first_name"] as? String, options["first_name"])
    XCTAssertEqual(segment.identityOptions["last_name"] as? String, options["last_name"])
  }

  func testTrack_noOptions() {
    // Given
    let googleAnalytics = MockProvider()
    let segment = MockProvider()
    let event = "my_event"

    manager?.setup(providers: [
      googleAnalytics,
      segment
      ])

    // When
    manager?.track(event: event)

    // Then
    XCTAssertEqual(googleAnalytics.trackEvent, event)
    XCTAssertNil(googleAnalytics.trackProperties)
    XCTAssertEqual(segment.trackEvent, event)
    XCTAssertNil(segment.trackProperties)
  }

  func testTrack_options() {
    // Given
    let googleAnalytics = MockProvider()
    let segment = MockProvider()
    let event = "my_event"
    let properties = ["first_name": "Albert",
                      "last_name": "Einstein"]

    manager?.setup(providers: [
      googleAnalytics,
      segment
      ])

    // When
    manager?.track(event: event, properties: properties)

    // Then
    XCTAssertEqual(googleAnalytics.trackEvent, event)
    XCTAssertEqual(googleAnalytics.trackProperties?["first_name"] as? String, properties["first_name"])
    XCTAssertEqual(googleAnalytics.trackProperties?["last_name"] as? String, properties["last_name"])
    XCTAssertEqual(segment.trackEvent, event)
    XCTAssertEqual(segment.trackProperties?["first_name"] as? String, properties["first_name"])
    XCTAssertEqual(segment.trackProperties?["last_name"] as? String, properties["last_name"])
  }

  func testResetIdentity() {
    // Given
    let googleAnalytics = MockProvider()
    let segment = MockProvider()

    manager?.setup(providers: [
      googleAnalytics,
      segment
      ])

    // When
    manager?.resetIdentity()

    // Then
    XCTAssertTrue(googleAnalytics.isReset)
    XCTAssertTrue(segment.isReset)
  }

  func testLogger() {
    // Given
    var logCount = 0

    manager?.logger = { log in
        logCount += 1
      }

    // When
    manager?.identify(identifier: "Test", options: [:])

    // Then
    XCTAssertEqual(logCount, 1)

    // When
    manager?.track(event: "event")

    // Then
    XCTAssertEqual(logCount, 2)

    // When
    manager?.track(event: "event", properties: [:])

    // Then
    XCTAssertEqual(logCount, 3)
  }
}
