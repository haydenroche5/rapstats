class CreateFeatureCounts < ActiveRecord::Migration
  def change
    create_table :feature_counts do |t|
      t.integer :count
      t.references :parent_artist, index: true
      t.references :featured_artist, index: true

      t.timestamps
    end
  end
end
