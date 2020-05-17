class AppointmentsController < ApplicationController
  def create
    @appointment = Appointment.create(appointment_params)
  end

  def update
    @appointment = Appointment.find(params[:id])
    @appointment.update(appointment_params)
  end

  private

  def appointment_params
    params
      .require(:appointment)
      .permit(:time_slot_id, :title, :description, :date)
  end
end
