

Pod::Spec.new do |s|
  s.name             = 'CHParallaxHeaderView'
  s.version          = '1.1.0'
  s.summary          = '使用Swfit扩展为UIView添加随UIScrollView滚动产生视差效果'

  s.description      = <<-DESC
使用Swfit扩展为UIView添加随UIScrollView滚动产生视差效果，实现了UINavigationBar滚动UIScrollView时渐变，UIView随UIScrollView滚动缩放
                       DESC

  s.homepage         = 'https://github.com/zhiquan911/CHParallaxHeaderView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chance' => 'zhiquan911@qq.com' }
  s.source           = { :git => 'https://github.com/zhiquan911/CHParallaxHeaderView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'CHParallaxHeaderView/Classes/**/*'

end


#验证命令：pod lib lint CHParallaxHeaderView.podspec --verbose
#提交命令：pod trunk push CHParallaxHeaderView.podspec
