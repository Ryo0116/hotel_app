class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :introduce, :text
    add_column :users, :image_name, :text
  end
end
