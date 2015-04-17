class AddMagnificationToArea < ActiveRecord::Migration
  def change
    add_column :areas, :magnification, :float
  end
end
