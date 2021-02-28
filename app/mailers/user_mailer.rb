class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to KidDo App!')
  end
end
