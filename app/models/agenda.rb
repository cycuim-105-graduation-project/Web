class Agenda < ApplicationRecord
  include ActiveModel::Serialization

  has_one  :speaker
  has_many :checkins
  belongs_to :event
  belongs_to :indoor_level
end
