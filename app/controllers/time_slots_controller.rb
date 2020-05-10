class TimeSlotsController < ApplicationController
  before_action :set_time_slot, only: %i[update destroy]

  def create
    @schedule = Schedule.find(params[:schedule_id])
    @time_slot = TimeSlot.new(time_slot_params.merge(schedule: @schedule))
    @time_slots = @schedule.time_slots

    if @time_slot.save      
      redirect_to @time_slot.schedule, notice: 'Successfully created'
    else
      render 'schedules/show', schedule: @schedule
    end
  end

  def update
    @time_slot.update(time_slot_params)
    redirect_to @time_slot.schedule, notice: 'Successfully updated'
  end

  def destroy
    @time_slot.destroy
    redirect_to @time_slot.schedule, notice: 'Successfully deleted'
  end

  private

  def set_time_slot
    @time_slot = TimeSlot.find(params[:id])
  end

  def time_slot_params
    params.require(:time_slot).permit(:day, :start_time, :end_time)
  end
end
