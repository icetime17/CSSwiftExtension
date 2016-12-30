Pod::Spec.new do |s|

  s.name         = "CSSwiftExtension"
  s.version      = "0.0.7"
  s.summary      = "Some ***useful extension for Swift*** to boost your productivity."

  s.description  = <<-DESC
                    Some ***useful extension for Swift*** to boost your productivity.
                    Including Foundation, UIKit.
                   DESC

  s.homepage     = "https://github.com/icetime17/CSSwiftExtension"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author       = { "Chris Hu" => "icetime17@126.com" }

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"

  s.source       = { :git => "https://github.com/icetime17/CSSwiftExtension.git", :tag => s.version }

  s.source_files  = "Sources/**/*.swift"

  s.requires_arc = true

end
