Pod::Spec.new do |spec|

  spec.name         = "CrossDK"
  spec.platform     = :ios, '10.0'
  spec.version      = "3.2.0"
  spec.summary      = "Cross-promote an application catalog"

  spec.description  = <<-DESC
  CrossDK is a solution belonging to Adikteev. The goal is to allow its users to cross-promote their application catalog through the SKOverlay class.
  DESC

  spec.homepage     = "https://github.com/CocoaPods/Specs/search?o=desc&q=#{spec.name}&s=indexed"

  spec.license      = "MIT"
  spec.author       = "Adikteev"

  spec.source       = { :git => "https://github.com/Adikteev/crossdk-ios.git", :tag => "#{spec.version}" }
  spec.vendored_frameworks = "Products/CrossDK.xcframework"

  spec.pod_target_xcconfig =
  {
    'VALID_ARCHS' => 'arm64 arm64e armv7 armv7s x86_64',
    'VALID_ARCHS[sdk=iphoneos*]' => 'arm64 arm64e armv7 armv7s',
    'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64'
  }

end
