class CreateCarpools < ActiveRecord::Migration[5.2]
  def change
    create_table :carpools do |t|
      t.references :driver, foreign_key: { to_table: :users }
      t.references :project, foreign_key: true
      t.references :vehicle

      t.timestamps
    end
  end
end
