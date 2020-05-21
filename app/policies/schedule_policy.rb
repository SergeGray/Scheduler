class SchedulePolicy
  attr_reader :user, :schedule

  def initialize(user, schedule)
    @user = user
    @schedule = schedule
  end

  def edit?
    owns?
  end

  def update?
    owns?
  end

  private

  def owns?
    user.id == schedule.user_id
  end
end
