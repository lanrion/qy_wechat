# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)

require "qy_wechat/version"

Gem::Specification.new do |s|
  s.name        = "qy_wechat"
  s.version     = QyWechat::VERSION
  s.authors     = ["lanrion"]
  s.email       = ["huaitao-deng@foxmail.com"]
  s.homepage    = "https://github.com/lanrion/qy_wechat"
  s.summary     = "Ruby on Rails 微信企业版本"
  s.description = "Ruby on Rails 微信企业版本，应答API集成"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'railties', '>= 3.1'
  s.add_dependency 'nokogiri', '>= 1.6.1'
  s.add_runtime_dependency 'rails', '>= 3.1'

  s.add_dependency 'multi_xml', '>= 0.5.2'
  s.add_dependency 'roxml'
end
