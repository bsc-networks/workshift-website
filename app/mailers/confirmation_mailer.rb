class ConfirmationMailer < ActionMailer::Base
  default from: "bsc-scheduler@gmail.com"
  def sign_off_email(email, user)
  	@user= user
  	mail(to: email, subject: "hi")
  end
end
