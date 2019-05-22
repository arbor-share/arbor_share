class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :owner, polymorphic: true, index: true
      t.text :line_1
      t.text :line_2
      t.text :city
      t.integer :state
      t.text :zip
      t.boolean :default

      t.timestamps
    end
  end
end
