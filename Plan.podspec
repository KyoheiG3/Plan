Pod::Spec.new do |s|
  s.name             = 'Plan'
  s.version          = '0.1.0'
  s.swift_version    = '5.0'
  s.summary          = 'The Plan.framework helps to keep your iOS application design clean.'
  s.homepage         = 'https://github.com/KyoheiG3/Plan'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kyohei Ito' => 'ito_kyohei@cyberagent.co.jp' }
  s.source           = { :git => 'https://github.com/KyoheiG3/Plan.git', :tag => s.version.to_s }
  s.ios.deployment_target       = '10.0'
  s.tvos.deployment_target      = '10.0'
  s.osx.deployment_target       = '10.12'
  s.watchos.deployment_target   = '3.0'
  s.source_files     = 'Plan/**/*.{h,swift}'
  s.requires_arc     = true
end
