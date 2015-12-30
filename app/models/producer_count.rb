class ProducerCount < ActiveRecord::Base
  belongs_to :artist, :class_name => "Artist", :foreign_key => "artist_id"
  belongs_to :producer, :class_name => "Producer", :foreign_key => "producer_id"
end
