Pod::Spec.new do |s|
s.name         = 'WYNetworkManager'
s.version      = '0.1.1'
s.summary      = '网络请求管理类'
s.homepage     = 'https://github.com/shuxiongWu/WYNetworkManager.git'
s.license      = { :type => "MIT", :file => "LICENSE" }
s.authors      = {'wushuxiong' => '18779884209@163.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/shuxiongWu/WYNetworkManager.git', :tag => s.version}
s.source_files = 'WYNetWorking/WYNetworkManager/*.{h,m}'

s.dependency 'AFNetworking', '~>4.0.1'
s.dependency 'YYCache'
s.requires_arc = true

end