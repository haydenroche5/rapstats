class Artist < ActiveRecord::Base
  has_many :feature_counts
  validates :name, presence: true
  
  def as_json(options = {})
    super(options.merge(include: :feature_counts))
  end
end
