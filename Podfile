# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                 config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end


    pod 'XCGLogger', '~> 4.0.0'
    pod 'BadgeSwift', '~> 4.0'
    pod 'SwiftIconFont'
    pod 'SnapKit', '~> 3.0'
    pod 'SwiftyVIPER' #, :git => 'https://github.com/codytwinton/SwiftyVIPER.git'
    pod 'RxSwift' #, '~> 3.1.0'
    pod 'RxCocoa',    '~> 3.0'
    pod 'RxAlamofire', :git => 'https://github.com/RxSwiftCommunity/RxAlamofire.git'
    pod 'SwiftyJSON'
    pod 'ImageLoader'
    pod 'Toucan'
    pod 'Kamagari'
    pod 'JTAppleCalendar', '~> 6.0'
    pod "KCFloatingActionButton", "~> 2.1.0"
    pod "Eureka" , :git => "https://github.com/xmartlabs/Eureka.git" , :commit => "3efe00e9a65a48c8823e7622dcd478efdc78b753"
    pod 'Moya' , '8.0.1'
    pod 'Moya/RxSwift'
    pod 'SwiftyUserDefaults'
    pod 'RocketData'
    pod 'PINCache', :git => 'https://github.com/pinterest/PINCache.git', :commit => '58635e4ff8d00fcd25084259a625c0615e9d071a'
    pod 'Fusuma'
#    pod "Timepiece"
    pod 'SwiftDate', '~> 4.0'
    pod 'SwiftyTimer'




target 'momoStore' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for momoStore

  target 'momoStoreTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'momoStoreUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
