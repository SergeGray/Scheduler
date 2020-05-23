class TimeSlotPolicy
  attr_reader :user, :time_slot

  def initialize(user, time_slot)
    @user = user
    @time_slot = time_slot
  end

  def create?
    owns_schedule?
  end

  def update?
    owns_schedule?
  end

  def destroy?
    owns_schedule?
  end

  private

  def owns_schedule?
    user&.id == time_slot.schedule.user_id
  end
end
