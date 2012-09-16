class AddGenerationToCreatures < ActiveRecord::Migration
  def change
    add_column :creatures, :generation, :integer

  end
end
