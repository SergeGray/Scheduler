class Appointment < ApplicationRecord
  belongs_to :time_slot

  validates :title, :description, presence: true
end
