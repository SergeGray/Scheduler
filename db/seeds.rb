users = User.create!(
  [
    {
      email: 'dude@example.com',
      password: '123456',
      password_confirmation: '123456'
    }, {
      email: 'champ@example.com',
      password: '123456',
      password_confirmation: '123456'
    }
  ]

schedules = Schedule.create!(
  [
    {
      title: 'Dentist appointments',
      description: 'Sign up here',
      user: users.first
    }, {
      title: 'Board meetings',
      description: 'For all the arranged meetings',
      user: users.first
    }
  ]
)

time_slots = TimeSlot.create!(
  [
    {
      schedule: schedules.first,
      day: 1,
      start_time: Time.zone.now,
      end_time: Time.zone.now + 1.hours
    }, {
      schedule: schedules.first,
      day: 1,
      start_time: Time.zone.now + 2.hours,
      end_time: Time.zone.now + 3.hours
    }
  ]
)

Appointment.create!(
  [
    {
      time_slot: time_slots.first,
      date: Time.zone.now.strftime('%F'),
      title: 'Help me'
      description: 'My tooth really hurts'
    }, {
      time_slot: time_slots.first,
      date: (Time.zone.now + 1.week).strftime('%F'),
      title: 'Help me'
      description: 'Just in case I wanna come next week too'
    }
  ]
)
