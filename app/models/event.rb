class Event < ApplicationRecord
  mount_uploader :feature_img, EventImageUploader
  belongs_to :place
end
