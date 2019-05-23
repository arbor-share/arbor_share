class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.date :date
      t.references :organizer, foreign_key: { to_table: :users }
      t.string :description
      t.string :image
      t.boolean :active

      t.timestamps
    end
  end
end
