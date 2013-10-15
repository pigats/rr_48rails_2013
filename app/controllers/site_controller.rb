
class SiteController < ApplicationController
  def index
    @teams = Team.order(:sort)
    @faces = FacebookFaces.all
    @tweets = Tweets.last(3)

  end

  def landing_page
  end
end
