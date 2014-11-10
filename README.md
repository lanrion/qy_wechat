对接企业微信应答：
https://github.com/lanrion/qy_wechat

(对应公众号gem：https://github.com/lanrion/weixin_rails_middleware)

## 安装

目前只有Master稳定版本，务必通过：
```ruby
gem 'qy_wechat', git: 'https://github.com/lanrion/qy_wechat.git'
```
安装。

## 使用

示例：https://github.com/lanrion/qy_wechat_example

```ruby
rails g qy_wechat:install
rails g qy_wechat:migration QyAccount # QyAccount 你保存企业号的Model
```
分别会产生:

配置保存企业微信账号的Model:
`qy_wechat_example/config/initializers/qy_wechat_config.rb`

这里实现你的业务逻辑:
`qy_wechat_example/app/decorators/controllers/qy_wechat/qy_wechat_controller_decorator.rb`

同时在你的QyAccount中添加如下代码生成你的qy_secret_key：
```ruby
class QyAccount < ActiveRecord::Base

  before_create :init_qy_secret_key

  private

    def init_qy_secret_key
      self.qy_secret_key = SecureRandom.hex(8)
    end
end
```

## 生成服务验证URL

`qy_wechat_engine.qy_verify_url(qy_account.qy_secret_key)`

## issue

欢迎提交使用中的bug，或者改进意见：https://github.com/lanrion/qy_wechat/issues/new
