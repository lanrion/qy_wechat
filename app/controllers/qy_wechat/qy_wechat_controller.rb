# encoding: utf-8
module QyWechat
  class QyWechatController < ActionController::Base
    skip_before_filter :verify_authenticity_token, only: :reply
    before_action :setup_weixin_msg, only: :reply

    # 验证URL有效性
    def verify_url
      raise "Not Match" if not valid_msg_signature(params)
      params.delete(:qy_secret_key)
      xml_content = Prpcrypt.decrypt(aes_key, params[:echostr], corpid)
      render text: xml_content
    end

    def reply
      message = "Your message: #{@weixin_msg.Content}"
      Rails.logger.info("RECEIVE: #{message}")
      text_xml = generate_text_message(message)
      # 加密回复的XML
      encrypt_xml = Prpcrypt.encrypt(aes_key, text_xml, corpid).gsub("\n","")
      # 标准的回包
      xml = reply_encrypt_message(encrypt_xml)
      puts("标准的回包: #{xml}")
      render xml: xml
    end

    private

      def setup_weixin_msg
        @param_msg = OpenStruct.new(params)
        @xml_body = request.body.read
        hash = MultiXml.parse(@xml_body)['xml']
        xml = OpenStruct.new(hash)
        decrypt_hash = MultiXml.parse(Prpcrypt.decrypt(aes_key, xml.Encrypt, corpid))["xml"]
        @weixin_msg = OpenStruct.new(decrypt_hash)
      end

      def reply_encrypt_message(encrypt_xml)
        msg = EncryptMessage.new
        msg.Encrypt = encrypt_xml
        msg.TimeStamp = @param_msg.timestamp
        msg.Nonce = @param_msg.nonce
        msg.MsgSignature = generate_msg_signature(encrypt_xml)
        msg.to_xml
      end

      def generate_text_message(from=nil, to=nil, content)
        message = TextReplyMessage.new
        message.FromUserName = from || @weixin_msg.ToUserName
        message.ToUserName   = to   || @weixin_msg.FromUserName
        message.Content      = content
        message.AgentID      = @weixin_msg.AgentID
        message.MsgId        = @weixin_msg.MsgId
        message.to_xml
      end

      # dev_msg_signature=sha1(sort(token、timestamp、nonce、msg_encrypt))
      # 生成企业签名
      # $array = array($encrypt_msg, $token, $timestamp, $nonce);
      def generate_msg_signature(encrypt_msg)
        sort_params = [encrypt_msg, qy_token, @param_msg.timestamp, @param_msg.nonce].sort.join
        Digest::SHA1.hexdigest(sort_params)
      end

      def encoding_aes_key
        "yV6APex3UeCQJ2PtyJS5lmK2WgX66fycNEhPuyDzhMw"
      end

      def qy_token
        "StsIcF"
      end

      def aes_key
        Base64.decode64(encoding_aes_key + "=")
      end

      def corpid
        "wxb9ce1d023fe6eb69"
      end

      # String signature = SHA1.getSHA1(token, timeStamp, nonce, echoStr);
      def valid_msg_signature(params)
        timestamp         = params[:timestamp]
        nonce             = params[:nonce]
        echo_str          = params[:echostr]
        msg_signature     = params[:msg_signature]
        sort_params       = [qy_token, timestamp, nonce, echo_str].sort.join
        current_signature = Digest::SHA1.hexdigest(sort_params)
        Rails.logger.info("current_signature: #{current_signature} " )
        current_signature == msg_signature
      end
  end
end
