module TimeSlotsHelper
  def extract_time(time)
    time.to_s(:time)
  end

  def day_of_week_select
    options_for_select(
      [
        ['Monday', 1],
        ['Tuesday', 2],
        ['Wednesday', 3],
        ['Thursday', 4],
        ['Friday', 5],
        ['Saturday', 6],
        ['Sunday', 7]
      ]
    )
  end
end
