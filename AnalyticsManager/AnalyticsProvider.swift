//
//  AnalyticsProvider.swift
//  AnalyticsManager
//
//  Created by Arnaud Schildknecht on 15/10/2017.
//  Copyright © 2017 Arnaud Schildknecht. All rights reserved.
//

import Foundation

public protocol AnalyticsProvider {
  var apiKey: String { get }

  func configure()
  func identify(identifier: String, options: [String: Any])
  func resetIdentity()
  func track(event: String, properties: [String: Any]?)
}
