class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :home_type
      t.string :room_type
      t.integer :accommodate
      t.integer :bed_room
      t.integer :bath_room
      t.string :listing_name
      t.text :summary
      t.string :address
      t.string :kor_address
      t.boolean :is_tv
      t.boolean :is_kitchen
      t.boolean :is_air
      t.boolean :is_heating
      t.boolean :is_wifi
      t.integer :price
      t.boolean :active
      
      t.references :user, foreign_key: true
      
      t.datetime :check_in
      t.datetime :check_out

      t.timestamps
    end
  end
end
