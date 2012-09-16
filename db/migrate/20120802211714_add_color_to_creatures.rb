class AddColorToCreatures < ActiveRecord::Migration
  def change
    add_column :creatures, :color, :string

  end
end
