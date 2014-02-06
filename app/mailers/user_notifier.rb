class UserNotifier < ActionMailer::Base
  default :from => EMAIL

  def token(user, url)
    @user = user
    @url = url
    mail(:to => user.email,
      :subject => WEBSITE + ': how to change your password')
  end
end
