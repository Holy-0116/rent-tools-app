class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :item,      foreign_key: true, null: false
      t.references :borrower,  foreign_key: {to_table: :users}, null: false
      t.text       :text,   null: false
      t.timestamps
    end
  end
end
