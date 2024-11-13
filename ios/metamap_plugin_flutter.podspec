#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint metamap_plugin_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'metamap_plugin_flutter'
  s.version          = '4.3.9'
  s.summary          = 'Flutter plugin for Mati SDK'
  s.description      = <<-DESC
Flutter plugin for Mati SDK
                       DESC
  s.homepage         = 'http://getmati.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mati' => 'avetik.sukiasyan@metamap.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13'
  s.static_framework = true
  s.dependency 'MetaMapSDK', "3.22.1"
  s.vendored_frameworks = ["IncdOnboarding.xcframework", "opencv2.xcframework"]
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version       = '5.0'
end
