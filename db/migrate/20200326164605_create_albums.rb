class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :url
      t.integer :order
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :albums, :order, unique: true
  end
end
