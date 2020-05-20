class SchedulesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_schedule, only: %i[show edit update destroy]

  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = current_user.schedules.new
  end

  def show
    @appointment = Appointment.new
    @time_slot = TimeSlot.new(schedule: @schedule)
    @time_slots = @schedule.time_slots
  end

  def edit; end

  def create
    @schedule = current_user.schedules.new(schedule_params)

    if @schedule.save
      redirect_to @schedule, notice: 'Successfully created'
    else
      render :new
    end
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to @schedule, notice: 'Successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @schedule.destroy
    redirect_to schedules_path, notice: 'Successfully deleted'
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :description)
  end

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end
end
