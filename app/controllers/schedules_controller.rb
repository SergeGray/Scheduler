class SchedulesController < ApplicationController
  before_action :get_schedule, only: %i[show edit update destroy]

  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
  end

  def show
    @time_slot = @schedule.time_slots.new
    @time_slots = @schedule.time_slots.filter(&:persisted?)
  end

  def edit; end

  def create
    @schedule = Schedule.new(schedule_params)

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

  def get_schedule
    @schedule = Schedule.find(params[:id])
  end
end
