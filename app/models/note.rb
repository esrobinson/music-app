class Note < ActiveRecord::Base
  attr_accessible :user_id, :track_id, :note

  validates :user_id, :track_id, :note, :presence => true

  belongs_to :user
  belongs_to :track
end