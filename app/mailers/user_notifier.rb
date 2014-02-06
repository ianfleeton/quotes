class UserNotifier < ActionMailer::Base
  default :from => EMAIL

  def token(user)
    @user = user
    mail(:to => user.email,
      :subject => WEBSITE + ': how to change your password')
  end
end