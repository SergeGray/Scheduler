class TimeSlotsController < ApplicationController
  def create
    @schedule = Schedule.find(params[:schedule_id])
    @time_slot = @schedule.time_slots.create(time_slot_params)
    redirect_to @time_slot.schedule, notice: 'Successfully created'
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:day, :start_time, :end_time)
  end
end
