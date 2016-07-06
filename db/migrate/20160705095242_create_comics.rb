class CreateComics < ActiveRecord::Migration
  def change
     create_table  :comics do |t|
      t.text        :title
      t.text        :author
      t.integer     :site_id
      t.text        :thumbnail
      t.text        :new_url
      t.text        :list_url
      t.date        :updated
      t.timestamps
    end
  end
end
