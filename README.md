# AnalyticsManager
AnalyticsManager provides a simple abstraction to manage your analytics providers (e.g. GoogleAnalytics, Segment, Drift, Mixpanel...).

It provides the following features:
* Configure your providers
* Identify your user
* Reset the user identity
* Track an event

## Usage

AnalyticsManager provides a protocol defining how to implement providers.

### Providers

```swift
import Analytics.SEGAnalytics

struct Segment: AnalyticsProvider {
  var apiKey: String = "<my_api_key>"

  func configure() {
    let configuration = SEGAnalyticsConfiguration(writeKey: apiKey)

    configuration.trackApplicationLifecycleEvents = true
    configuration.recordScreenViews = true

    SEGAnalytics.setup(with: configuration)
  }

  func identify(identifier: String, options: [String: Any]) {
    SEGAnalytics.shared().alias(identifier)
    SEGAnalytics.shared().identify(identifier, traits: options, options: ["integrations": ["Salesforce": true]])
  }

 func resetIdentity() {
    SEGAnalytics.shared().reset()
  }

  func track(event: String, properties: [String: Any]?) {
    SEGAnalytics.shared().track(event, properties: properties)
  }
}
```

### Setup

You can now setup the AnalyticsManager in your AppDelegate:
```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    AnalyticsManager.shared.setup(providers: [
      Segment()
    ])

    return true
}
```

### Features

You're now good to identify your user and track all your events.
```swift
AnalyticsManager.shared.identify(identifier: "user_id", options: ["first_name": "Albert", "last_name": "Einstein"]])
AnalyticsManager.shared.track(event: "my_event", properties: ["isLoggedIn": true])
AnalyticsManager.shared.resetIdentity()
```

## Install

AnalyticsManager is available on Cocoapods.

```
  pod 'AnalyticsManager'
```

## License
AnalyticsManager is available under the MIT license. See the [LICENSE](https://github.com/Nonouf/AnalyticsManager/blob/master/LICENSE) file.
