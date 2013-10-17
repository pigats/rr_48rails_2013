class Team < ActiveRecord::Base
  has_many :ninjas

  def to_param
    name
  end

end
