# encoding: utf-8

module QyWechat
  module ReplyMessageHelper

    def generate_text_message(from=nil, to=nil, content)
      message = TextResponseMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Content      = content
      encrypt_message(message.to_xml)
    end

    def new_article(title, desc, pic_url, link_url)
      item = Article.new
      item.Title       = title
      item.Description = desc
      item.PicUrl = pic_url
      item.Url    = link_url
      item
    end

    def generate_news_message(from=nil, to=nil, articles)
      message = NewsResponseMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Articles     = articles
      message.ArticleCount = articles.count
      encrypt_message message.to_xml
    end

    def new_video(media_id, desc, title)
      video = Video.new
      video.MediaId = media_id
      video.Title   = title
      video.Description = desc
      video
    end

    def generate_video_message(from=nil, to=nil, video)
      message = VideoResponseMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Video = video
      encrypt_message message.to_xml
    end

    def new_voice(media_id)
      voice = Voice.new
      voice.MediaId = media_id
      voice
    end

    def generate_voice_message(from=nil, to=nil, voice)
      message = VoiceResponseMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Voice = voice
      encrypt_message message.to_xml
    end

    def new_image(media_id)
      image = Image.new
      image.MediaId = media_id
      image
    end

    def generate_image_message(from=nil, to=nil, image)
      message = ImageResponseMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Image = image
      encrypt_message message.to_xml
    end

    private

      def encrypt_message(msg_xml)
        # 加密回复的XML
        encrypt_xml = Prpcrypt.encrypt(aes_key, msg_xml, corp_id).gsub("\n","")
        # 标准的回包
        generate_encrypt_message(encrypt_xml)
      end

      def generate_encrypt_message(encrypt_xml)
        msg = EncryptMessage.new
        msg.Encrypt = encrypt_xml
        msg.TimeStamp = Time.now.to_i.to_s
        msg.Nonce = SecureRandom.hex(8)
        msg.MsgSignature = generate_msg_signature(encrypt_xml, msg)
        msg.to_xml
      end

      # dev_msg_signature=sha1(sort(token、timestamp、nonce、msg_encrypt))
      # 生成企业签名
      def generate_msg_signature(encrypt_msg, msg)
        sort_params = [encrypt_msg, qy_token, msg.TimeStamp, msg.Nonce].sort.join
        Digest::SHA1.hexdigest(sort_params)
      end

  end
end
