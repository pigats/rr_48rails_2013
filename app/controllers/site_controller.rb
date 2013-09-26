require 'koala'

class SiteController < ApplicationController
  def index
    oauth = Koala::Facebook::OAuth.new 
    fb = Koala::Facebook::API.new(oauth.get_app_access_token)
    @fb_group = fb.get_connections('222866994508573','members').map {|person| {:name => person["name"], :src => fb.get_picture(person["id"], type: 'square')}}

  end

  def landing_page
  end
end
