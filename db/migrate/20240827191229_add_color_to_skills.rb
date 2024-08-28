class AddColorToSkills < ActiveRecord::Migration[7.1]
  def change
    add_column :skills, :color, :string
  end
end
