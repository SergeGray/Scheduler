class SchedulesController < ApplicationController
  before_action :get_schedule, only: %i[show edit update destroy]

  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
  end

  def show; end

  def edit; end

  def create
    @schedule = Schedule.create(schedule_params)
    redirect_to @schedule, notice: 'Successfully created'
  end

  def update
    @schedule.update(schedule_params)
    redirect_to @schedule, notice: 'Successfully updated'
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
