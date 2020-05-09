module TimeSlotsHelper
  DAYS_OF_THE_WEEK = %w[
    Monday
    Tuesday
    Wednesday
    Thursday
    Friday
    Saturday
    Sunday
  ].freeze

  def extract_time(time)
    time.to_s(:time)
  end

  def day_of_week(index)
    DAYS_OF_THE_WEEK[index - 1]
  end

  def day_of_week_select
    options_for_select(
      DAYS_OF_THE_WEEK.map.with_index { |day, index| [day, index + 1] }
    )
  end
end
