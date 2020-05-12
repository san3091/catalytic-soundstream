class AddCuratorToAlbum < ActiveRecord::Migration[6.0]
  def change
    add_reference :albums, :curator, null: false, foreign_key: true
  end
end
