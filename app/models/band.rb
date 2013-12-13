# == Schema Information
#
# Table name: bands
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Band < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true

  has_many :albums, :dependent => :destroy

end
