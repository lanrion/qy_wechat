$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "qy_wechat/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "qy_wechat"
  s.version     = QyWechat::VERSION
  s.authors     = ["lanrion"]
  s.email       = ["huaitao-deng@foxmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of QyWechat."
  s.description = "TODO: Description of QyWechat."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0.beta1"

  s.add_development_dependency "sqlite3"
end
