class Appointment < ApplicationRecord
  belongs_to :time_slot

  validates :title, :description, :date, presence: true
end
