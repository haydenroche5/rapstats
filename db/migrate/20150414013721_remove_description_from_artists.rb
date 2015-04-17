class RemoveDescriptionFromArtists < ActiveRecord::Migration
  def change
    remove_column :artists, :description, :string
  end
end
