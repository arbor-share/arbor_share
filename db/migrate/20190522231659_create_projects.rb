class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.date :date, default: { expr: "('now'::text)::date" }
      t.references :organizer, foreign_key: { to_table: :users }
      t.string :description
      t.string :image
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
