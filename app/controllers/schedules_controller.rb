class SchedulesController < ApplicationController
  def new
    @schedule = Schedule.new
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def create
    @schedule = Schedule.create(schedule_params)
    redirect_to @schedule, notice: 'Successfully created'
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :description)
  end
end
