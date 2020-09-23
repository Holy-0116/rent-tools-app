class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user,               foreign_key: true
      t.string     :name,               null: false
      t.integer    :status_id,          null: false
      t.text       :explanation,        null: false
      t.string     :size,               null: false
      t.integer    :delivery_fee_id,    null: false
      t.integer    :delivery_date_id,   null: false
      t.integer    :price,              null: false
      t.timestamps
    end
  end
end
