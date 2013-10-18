class AddHashtagToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :hashtag, :string
  end
end
