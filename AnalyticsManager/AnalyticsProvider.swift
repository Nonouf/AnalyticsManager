//
//  AnalyticsProvider.swift
//  AnalyticsManager
//
//  Created by Arnaud Schildknecht on 15/10/2017.
//  Copyright © 2017 Arnaud Schildknecht. All rights reserved.
//

import Foundation

/**
 `AnalyticsProvider` provides an abstraction for your different provider.
 */
public protocol AnalyticsProvider {
  /// The API key provided by your provider.
  var apiKey: String { get }

  /**
     Configure your provider.
   */
  func configure()

  /**
   Identify a user with the given identifier and options.

   The user identifer is defined by your providers. It is often the user ID.
   To make sure you send the right value, please refer to your providers documentation.

   - parameter identifier: The identifer required by the providers.
   - parameter options:    A dictionary of options to provide to your providers.
   */
  func identify(identifier: String, options: [String: Any])

  /**
   Reset the user identity.
   */
  func resetIdentity()

  /**
   Track the given event.

   - parameter event:       The event name to track.
   - parameter properties:  A dictionary of properties associated to the event.
   */
  func track(event: String, properties: [String: Any]?)
}
