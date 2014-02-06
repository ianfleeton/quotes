class UserNotifier < ActionMailer::Base
  def token(user, sender, profile_name, url)
    @user = user
    @url = url
    mail(to: user.email, from: sender,
      subject: profile_name + ': how to change your password')
  end
end
