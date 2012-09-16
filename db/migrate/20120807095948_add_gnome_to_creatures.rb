class AddGnomeToCreatures < ActiveRecord::Migration
  def change
    add_column :creatures, :gnome, :string

  end
end
