class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.text    :title
      t.text    :url
      t.text    :info_tag
      t.timestamps
    end
  end
end
