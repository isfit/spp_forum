class ForumMailer < ActionMailer::Base
  default :from => "no-reply@studentpeaceprize.org"

  def welcome_email(user)
    @user = user
    @url = "http://www.studentpeaceprize.org/forums"
    mail(:to => user.email, :subject => "Welcome to the Forums at Studentpeaceprize.org!")
  end
end
