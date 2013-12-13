# == Schema Information
#
# Table name: albums
#
#  id             :integer          not null, primary key
#  band_id        :integer          not null
#  name           :string(255)      not null
#  recording_type :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Album < ActiveRecord::Base
  TYPES = ["live", "studio"]

  attr_accessible :band_id, :name, :recording_type
  validates :band_id, :name, :recording_type, :presence => true
  validates :recording_type, :inclusion => TYPES

  belongs_to :band
  has_many :tracks, :dependent => :destroy
end
