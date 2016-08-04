class Track < ActiveRecord::Base
  belongs_to :album
  has_many :notes
  validates :title, :album_id, :track_type, presence: true
end
