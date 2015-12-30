class Artist < ActiveRecord::Base
  has_many :feature_counts, :foreign_key => "parent_artist_id"
  has_many :producer_counts, :foreign_key => "artist_id"

  def as_json(options = {})
    super(options.merge(include: :feature_counts))
  end
end
