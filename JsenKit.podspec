Pod::Spec.new do |s|
d::Spec.new do |s|
  s.name         = 'JsenKit'
  s.summary      = 'A iOS development of general engineering framework, including the commonly used network request package, category method, etc'
  s.version      = '1.0.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'Wangxuesen' => 'imwangxuesen@icloud.com' }
  s.homepage     = 'https://github.com/imwangxuesen/JsenKit'
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/huxiaoyang/HYToast.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.source_files = 'JsenKit/**/*.{h,m}'

  s.frameworks = 'UIKit', 'Foundation'
  s.module_name = 'JsenKit'

  s.dependency "YYModel"
  s.dependency "AFNetworking"

end
