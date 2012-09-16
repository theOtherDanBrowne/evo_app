class AddGGnomeToCreatures < ActiveRecord::Migration
  def change
    add_column :creatures, :g_gnome, :string

  end
end
