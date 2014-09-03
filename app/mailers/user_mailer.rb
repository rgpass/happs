class UserMailer < ActionMailer::Base
  default from: "rgpass@gmail.com"

  def signup_confirmation(user)
    @user = user

    mail to: "#{user.first_name} #{user.last_name} <#{user.email}>",
    subject: "Welcome to Happs!",
    from: "Gerry Pass <gerry.pass@happs.io>"
  end
end
