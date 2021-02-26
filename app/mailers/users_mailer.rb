class UsersMailer < ActionMailer::Base
  def welcome_email(user_id)
    @user = User.find(user_id)

    mail(to: @user.email,
         subject: 'Welcome to Kiddo App') do |format|
      format.text
      format.html
    end
  end
end
