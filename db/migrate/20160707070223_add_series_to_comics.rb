class AddSeriesToComics < ActiveRecord::Migration
  def change
    add_column :comics, :series, :boolean
  end
end
