class AddSignalToMap < ActiveRecord::Migration
  def change
    add_column :maps, :signal, :string
  end
end
