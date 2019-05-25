class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.references :owner, foreign_key: { to_table: :users }
      t.text :make
      t.text :model
      t.text :color
      t.integer :year
      t.integer :fuel_efficiency
      t.integer :fuel_type
      t.integer :fuel_efficiency_unit
      t.integer :passenger_limit
      t.text :image
      t.boolean :default, default: false

      t.timestamps
    end
  end
end
