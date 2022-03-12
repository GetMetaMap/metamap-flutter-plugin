#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mati_plugin_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'mati_plugin_flutter'
  s.version          = '2.2.2'
  s.summary          = 'Flutter plugin for Mati SDK'
  s.description      = <<-DESC
Flutter plugin for Mati SDK
                       DESC
  s.homepage         = 'http://getmati.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mati' => 'andrey.posnov@mati.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12'
  s.dependency 'MetaMap-Global-ID-SDK'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
