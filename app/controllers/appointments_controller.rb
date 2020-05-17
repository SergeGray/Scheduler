class AppointmentsController < ApplicationController
  def create
    @appointment = Appointment.create(appointment_params)
  end

  private

  def appointment_params
    params
      .require(:appointment)
      .permit(:time_slot_id, :title, :description, :date)
  end
end
