Pod::Spec.new do |spec|

  spec.name         = "CrossDK"
  spec.platform     = :ios, '10.0'
  spec.version      = "release"
  spec.summary      = "Cross-promote an application catalog"

  spec.description  = <<-DESC
  CrossDK is a solution belonging to Adikteev. The goal is to allow its users to cross-promote their application catalog through the SKOverlay class.
  DESC

  spec.homepage     = "https://github.com/CocoaPods/Specs/search?o=desc&q=CrossDK&s=indexed"

  spec.license      = "MIT"
  spec.author       = "Adikteev"

  spec.source       = { :git => "https://github.com/Adikteev/crossdk-ios.git", :tag => "#{spec.version}" }
  spec.vendored_frameworks = "Products/CrossDK.xcframework"

end
