class RemoveParentArtistIdFromFeatureCounts < ActiveRecord::Migration
  def change
    remove_column :feature_counts, :parent_artist_id, :integer
  end
end
