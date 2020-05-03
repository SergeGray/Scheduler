class Schedule < ApplicationRecord
  has_many :time_slots, dependent: :destroy

  validates :title, :description, presence: true
end
