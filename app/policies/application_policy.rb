class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def user_renewal_date_is_in_future?
    @user && @user.renewal_date && @user.renewal_date >= Date.today
  end

  def user_renewal_date_is_nil?
    @user && @user.renewal_date.nil?
  end

  def user_renewal_date_is_past?
    @user && @user.renewal_date && @user.renewal_date < Date.today
  end
end
