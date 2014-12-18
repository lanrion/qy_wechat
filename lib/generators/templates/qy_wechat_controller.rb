# encoding: utf-8
QyWechat::QyWechatController.class_eval do

  def reply
    render xml: send("response_#{@weixin_message.MsgType}_message", {})
  end

  private

    # text消息
    def response_text_message(options={})
      generate_text_message("Your Message: #{@keyword}")
    end

    # image消息
    def response_image_message(options={})
      generate_image_message(new_image(@weixin_message.MediaId))
    end

    # voice消息
    def response_voice_message(options={})
      generate_voice_message(new_voice(@weixin_message.MediaId))
    end

    # video消息
    def response_video_message(options={})
      generate_video_message(new_video(@weixin_message.MediaId, "desc", "title"))
    end

    # 用于响应事件
    def response_event_message(options={})
      generate_text_message("响应事件")
    end

end
