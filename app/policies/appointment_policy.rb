class AppointmentPolicy
  attr_reader :user, :appointment

  def initialize(user, appointment)
    @user = user
    @appointment = appointment
  end

  def show?
    owns? || owns_schedule?
  end

  def create?
    user
  end

  def update?
    owns? || owns_schedule?
  end

  def destroy?
    owns? || owns_schedule?
  end

  private

  def owns?
    user&.id == appointment.user_id
  end

  def owns_schedule?
    user&.id == appointment.time_slot.schedule.user_id
  end
end
