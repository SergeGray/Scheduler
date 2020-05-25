class SchedulePolicy
  attr_reader :user, :schedule

  def initialize(user, schedule)
    @user = user
    @schedule = schedule
  end

  def show?
    true
  end

  def create?
    user
  end

  def update?
    owns?
  end

  def destroy?
    owns?
  end

  private

  def owns?
    user&.id == schedule.user_id
  end
end
