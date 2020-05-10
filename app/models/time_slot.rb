class TimeSlot < ApplicationRecord
  belongs_to :schedule

  validates :day, presence: true, inclusion: { in: 1..7 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :validate_time_order, on: %i[create update]

  private

  def validate_time_order
    return unless start_time && end_time

    if end_time < start_time
      errors.add(:end_time, "can't be earlier than Start time")
    end
  end
end
