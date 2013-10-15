class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :colour
      t.integer :order
      t.string :prize_id

      t.timestamps
    end
  end
end
