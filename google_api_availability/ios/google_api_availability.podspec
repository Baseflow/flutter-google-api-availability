#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'google_api_availability'
  s.version          = '2.0.4'
  s.summary          = 'A Flutter plugin to check the availability of Google Play Services on an Android device.'
  s.description      = <<-DESC
A Flutter plugin to check the availability of Google Play Services on an Android device.
                       DESC
  s.homepage         = 'https://github.com/baseflowit/flutter-google-api-availability'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Baseflow' => 'hello@baseflow.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end

