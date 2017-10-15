//
//  AnalyticsManager.swift
//  AnalyticsManager
//
//  Created by Arnaud Schildknecht on 15/10/2017.
//  Copyright © 2017 Arnaud Schildknecht. All rights reserved.
//

import Foundation

/**
 `AnalyticsManager` is a class taking care of managing your different analytics providers.

 No matter how many providers you use, it will take care of configuring every one of them
 and notifying them of every event you wish to track within your app.
 */
public final class AnalyticsManager {
  public static let shared = AnalyticsManager()

  /// A closure that enable logging
  public var logger: ((String) -> Void)?
  
  fileprivate var providers: [AnalyticsProvider] = []

  /**
   Setup all your providers.

   - parameter providers:  A set of analytics providers you wish to use within your app.
   */
  public func setup(providers: [AnalyticsProvider]) {
    self.providers = providers
    
    self.providers.forEach {
      $0.configure()
    }
  }
}

// MARK: Identification

extension AnalyticsManager {
  /**
   Identify a user with the given identifier and options.

   The user identifer is defined by your providers. It is often the user ID.
   To make sure you send the right value, please refer to your providers documentation.

   - parameter identifier: The identifer required by the providers.
   - parameter options:    A dictionary of options to provide to your providers.
   */
  public func identify(identifier: String, options: [String: Any]) {
    log(message: "Identify user \(identifier) with options: \(options)")

    providers.forEach {
      $0.identify(identifier: identifier, options: options)
    }
  }

  /**
   Reset the user identity.
   */
  public func resetIdentity() {
    providers.forEach {
      $0.resetIdentity()
    }
  }
}

// MARK: Events

extension AnalyticsManager {
  /**
   Track the given event.

   - parameter event:       The event name to track.
   - parameter properties:  A dictionary of properties associated to the event.
   */
  public func track(event: String, properties: [String: Any]? = nil) {
    if let properties = properties {
      log(message: "Track \(event) with properties: \(properties)")
    } else {
      log(message: "Track \(event)")
    }
    providers.forEach {
      $0.track(event: event, properties: properties)
    }
  }
}

// MARK: Logger
extension AnalyticsManager {
  fileprivate func log(message: String) {
    logger?("[AnalyticsManager] \(message)")
  }
}
