class AddUploadToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_reference :albums, :album_upload, foreign_key: true
  end
end
