class CreateCreatures < ActiveRecord::Migration
  def change
    create_table :creatures do |t|

      t.timestamps
    end
  end
end
