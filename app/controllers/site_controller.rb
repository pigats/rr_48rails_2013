
class SiteController < ApplicationController
  def index
    @teams = Team.all
    @faces = FacebookFaces.all
    @tweets = Tweets.last(3)

  end

  def landing_page
  end
end
