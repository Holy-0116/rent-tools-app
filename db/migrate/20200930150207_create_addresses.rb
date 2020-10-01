class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :user,          foreign_key: true
      t.string     :postal_code,   null:false
      t.string     :prefecture_id, null:false
      t.string     :city_name,     null:false
      t.string     :house_number,  null:false
      t.string     :building_name, null:false
      t.string     :phone_number,  null:false
      t.timestamps
    end
  end
end
