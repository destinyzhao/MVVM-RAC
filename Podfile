platform:ios,'9.0'
use_frameworks!
target 'MVVM+RAC' do
    pod 'MJRefresh'
    pod 'ReactiveCocoa'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end
