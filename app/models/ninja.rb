require 'twitter'
require 'koala'

class Ninja < ActiveRecord::Base
  belongs_to :team


  def face 
    Rails.cache.fetch("ninjaFace#{name}", :expires_in => 12.hours) do       
      return Twitter.user(twitter).profile_image_url() unless twitter.blank?
      return Koala::Facebook::API.new.get_picture(facebook) unless facebook.blank?
    end
  end

end
