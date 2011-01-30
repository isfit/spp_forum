class ForumMailer < ActionMailer::Base
  default :from => "no-reply@studentpeaceprize.org"

  def welcome_email(user, password)
    @user = user
    @url = "http://forum.studentpeaceprize.org/users/sign_in"
    @password = password
    mail(:to => user.email, :subject => "Welcome to the Forums at Studentpeaceprize.org!")
  end
end
