class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.string :path
      t.float :center_x
      t.float :center_y
      t.float :center_z
      t.integer :pixels_x
      t.integer :pixels_y
      t.float :pixels_size_x
      t.float :pixels_size_y
      t.attachment :zip

      t.timestamps null: false
    end
  end
end
