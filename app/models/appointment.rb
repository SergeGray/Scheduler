class Appointment < ApplicationRecord
  belongs_to :time_slot

  validates :title, :description, :date, presence: true
  validates :date, uniqueness: { scope: :time_slot_id }
  validate :validate_time_slot_week_day

  private

  def validate_time_slot_week_day
    # byebug
    return unless time_slot && date

    unless date.wday == time_slot.day
      errors.add(:time_slot, 'day of the week does not match the Date')
    end
  end
end
