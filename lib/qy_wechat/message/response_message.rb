# encoding: utf-8

module QyWechat

  class ResponseMessage
    include ROXML
    xml_name :xml

    xml_accessor :ToUserName, :cdata   => true
    xml_accessor :FromUserName, :cdata => true
    xml_reader   :CreateTime, :as => Integer
    xml_reader   :MsgType, :cdata => true

    def initialize
      @CreateTime = Time.now.to_i
    end

    def to_xml
      super.to_xml(:encoding => 'UTF-8', :indent => 0, :save_with => 0)
    end
  end

  # <xml>
  # <ToUserName><![CDATA[toUser]]></ToUserName>
  # <FromUserName><![CDATA[fromUser]]></FromUserName>
  # <CreateTime>12345678</CreateTime>
  # <MsgType><![CDATA[text]]></MsgType>
  # <Content><![CDATA[Hello]]></Content>
  # </xml>

  class TextResponseMessage < ResponseMessage
    xml_accessor :Content, :cdata => true
    def initialize
      super
      @MsgType = 'text'
    end
  end

  class Article
    include ROXML
    xml_accessor :Title, :cdata => true
    xml_accessor :Description, :cdata => true
    xml_accessor :PicUrl, :cdata => true
    xml_accessor :Url,    :cdata => true
  end

  # <xml>
  # <ToUserName><![CDATA[toUser]]></ToUserName>
  # <FromUserName><![CDATA[fromUser]]></FromUserName>
  # <CreateTime>12345678</CreateTime>
  # <MsgType><![CDATA[news]]></MsgType>
  # <ArticleCount>2</ArticleCount>
  # <Articles>
  # <item>
  # <Title><![CDATA[title1]]></Title>
  # <Description><![CDATA[description1]]></Description>
  # <PicUrl><![CDATA[picurl]]></PicUrl>
  # <Url><![CDATA[url]]></Url>
  # </item>
  # <item>
  # <Title><![CDATA[title]]></Title>
  # <Description><![CDATA[description]]></Description>
  # <PicUrl><![CDATA[picurl]]></PicUrl>
  # <Url><![CDATA[url]]></Url>
  # </item>
  # </Articles>
  # </xml>

  class NewsResponseMessage < ResponseMessage
    xml_accessor :ArticleCount, :as => Integer
    xml_accessor :Articles, :as => [Article], :in => 'Articles', :from => 'item'
    def initialize
      super
      @MsgType = 'news'
    end
  end

  # <xml>
  # <ToUserName><![CDATA[toUser]]></ToUserName>
  # <FromUserName><![CDATA[fromUser]]></FromUserName>
  # <CreateTime>12345678</CreateTime>
  # <MsgType><![CDATA[video]]></MsgType>
  # <Video>
  # <MediaId><![CDATA[media_id]]></MediaId>
  # <Title><![CDATA[title]]></Title>
  # <Description><![CDATA[description]]></Description>
  # </Video>
  # </xml>

  class Video
    include ROXML
    xml_accessor :MediaId, :cdata => true
    xml_accessor :Description, :cdata => true
    xml_accessor :Title, :cdata => true
  end

  class VideoResponseMessage < ResponseMessage
    xml_accessor :Video, :as => Video
    def initialize
      super
      @MsgType = 'video'
    end
  end

  # <xml>
  # <ToUserName><![CDATA[toUser]]></ToUserName>
  # <FromUserName><![CDATA[fromUser]]></FromUserName>
  # <CreateTime>12345678</CreateTime>
  # <MsgType><![CDATA[voice]]></MsgType>
  # <Voice>
  # <MediaId><![CDATA[media_id]]></MediaId>
  # </Voice>
  # </xml>
  class Voice
    include ROXML
    xml_accessor :MediaId, :cdata => true
  end

  class VoiceResponseMessage < ResponseMessage
    xml_accessor :Voice, :as => Voice
    def initialize
      super
      @MsgType = 'voice'
    end
  end

  # <xml>
  # <ToUserName><![CDATA[toUser]]></ToUserName>
  # <FromUserName><![CDATA[fromUser]]></FromUserName>
  # <CreateTime>12345678</CreateTime>
  # <MsgType><![CDATA[image]]></MsgType>
  # <Image>
  # <MediaId><![CDATA[media_id]]></MediaId>
  # </Image>
  # </xml>

  class Image
    include ROXML
    xml_accessor :MediaId, :cdata => true
  end

  class ImageResponseMessage < ResponseMessage
    xml_accessor :Image, :as => Image
    def initialize
      super
      @MsgType = 'image'
    end
  end

end
