class Checkin < ApplicationRecord
  belongs_to :user
  belongs_to :agenda

  validates :agenda, uniqueness: {
    scope: :user,
    message: "Already checked in."
  }
end
