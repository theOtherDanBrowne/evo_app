class AddRGnomeToCreatures < ActiveRecord::Migration
  def change
    add_column :creatures, :r_gnome, :string

  end
end
