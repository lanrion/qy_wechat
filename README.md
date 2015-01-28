对接企业微信应答：
https://github.com/lanrion/qy_wechat

(对应公众号gem：https://github.com/lanrion/weixin_rails_middleware)

企业微信高级API：https://github.com/lanrion/qy_wechat_api

[![Gem Version](https://badge.fury.io/rb/qy_wechat.svg)](http://badge.fury.io/rb/qy_wechat)

**重要说明：后期开发，不再支持Rails 4以下版本!**

Rails 3 版本请使用（不再维护）:

**特别注意： 由于一个企业号，可以对应多个应用，可以根据 `corp_id` 关联你保存对应的企业号应用。**

```ruby
gem 'qy_wechat', git: 'https://github.com/lanrion/qy_wechat.git', branch: "rails3"
```

## 安装

```ruby
gem 'qy_wechat', '~> 1.0.1'
# 或者
gem 'qy_wechat', git: 'https://github.com/lanrion/qy_wechat.git'
```
安装。

## 使用

示例：https://github.com/lanrion/qy_wechat_example

```ruby
rails g qy_wechat:install
rails g qy_wechat:migration QyApp # QyAapp 你保存企业号应用的Model
```
分别会产生:

配置保存企业微信账号的Model:
`qy_wechat_example/config/initializers/qy_wechat_config.rb`

这里实现你的业务逻辑:
`qy_wechat_example/app/decorators/controllers/qy_wechat/qy_wechat_controller_decorator.rb`

同时添加以下4个字段：

* qy_token
* encoding_aes_key # 长度固定为43个字符，从a-z, A-Z, 0-9共62个字符中选取
* corp_id
* qy_secret_key # 用于标志属于哪个应用

最后在你的QyApp中添加如下代码生成你的qy_secret_key：
```ruby
class QyApp < ActiveRecord::Base

  before_create :init_qy_secret_key

  private

    def init_qy_secret_key
      self.qy_secret_key = SecureRandom.hex(8)
    end
end
```

## 生成服务验证URL

`qy_wechat_engine.qy_verify_url(qy_app.qy_secret_key)`

## issue

欢迎提交使用中的bug，或者改进意见：https://github.com/lanrion/qy_wechat/issues/new
