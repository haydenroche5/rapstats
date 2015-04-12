class AddRgNameToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :rg_name, :string
  end
end
