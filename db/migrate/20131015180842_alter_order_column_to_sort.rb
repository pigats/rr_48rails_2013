class AlterOrderColumnToSort < ActiveRecord::Migration
  def change
    rename_column(:teams, :order, :sort)
  end
end
