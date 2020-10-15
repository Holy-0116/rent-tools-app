class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references  :borrower,    foreign_key: { to_table: :users }, null: false
      t.references  :lender,      foreign_key: { to_table: :users }, null: false
      t.references  :item,        foreign_key: true
      t.integer     :piece,       null: false
      t.date        :start_date,  null: false
      t.date        :return_date, null: false
      t.integer     :period,      null: false
      t.integer     :price,       null: false
      t.timestamps
    end
  end
end
