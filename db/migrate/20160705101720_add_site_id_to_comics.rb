class AddSiteIdToComics < ActiveRecord::Migration
  def change
    add_column :comics, :site_id, :integer
  end
end
