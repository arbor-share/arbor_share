class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email, unique: true
      t.string :about
      t.string :avatar_image
      t.string :google_token
      t.numeric :google_id
      t.integer :role
      t.boolean :active

      t.timestamps
    end
  end
end
