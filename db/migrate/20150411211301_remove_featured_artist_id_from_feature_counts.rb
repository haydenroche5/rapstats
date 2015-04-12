class RemoveFeaturedArtistIdFromFeatureCounts < ActiveRecord::Migration
  def change
    remove_column :feature_counts, :featured_artist_id, :integer
  end
end
