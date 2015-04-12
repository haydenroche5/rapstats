class AddForeignKey2ToFeatureCounts < ActiveRecord::Migration
  def change
    add_column :feature_counts, :featured_artist_id, :integer
  end
end
