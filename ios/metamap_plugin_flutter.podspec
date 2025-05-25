Pod::Spec.new do |s|
  s.name             = 'metamap_plugin_flutter'
  s.version          = '4.4.11'
  s.summary          = 'Flutter plugin for MetaMap SDK'
  s.description      = <<-DESC
Flutter plugin for Mati SDK
                       DESC
  s.homepage         = 'http://getmati.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'MetaMap' => 'avetik.sukiasyan@metamap.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13'
  s.static_framework = true
  s.dependency 'MetaMapSDK', "3.23.0"
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end