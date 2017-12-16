class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :receipent
      t.string :tel
      t.string :address
      t.string :email
      t.text :note

      t.timestamps
    end
  end
end
