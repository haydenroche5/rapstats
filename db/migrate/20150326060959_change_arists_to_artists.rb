class ChangeAristsToArtists < ActiveRecord::Migration
  def change
    rename_table :arists, :artists
  end
end
