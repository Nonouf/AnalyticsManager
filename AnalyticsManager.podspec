Pod::Spec.new do |s|
  s.name         = "AnalyticsManager"
  s.version      = "0.1.0"
  s.summary      = "A simple abstraction to manage your analytics providers"
  s.description  = <<-DESC
  AnalyticsManager provides a simple abstraction to manage your analytics providers (e.g. GoogleAnalytics, Segment, Drift, Mixpanel...).

  It provides the following features:
  * Configure your providers
  * Identify your user
  * Reset the user identity
  * Track an event
                   DESC
  s.homepage     = "https://github.com/Nonouf/AnalyticsManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Arnaud Schildknecht" => "arnaud.schild@gmail.com" }
  s.social_media_url   = "https://twitter.com/Nonouf11"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Nonouf/AnalyticsManager.git", :tag => "#{s.version}" }
  s.source_files  = "AnalyticsManager", "AnalyticsManager/**/*.{h,m}"
end
