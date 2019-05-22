class CreateBlocklist < ActiveRecord::Migration[5.2]
  def change
    create_table :blocklist do |t|
      t.references :blocking_user, foreign_key: { to_table: :users }
      t.references :blocked_user, foreign_key: { to_table: :users }
    end
  end
end
