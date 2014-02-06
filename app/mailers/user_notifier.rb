class UserNotifier < ActionMailer::Base
  default :from => EMAIL

  def token(user, profile_name, url)
    @user = user
    @url = url
    mail(:to => user.email,
      subject: profile_name + ': how to change your password')
  end
end
