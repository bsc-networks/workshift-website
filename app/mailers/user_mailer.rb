class UserMailer < ApplicationMailer
    default from: "postmaster@sandbox1344c868d76244459ff5ac36bead315d.mailgun.org"
    layout 'mailer'
    
    def setup_email(user)
        @user = user
        mail(to: @user.email, body: 'hi', content_type: 'text/html', subject: 'Welcome to Coop-Workshift')
    end
  
end
