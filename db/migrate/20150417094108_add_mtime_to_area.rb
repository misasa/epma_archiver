class AddMtimeToArea < ActiveRecord::Migration
  def change
    add_column :areas, :mtime, :datetime
  end
end
