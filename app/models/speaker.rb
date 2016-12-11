class Speaker < ApplicationRecord
  mount_uploader :image, SpeakerImageUploader
  belongs_to :agenda
  validates :agenda, uniqueness: true
end
