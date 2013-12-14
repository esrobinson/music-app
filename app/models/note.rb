# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  track_id   :integer          not null
#  note       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Note < ActiveRecord::Base
  attr_accessible :user_id, :track_id, :note

  validates :user_id, :track_id, :note, :presence => true

  belongs_to :user
  belongs_to :track
end
