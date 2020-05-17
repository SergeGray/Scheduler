module TimeSlotsHelper
  def extract_time(time)
    time.to_s(:time)
  end

  def day_of_the_week_select
    options_for_select(
      Date::DAYNAMES.map.with_index { |day, index| [day, index] }
    )
  end
end
