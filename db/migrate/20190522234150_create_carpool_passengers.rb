class CreateCarpoolPassengers < ActiveRecord::Migration[5.2]
  def change
    create_table :carpool_passengers do |t|
      t.references :carpool, foreign_key: true
      t.references :passenger, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
