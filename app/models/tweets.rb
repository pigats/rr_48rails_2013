require 'twitter'

class Tweets

  def self.last(n=1)
    @tweets = Twitter.user_timeline('48rails').first(n)
  end

end



class Twitter::Tweet

  def to_html
    html = self.full_text
    entities = []
    [:user_mentions, :hashtags, :urls, :media].each do |t|
      self[t].each do |e|
        text = full_text[e.indices[0]...e.indices[1]]       
        text_html = self.class.send(t.to_s + '_to_html', text, e)
        entities << {text: text, html: text_html, insertion_index: e.indices[0]}
      end
    end
    entities.sort {|a, b| a[:insertion_index] <=> b[:insertion_index]}
    
    offset = 0
    entities.each do |e|
      html.slice!(e[:insertion_index] + offset, e[:text].length)
      html.insert(e[:insertion_index] + offset, e[:html])
      offset = offset + e[:html].length - e[:text].length
    end
    
    html
  end

  def status_url
    "http://twitter.com/48rails/status/#{self.id}"
  end

  private

    def self.user_mentions_to_html(string, entity)
      "<a href='http://twitter.com/#{entity.screen_name}' target='_blank'>#{string}</a>"
    end

    def self.hashtags_to_html(string, entity)
      "<a href='http://twitter.com/search?q=%23#{entity.text}' target='_blank'>#{string}</a>"
    end

    def self.urls_to_html(string, entity)
      "<a href='#{entity.url}' target='_blank'>#{entity.display_url}</a>"
    end

    def self.media_to_html(string, entity)
      "<img src='#{entity.media_url}' alt='#{string}' />"
    end
end