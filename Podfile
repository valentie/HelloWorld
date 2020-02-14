# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
use_frameworks!

def rx_swift
    pod 'RxSwift'
    pod 'RxCocoa'
end

target 'HelloWorld' do
  # Comment the next line if you don't want to use dynamic frameworks
  # Pods for HelloWorld
  pod 'SDWebImageSVGCoder'
  pod 'SkeletonView'
  
  # Rx
  rx_swift
  
  # Activity Indicator
  pod 'MBProgressHUD'
end

target 'Domain' do
  # Rx
  rx_swift
end

target 'Platform' do
  pod 'Moya/RxSwift', '~> 14.0.0-beta.6'
end
