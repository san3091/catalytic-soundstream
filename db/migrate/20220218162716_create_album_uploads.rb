class CreateAlbumUploads < ActiveRecord::Migration[7.0]
  def change
    create_table :album_uploads do |t|
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
