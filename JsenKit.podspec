#
#  Be sure to run `pod spec lint JsenKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "JsenKit"
  s.version      = "1.3.15"
  s.summary      = "A iOS development of general engineering framework, including the commonly used network request package, category method, etc"
  s.description  = <<-DESC
 A iOS development of general engineering framework, including the commonly used network request package, category method, etc.
                   DESC
  s.homepage     = "https://github.com/imwangxuesen/JsenKit"
  s.license      = "MIT"
  s.author       = { "WangXuesen" => "imwangxuesen@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/imwangxuesen/JsenKit.git", :tag => s.version}
  s.resources 	 = "JsenKit/JsenProgressHUD/*.png"
  s.requires_arc = true

  s.default_subspec = 'All'
  s.subspec 'All' do |ss|
    ss.dependency 'JsenKit/JsenAlert'
    ss.dependency 'JsenKit/JsenCategory'
    ss.dependency 'JsenKit/JsenDebugTool'
    ss.dependency 'JsenKit/JsenNetworking'
    ss.dependency 'JsenKit/JsenProgressHUD'
    ss.dependency 'JsenKit/JsenTabBarController'
  end

  s.subspec 'JsenAlert' do |ss|
    ss.source_files = 'JsenKit/JsenAlert/*.{h,m}'
    	ss.dependency 'JsenKit/JsenCategory'

  end

  s.subspec 'JsenCategory' do |ss|
    ss.source_files = 'JsenKit/JsenCategory/*.{h,m}'
  end

  s.subspec 'JsenDebugTool' do |ss|
    ss.source_files = 'JsenKit/JsenDebugTool/*.{h,m}'
  end
  
  s.subspec 'JsenNetworking' do |ss|
    ss.source_files = 'JsenKit/JsenNetworking/*.{h,m}'
  		ss.dependency "AFNetworking"
  		ss.dependency "YYModel"
  end

  
  s.subspec 'JsenProgressHUD' do |ss|
    ss.source_files = 'JsenKit/JsenProgressHUD/*.{h,m}'
  end

  s.subspec 'JsenTabBarController' do |ss|
    ss.source_files = 'JsenKit/JsenTabBarController/*.{h,m}'
  end

  s.subspec 'JsenUI' do |ss|
    ss.source_files = 'JsenKit/JsenUI/*.{h,m}'
  end
  

end
