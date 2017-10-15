//
//  AnalyticsManager.swift
//  AnalyticsManager
//
//  Created by Arnaud Schildknecht on 15/10/2017.
//  Copyright © 2017 Arnaud Schildknecht. All rights reserved.
//

import Foundation

public final class AnalyticsManager {
  public static let shared = AnalyticsManager()

  fileprivate var providers: [AnalyticsProvider] = []

  public func setup(providers: [AnalyticsProvider]) {
    self.providers = providers

    self.providers.forEach {
      $0.configure()
    }
  }
}

// MARK: Identification

extension AnalyticsManager {
  public func identify(identifier: String, options: [String: Any]) {
    providers.forEach {
      $0.identify(identifier: identifier, options: options)
    }
  }

  public func resetIdentity() {
    providers.forEach {
      $0.resetIdentity()
    }
  }
}

// MARK: Events

extension AnalyticsManager {
    public func track(event: String, properties: [String: Any]? = nil) {
      providers.forEach {
        $0.track(event: event, properties: properties)
      }
    }
}
