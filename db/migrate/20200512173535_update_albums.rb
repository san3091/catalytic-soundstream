class UpdateAlbums < ActiveRecord::Migration[6.0]
  def change
    rename_column :albums, :url, :soundcloud_url
    change_table :albums do |t|
      t.string :artist
      t.string :description
      t.string :bandcamp_url
    end
  end
end
