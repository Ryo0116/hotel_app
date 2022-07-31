class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :introduce
      t.integer :single_rate
      t.string :address
      t.text :image_name
      t.integer :user_id

      t.timestamps
    end
  end
end
