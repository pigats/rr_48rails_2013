class CreateNinjas < ActiveRecord::Migration
  def change
    create_table :ninjas do |t|
      t.string :name
      t.string :twitter
      t.string :facebook
      t.string :team_id
      t.string :prize_id

      t.timestamps
    end
  end
end
