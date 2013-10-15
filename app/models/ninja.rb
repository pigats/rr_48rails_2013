require 'twitter'
require 'koala'

class Ninja < ActiveRecord::Base
  belongs_to :team


  def face 
    Rails.cache.fetch("ninjaFace#{id}", :expires_in => 12.hours) do       
      unless twitter.blank?
        Twitter.user(twitter).profile_image_url()
      else unless facebook.blank?
        Koala::Facebook::API.new.get_picture(facebook)  
      end 
      end
    end
  end

end
