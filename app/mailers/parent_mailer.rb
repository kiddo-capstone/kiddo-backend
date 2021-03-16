class ParentMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def welcome_email
    @parent = params[:parent]
    @url  = 'http://example.com/login'
    mail(to: @parent.email, subject: 'Welcome to KidDo App!')
  end
end
