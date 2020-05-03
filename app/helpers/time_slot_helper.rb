module TimeSlotHelper
  def extract_time(time)
    time.to_s(:time)
  end
end
