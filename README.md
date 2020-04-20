# README

Web application for scheduling appointments for services and public events. More info on the Wiki page.

Ruby version: 2.7.0

Uses RSpec 4.0 for the test suite.

Database structure:

* User. Attributes: email, password

* Schedule. Belongs to User. Attributes: name, description, user_id

* Time Slot. Belongs to Schedule. Attributes: weekday, start, finish, schedule_id

* Appointment. Belongs to User, belongs to Schedule, belongs to Time Slot. Attributes: name, description, date, user_id, schedule_id, time_slot_id
