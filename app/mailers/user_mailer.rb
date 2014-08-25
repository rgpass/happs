class UserMailer < ActionMailer::Base
  default from: "rgpass@gmail.com"

  def signup_confirmation(user)
    @user = user

    # mail to: user.email, subject: "Sign Up Confirmation"
    mail to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "Welcome to Happs!"
  end
end
