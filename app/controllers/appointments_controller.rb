class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show update destroy]

  def show; end

  def create
    @appointment = Appointment.create(appointment_params)
  end

  def update
    @appointment.update(appointment_params)
  end

  def destroy
    @appointment.destroy
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params
      .require(:appointment)
      .permit(:time_slot_id, :title, :description, :date)
  end
end
