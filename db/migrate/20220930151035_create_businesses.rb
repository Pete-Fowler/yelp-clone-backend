class CreateBusinesses < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :category 
      t.string :business_type
      t.string :address
      t.string :price
      t.string :image_url
      t.string :phone_number
      t.string :website
      t.string :transactions 
      t.timestamps
    end

  end
end
