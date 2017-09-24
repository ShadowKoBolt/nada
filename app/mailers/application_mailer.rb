class ApplicationMailer < ActionMailer::Base
  default from: 'do-not-reply@nadadance.co.uk'
  layout 'mailer'

  def renew_1(user_id)
    @user = User.find(user_id)
    mail(to: @user.email)
  end
end
