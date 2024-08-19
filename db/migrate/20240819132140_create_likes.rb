class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :liker, null: false, foreign_key: { to_table: :users }
      t.references :liked, null: false, foreign_key: { to_table: :users }
      t.boolean :wanted
      t.timestamps
    end
  end
end
