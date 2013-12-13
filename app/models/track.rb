# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  album_id   :integer          not null
#  bonus      :string(255)      not null
#  lyrics     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  TYPES = ["bonus", "regular"]

  attr_accessible :name, :album_id, :bonus, :lyrics
  validates  :name, :album_id, :bonus, :presence => true
  validates :bonus, :inclusion => TYPES

  belongs_to :album
end
