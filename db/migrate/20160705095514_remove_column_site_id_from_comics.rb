class RemoveColumnSiteIdFromComics < ActiveRecord::Migration
  def change
    remove_column :comics, :site_id, :integer
  end
end
