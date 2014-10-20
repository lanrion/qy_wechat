QyWechat::Engine.routes.draw do
  get  "qy_wechat/:qy_secret_key", to: "qy_wechat#verify_url", as: :qy_verify
  post "qy_wechat/:qy_secret_key", to: "qy_wechat#reply", as: :qy_reply_reply
end
