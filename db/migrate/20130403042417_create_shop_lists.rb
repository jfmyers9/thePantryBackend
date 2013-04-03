class CreateShopLists < ActiveRecord::Migration
  def change
    create_table :shop_lists do |t|
      t.integer :user_id
      t.string :group
      t.string :ingredient

      t.timestamps
    end
  end
end
