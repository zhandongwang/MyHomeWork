
source 'https://github.com/CocoaPods/Specs.git'
source 'http://git.2dfire.net/ios/cocoapods-spec.git'   # 私有库

target 'MyHomeWork' do

pod 'BlocksKit'
pod 'Masonry'
pod 'YYModel'
pod 'YYCache'
pod 'YYText'
pod 'YYWebImage'
pod 'MJRefresh', '~> 2.4.7'
pod 'MBProgressHUD'
pod 'ReactiveObjC', '3.0.0'
pod 'Aspects'
pod 'CocoaSecurity'
pod 'OCTWebViewBridge'
pod 'SnapKit',  '4.0.0'
pod 'AFNetworking'
pod 'SDWebImage'
#pod 'CCDTimeSaver'
pod 'FMDB'
# pod 'Realm'
#pod 'WCDB'
pod 'MLeaksFinder'
pod 'coobjc'
#pod 'OOMDetector', '1.3'
#pod 'fishhook', '0.2'
#pod 'PLeakSniffer', :path => '~/Documents/Development/PLeakSniffer'
# pod 'CCDDataBaseHelper',  :path => '~/Documents/Development/CCDPods/ccddatabasehelper'
pod 'FL_flutter', :path => '~/Documents/Development/CCDPods/FL_flutter'

#pod 'CCDFlutterKDS', :path => '~/Documents/Development/CCDPods/CCDFlutterKDS'

swift_4_1_pod_targets = ['SnapKit']

post_install do | installer |
  installer.pods_project.targets.each do |target|
    if swift_4_1_pod_targets.include?(target.name)
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.1'
      end
    end
  end
end

end
