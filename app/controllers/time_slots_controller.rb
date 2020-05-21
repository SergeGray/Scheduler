class TimeSlotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_time_slot, only: %i[update destroy]

  def create
    @schedule = Schedule.find(params[:schedule_id])
    @time_slot = @schedule.time_slots.new(time_slot_params)
    authorize @time_slot

    @time_slot.save
  end

  def update
    @time_slot.update(time_slot_params)
  end

  def destroy
    @time_slot.destroy
  end

  private

  def set_time_slot
    @time_slot = TimeSlot.find(params[:id])
  end

  def time_slot_params
    params.require(:time_slot).permit(:day, :start_time, :end_time)
  end
end
