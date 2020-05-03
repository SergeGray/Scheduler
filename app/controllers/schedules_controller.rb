class SchedulesController < ApplicationController
  before_action :get_schedule, only: %i[show edit update]

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

  private

  def schedule_params
    params.require(:schedule).permit(:title, :description)
  end

  def get_schedule
    @schedule = Schedule.find(params[:id])
  end
end
