class InvitationsMailer < ActionMailer::Base

  default :from => "Shirley<chan.m.trinh@gmail.com>"


  def new_message(message)
    @message = message
    mail(:to => "#{message.email}", :subject => "#{message.subject}", :content_type => 'text/html')
  end

end