class AddDirectorToMoives < ActiveRecord::Migration
  def change
    add_column :moives, :director, :string
  end
end
