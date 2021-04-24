# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RobustaTask' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for RobustaTask
  pod 'Swinject'

  target 'RobustaTaskTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RobustaTaskUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.4'
    end
  end
end
