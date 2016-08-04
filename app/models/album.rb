class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks, dependent: :destroy
  validates :title, :band_id, :album_type, presence: true
  validates :album_type, inclusion: { in: ["Live", "Studio"]}
end
