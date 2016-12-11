class Event < ApplicationRecord
  include ActiveModel::Model
  include ActiveModel::Serialization
  mount_uploader :feature_img, ::EventImageUploader
  belongs_to :place
end
