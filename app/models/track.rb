class Track < ActiveRecord::Base
  belongs_to :album
  validates :title, :album_id, :track_type, presence: true
  TRACK_TYPE = %w(Bonus Regular)
end
