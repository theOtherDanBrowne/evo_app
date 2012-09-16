class AddMutationToCreatures < ActiveRecord::Migration
  def change
    add_column :creatures, :mutation, :integer

  end
end
