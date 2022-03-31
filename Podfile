platform :ios, '11.0'
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
inhibit_all_warnings!

target 'ios-dev-interview' do

  pod 'Alamofire', '~> 5'
  pod 'Moya/RxSwift', '~> 14.0'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'R.swift'
  pod 'Kingfisher'
  pod 'SwifterSwift'
  pod 'UICircularProgressRing'
  pod 'Localize-Swift', '~> 2.0'
  pod 'SnapKit', '~> 5.0.0'

  target 'ios-dev-interview-tests' do
      inherit! :search_paths
      pod 'RxTest', :configurations => ['Debug']
      pod 'KIF', :configurations => ['Debug']
      pod 'OHHTTPStubs/Swift', '~> 8.0.0', :configurations => ['Debug']
      pod 'Alamofire', '~> 5', :configurations => ['Debug']
      pod 'Moya/RxSwift', '~> 14.0', :configurations => ['Debug']
  end

end
