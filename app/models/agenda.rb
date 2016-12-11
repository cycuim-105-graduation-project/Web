class Agenda < ApplicationRecord
  belongs_to :event
  belongs_to :indoor_level
end
