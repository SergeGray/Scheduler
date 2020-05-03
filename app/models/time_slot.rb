class TimeSlot < ApplicationRecord
  belongs_to :schedule

  validates :day, presence: true, inclusion: { in: 1..7 }
  validates :start_time, presence: true
  validates :end_time, presence: true
end
