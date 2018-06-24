class ApplicationMailer < ActionMailer::Base
  default from: 'info@nadadance.co.uk'
  layout 'mailer'

  def renew_1(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'Your NADA membership runs out soon')
  end

  def renew_2(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'Your NADA membership runs out soon')
  end

  def renew_success(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'Your NADA membership has been renewed')
  end

  def dance_class_added(dance_class_id)
    @dance_class = DanceClass.find(dance_class_id)
    mail(
      to: Setting.instance.dance_class_update_emails,
      subject: "A dance class has been added",
    )
  end

  def dance_class_edited(dance_class_id)
    @dance_class = DanceClass.find(dance_class_id)
    mail(
      to: Setting.instance.dance_class_update_emails,
      subject: "A dance class has been updated",
    )
  end
end
