Pod::Spec.new do |spec|
  spec.name         = 'OpenCastSwift'
  spec.version      = '1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/MoonshineSG/OpenCastSwift'
  spec.author        = 'Miles Hollingsworth, MoonshineSG'
  spec.summary      = 'An open source implementation of the Google Cast SDK written in Swift.'
  spec.source       = { :git => 'https://github.com/MoonshineSG/OpenCastSwift.git', :tag => 'v1.0' }
  spec.ios.deployment_target = '13.6'
  spec.source_files = 'Source/**/*.swift'
  spec.swift_version = '5.0'
	spec.dependency 'SwiftyJSON'
	spec.dependency 'SwiftProtobuf'
end