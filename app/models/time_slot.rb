class TimeSlot < ApplicationRecord
  belongs_to :schedule

  has_many :appointments, dependent: :destroy

  validates :day, presence: true, inclusion: { in: 0..6 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :validate_time_order, on: %i[create update]

  def day_of_the_week
    Date::DAYNAMES[day]
  end

  def day_and_time
    "#{day_of_the_week}, #{start_time.to_s(:time)} - #{end_time.to_s(:time)}"
  end

  private

  def validate_time_order
    return unless start_time && end_time

    if end_time < start_time
      errors.add(:end_time, "can't be earlier than Start time")
    end
  end
end
