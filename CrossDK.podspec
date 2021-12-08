Pod::Spec.new do |spec|

  spec.name         = "CrossDK"
  spec.version      = "2.1.0"
  spec.summary      = "Cross-promote an application catalog"

  spec.description  = <<-DESC
  CrossDK is a solution belonging to Adikteev. The goal is to allow its users to cross-promote their application catalog through the SKOverlay class.
                   DESC

  spec.homepage     = "http://EXAMPLE/CrossDK"

  spec.license      = "MIT"
  spec.author       = "Adikteev"

  spec.source       = { :git => "https://github.com/Adikteev/crossdk-ios", :tag => "#{spec.version}" }
  spec.vendored_frameworks = "Products/CrossDK.xcframework"

end
