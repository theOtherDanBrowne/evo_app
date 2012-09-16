class AddBGnomeToCreatures < ActiveRecord::Migration
  def change
    add_column :creatures, :b_gnome, :string

  end
end
