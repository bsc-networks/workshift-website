class InvitationsController < ApplicationController
	InvitationsMailer.email_name.deliver(@user, @from, @subject, @content)
		

	def batch_invite
		#Validate the user_emails field isn't blank and emails are valid
		params[:user_emails].split(",").each do |email|
			User.invite!(:email => email)
		end
	end
	def create
		User.invite!(:email => email)

		NotificationMailer.invite_message(@user, @from, @subject, @content).deliver
		@user.invitation_sent_at = Time.now.utc # mark invitation as delivered

		if @user.errors.empty?
			flash[:notice] = "successfully sent invite to #{@user.email}"
			respond_with @user, :location => root_path
		else
			render :new
		end
	end
end