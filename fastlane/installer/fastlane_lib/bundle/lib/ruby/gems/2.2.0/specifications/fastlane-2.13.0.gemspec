# -*- encoding: utf-8 -*-
# stub: fastlane 2.13.0 ruby cert/lib credentials_manager/lib deliver/lib fastlane/lib fastlane_core/lib frameit/lib gym/lib match/lib pem/lib pilot/lib produce/lib scan/lib screengrab/lib sigh/lib snapshot/lib spaceship/lib supply/lib

Gem::Specification.new do |s|
  s.name = "fastlane".freeze
  s.version = "2.13.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["cert/lib".freeze, "credentials_manager/lib".freeze, "deliver/lib".freeze, "fastlane/lib".freeze, "fastlane_core/lib".freeze, "frameit/lib".freeze, "gym/lib".freeze, "match/lib".freeze, "pem/lib".freeze, "pilot/lib".freeze, "produce/lib".freeze, "scan/lib".freeze, "screengrab/lib".freeze, "sigh/lib".freeze, "snapshot/lib".freeze, "spaceship/lib".freeze, "supply/lib".freeze]
  s.authors = ["Felix Krause".freeze, "Michael Furtak".freeze, "Andrea Falcone".freeze, "David Ohayon".freeze, "Mark Pirri".freeze, "Hemal Shah".freeze, "Manuel Wallner".freeze]
  s.date = "2017-01-30"
  s.description = "The easiest way to automate beta deployments and releases for your iOS and Android apps".freeze
  s.email = ["fastlane@krausefx.com".freeze]
  s.executables = ["bin-proxy".freeze, "fastlane".freeze]
  s.files = ["bin/bin-proxy".freeze, "bin/fastlane".freeze]
  s.homepage = "https://fastlane.tools".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.5.2".freeze
  s.summary = "The easiest way to automate beta deployments and releases for your iOS and Android apps".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<slack-notifier>.freeze, ["< 2.0.0", ">= 1.3"])
      s.add_runtime_dependency(%q<xcodeproj>.freeze, ["< 2.0.0", ">= 0.20"])
      s.add_runtime_dependency(%q<xcpretty>.freeze, ["< 1.0.0", ">= 0.2.4"])
      s.add_runtime_dependency(%q<terminal-notifier>.freeze, ["< 2.0.0", ">= 1.6.2"])
      s.add_runtime_dependency(%q<terminal-table>.freeze, ["< 2.0.0", ">= 1.4.5"])
      s.add_runtime_dependency(%q<plist>.freeze, ["< 4.0.0", ">= 3.1.0"])
      s.add_runtime_dependency(%q<addressable>.freeze, ["< 3.0.0", ">= 2.3"])
      s.add_runtime_dependency(%q<multipart-post>.freeze, ["~> 2.0.0"])
      s.add_runtime_dependency(%q<word_wrap>.freeze, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<babosa>.freeze, ["< 2.0.0", ">= 1.0.2"])
      s.add_runtime_dependency(%q<colored>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<commander>.freeze, ["< 5.0.0", ">= 4.4.0"])
      s.add_runtime_dependency(%q<excon>.freeze, ["< 1.0.0", ">= 0.45.0"])
      s.add_runtime_dependency(%q<faraday-cookie_jar>.freeze, ["~> 0.0.6"])
      s.add_runtime_dependency(%q<fastimage>.freeze, [">= 1.6"])
      s.add_runtime_dependency(%q<gh_inspector>.freeze, ["< 2.0.0", ">= 1.0.1"])
      s.add_runtime_dependency(%q<google-api-client>.freeze, ["~> 0.9.2"])
      s.add_runtime_dependency(%q<highline>.freeze, ["< 2.0.0", ">= 1.7.2"])
      s.add_runtime_dependency(%q<json>.freeze, ["< 3.0.0"])
      s.add_runtime_dependency(%q<mini_magick>.freeze, ["~> 4.5.1"])
      s.add_runtime_dependency(%q<multi_json>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<multi_xml>.freeze, ["~> 0.5"])
      s.add_runtime_dependency(%q<rubyzip>.freeze, ["< 2.0.0", ">= 1.1.0"])
      s.add_runtime_dependency(%q<security>.freeze, ["= 0.1.3"])
      s.add_runtime_dependency(%q<xcpretty-travis-formatter>.freeze, [">= 0.0.3"])
      s.add_runtime_dependency(%q<dotenv>.freeze, ["< 3.0.0", ">= 2.1.1"])
      s.add_runtime_dependency(%q<bundler>.freeze, ["< 2.0.0", ">= 1.12.0"])
      s.add_runtime_dependency(%q<faraday>.freeze, ["~> 0.9"])
      s.add_runtime_dependency(%q<faraday_middleware>.freeze, ["~> 0.9"])
      s.add_runtime_dependency(%q<activesupport>.freeze, ["< 5"])
      s.add_development_dependency(%q<rake>.freeze, ["< 12"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_development_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.2.3"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry-byebug>.freeze, [">= 0"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.8.7.4"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 1.19.0"])
      s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.8.13"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.47"])
      s.add_development_dependency(%q<rb-readline>.freeze, [">= 0"])
      s.add_development_dependency(%q<rest-client>.freeze, ["~> 1.6.7"])
      s.add_development_dependency(%q<fakefs>.freeze, ["~> 0.8.1"])
    else
      s.add_dependency(%q<slack-notifier>.freeze, ["< 2.0.0", ">= 1.3"])
      s.add_dependency(%q<xcodeproj>.freeze, ["< 2.0.0", ">= 0.20"])
      s.add_dependency(%q<xcpretty>.freeze, ["< 1.0.0", ">= 0.2.4"])
      s.add_dependency(%q<terminal-notifier>.freeze, ["< 2.0.0", ">= 1.6.2"])
      s.add_dependency(%q<terminal-table>.freeze, ["< 2.0.0", ">= 1.4.5"])
      s.add_dependency(%q<plist>.freeze, ["< 4.0.0", ">= 3.1.0"])
      s.add_dependency(%q<addressable>.freeze, ["< 3.0.0", ">= 2.3"])
      s.add_dependency(%q<multipart-post>.freeze, ["~> 2.0.0"])
      s.add_dependency(%q<word_wrap>.freeze, ["~> 1.0.0"])
      s.add_dependency(%q<babosa>.freeze, ["< 2.0.0", ">= 1.0.2"])
      s.add_dependency(%q<colored>.freeze, [">= 0"])
      s.add_dependency(%q<commander>.freeze, ["< 5.0.0", ">= 4.4.0"])
      s.add_dependency(%q<excon>.freeze, ["< 1.0.0", ">= 0.45.0"])
      s.add_dependency(%q<faraday-cookie_jar>.freeze, ["~> 0.0.6"])
      s.add_dependency(%q<fastimage>.freeze, [">= 1.6"])
      s.add_dependency(%q<gh_inspector>.freeze, ["< 2.0.0", ">= 1.0.1"])
      s.add_dependency(%q<google-api-client>.freeze, ["~> 0.9.2"])
      s.add_dependency(%q<highline>.freeze, ["< 2.0.0", ">= 1.7.2"])
      s.add_dependency(%q<json>.freeze, ["< 3.0.0"])
      s.add_dependency(%q<mini_magick>.freeze, ["~> 4.5.1"])
      s.add_dependency(%q<multi_json>.freeze, [">= 0"])
      s.add_dependency(%q<multi_xml>.freeze, ["~> 0.5"])
      s.add_dependency(%q<rubyzip>.freeze, ["< 2.0.0", ">= 1.1.0"])
      s.add_dependency(%q<security>.freeze, ["= 0.1.3"])
      s.add_dependency(%q<xcpretty-travis-formatter>.freeze, [">= 0.0.3"])
      s.add_dependency(%q<dotenv>.freeze, ["< 3.0.0", ">= 2.1.1"])
      s.add_dependency(%q<bundler>.freeze, ["< 2.0.0", ">= 1.12.0"])
      s.add_dependency(%q<faraday>.freeze, ["~> 0.9"])
      s.add_dependency(%q<faraday_middleware>.freeze, ["~> 0.9"])
      s.add_dependency(%q<activesupport>.freeze, ["< 5"])
      s.add_dependency(%q<rake>.freeze, ["< 12"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.2.3"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<pry-byebug>.freeze, [">= 0"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.8.7.4"])
      s.add_dependency(%q<webmock>.freeze, ["~> 1.19.0"])
      s.add_dependency(%q<coveralls>.freeze, ["~> 0.8.13"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.47"])
      s.add_dependency(%q<rb-readline>.freeze, [">= 0"])
      s.add_dependency(%q<rest-client>.freeze, ["~> 1.6.7"])
      s.add_dependency(%q<fakefs>.freeze, ["~> 0.8.1"])
    end
  else
    s.add_dependency(%q<slack-notifier>.freeze, ["< 2.0.0", ">= 1.3"])
    s.add_dependency(%q<xcodeproj>.freeze, ["< 2.0.0", ">= 0.20"])
    s.add_dependency(%q<xcpretty>.freeze, ["< 1.0.0", ">= 0.2.4"])
    s.add_dependency(%q<terminal-notifier>.freeze, ["< 2.0.0", ">= 1.6.2"])
    s.add_dependency(%q<terminal-table>.freeze, ["< 2.0.0", ">= 1.4.5"])
    s.add_dependency(%q<plist>.freeze, ["< 4.0.0", ">= 3.1.0"])
    s.add_dependency(%q<addressable>.freeze, ["< 3.0.0", ">= 2.3"])
    s.add_dependency(%q<multipart-post>.freeze, ["~> 2.0.0"])
    s.add_dependency(%q<word_wrap>.freeze, ["~> 1.0.0"])
    s.add_dependency(%q<babosa>.freeze, ["< 2.0.0", ">= 1.0.2"])
    s.add_dependency(%q<colored>.freeze, [">= 0"])
    s.add_dependency(%q<commander>.freeze, ["< 5.0.0", ">= 4.4.0"])
    s.add_dependency(%q<excon>.freeze, ["< 1.0.0", ">= 0.45.0"])
    s.add_dependency(%q<faraday-cookie_jar>.freeze, ["~> 0.0.6"])
    s.add_dependency(%q<fastimage>.freeze, [">= 1.6"])
    s.add_dependency(%q<gh_inspector>.freeze, ["< 2.0.0", ">= 1.0.1"])
    s.add_dependency(%q<google-api-client>.freeze, ["~> 0.9.2"])
    s.add_dependency(%q<highline>.freeze, ["< 2.0.0", ">= 1.7.2"])
    s.add_dependency(%q<json>.freeze, ["< 3.0.0"])
    s.add_dependency(%q<mini_magick>.freeze, ["~> 4.5.1"])
    s.add_dependency(%q<multi_json>.freeze, [">= 0"])
    s.add_dependency(%q<multi_xml>.freeze, ["~> 0.5"])
    s.add_dependency(%q<rubyzip>.freeze, ["< 2.0.0", ">= 1.1.0"])
    s.add_dependency(%q<security>.freeze, ["= 0.1.3"])
    s.add_dependency(%q<xcpretty-travis-formatter>.freeze, [">= 0.0.3"])
    s.add_dependency(%q<dotenv>.freeze, ["< 3.0.0", ">= 2.1.1"])
    s.add_dependency(%q<bundler>.freeze, ["< 2.0.0", ">= 1.12.0"])
    s.add_dependency(%q<faraday>.freeze, ["~> 0.9"])
    s.add_dependency(%q<faraday_middleware>.freeze, ["~> 0.9"])
    s.add_dependency(%q<activesupport>.freeze, ["< 5"])
    s.add_dependency(%q<rake>.freeze, ["< 12"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.2.3"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<pry-byebug>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.8.7.4"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1.19.0"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.8.13"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.47"])
    s.add_dependency(%q<rb-readline>.freeze, [">= 0"])
    s.add_dependency(%q<rest-client>.freeze, ["~> 1.6.7"])
    s.add_dependency(%q<fakefs>.freeze, ["~> 0.8.1"])
  end
end
