class FeatureCount < ActiveRecord::Base
  belongs_to :parent_artist, :class_name => "Artist", :foreign_key => "parent_artist_id"
  belongs_to :featured_artist, :class_name => "Artist", :foreign_key => "featured_artist_id"
end
