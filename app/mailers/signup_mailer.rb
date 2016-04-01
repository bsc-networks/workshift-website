class SignupMailer < ApplicationMailer
    default from: "Coop Workshift <postmaster@sandbox1344c868d76244459ff5ac36bead315d.mailgun.org>"
    
    def signup_email(user)
        puts "HERE"
        mail(to: @user.email, subject: 'Welcome to Coop Workshift')
    end
    
end


# curl -s --user 'api:key-1490d65e07e5c4ffcb8dc9df632e6c81' \
#     https://api.mailgun.net/v3/sandbox1344c868d76244459ff5ac36bead315d.mailgun.org/messages \
#     -F from='Coop Workshift <postmaster@sandbox1344c868d76244459ff5ac36bead315d.mailgun.org>' \
#     -F to=postmaster@sandbox1344c868d76244459ff5ac36bead315d.mailgun.org \
#     -F to=ryanriddle@berkeley.edu \
#     -F subject='Hello' \
#     -F text='Testing some Mailgun awesomness!'