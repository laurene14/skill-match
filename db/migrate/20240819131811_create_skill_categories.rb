class CreateSkillCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :skill_categories do |t|
      t.references :skill, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
