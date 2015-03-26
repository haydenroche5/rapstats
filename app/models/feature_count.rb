class FeatureCount < ActiveRecord::Base
  belongs_to :parent_artist
  belongs_to :featured_artist
end
