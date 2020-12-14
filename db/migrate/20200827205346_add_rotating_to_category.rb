class AddRotatingToCategory < ActiveRecord::Migration[6.0]
  def up
    add_column :categories, :rotating, :bool, default: false
    change_column_null :categories, :rotating, false
  end

  def down
    remove_column :categories, :rotating, :bool
  end
end
