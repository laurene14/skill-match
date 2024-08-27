class AddMatchReferencesToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :match, null: false, foreign_key: true
  end
end
