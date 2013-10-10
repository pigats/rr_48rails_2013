require 'koala'

class FacebookFaces

  def self.all
    Rails.cache.fetch("FacebookFacesAll", :expires_in => 12.hours) do
      oauth = Koala::Facebook::OAuth.new
      fb = Koala::Facebook::API.new(oauth.get_app_access_token)
      fb.get_connections('222866994508573','members').map {|person| {:name => person["name"], :src => fb.get_picture(person["id"], type: 'square')} }
    end
  end
end
