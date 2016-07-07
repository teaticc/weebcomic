class AddWeekdayToComics < ActiveRecord::Migration
  def change
    add_column :comics, :weekday, :integer
  end
end
