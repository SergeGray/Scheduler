class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: %i[show update destroy]

  def show
    authorize @appointment
  end

  def create
    @appointment = current_user.appointments.create(appointment_params)
    authorize @appointment
  end

  def update
    authorize @appointment
    @appointment.update(appointment_params)
  end

  def destroy
    authorize @appointment
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
