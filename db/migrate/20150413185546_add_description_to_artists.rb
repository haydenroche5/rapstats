class AddDescriptionToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :description, :string
  end
end
