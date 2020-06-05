class AddPositionToAlbum < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :position, :integer
    remove_column :albums, :order
  end
end
