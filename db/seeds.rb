schedules = Schedule.create!(
  [
    { title: '', description: '' },
    { title: '', description: '' }
  ]
)

time_slots = TimeSlot.create!(
  [
    {
      schedule: schedules.first,
      day: 1,
      start_time: Time.zone.now,
      end_time: Time.zone.now + 1.hours
    },
    {
      schedule: schedules.first,
      day: 1,
      start_time: Time.zone.now + 2.hours,
      end_time: Time.zone.now + 3.hours
    }
  ]
)
