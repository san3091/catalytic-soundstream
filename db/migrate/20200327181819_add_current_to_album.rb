class AddCurrentToAlbum < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :current, :boolean, default: false
  end
end
