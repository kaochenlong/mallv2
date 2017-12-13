class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :price
      t.boolean :available

      t.timestamps
    end
  end
end
