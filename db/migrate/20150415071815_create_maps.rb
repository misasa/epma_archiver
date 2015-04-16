class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :path
      t.integer :area_id
      t.string :element_name
      t.string :channel
      t.string :crystal_name
      t.string :x_ray_name
      t.text :info
      t.attachment :image

      t.datetime :mtime, null: false
      t.datetime :ctime, null: false
      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
