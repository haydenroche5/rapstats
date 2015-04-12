class AddForeignKeyToFeatureCounts < ActiveRecord::Migration
  def change
    add_column :feature_counts, :parent_artist_id, :integer
  end
end
