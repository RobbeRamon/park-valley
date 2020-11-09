platform :ios, '13.0'


target 'ParkValley' do
  use_frameworks!
  
  pod 'lottie-ios'
  pod 'Cards'
  
  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings['LD_RUNPATH_SEARCH_PATHS'] = [
        '$(FRAMEWORK_SEARCH_PATHS)'
      ]
    end
  end
end



