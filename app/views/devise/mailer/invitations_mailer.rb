class InvitationsMailer < ActionMailer::Base

  def create
        @from    = params[:from]
        @subject = params[:invite_subject]
        @content = params[:invite_content]

        @user = User.invite!(params[:user], current_user) do |u|
          u.skip_invitation = true
        end

        NotificationMailer.invite_message(@user, @from, @subject, @content).deliver
        @user.invitation_sent_at = Time.now.utc # mark invitation as delivered
        InvitationsMailer.new_message(@message).deliver
        if @user.errors.empty?
          flash[:notice] = "successfully sent invite to #{@user.email}"
          respond_with @user, :location => root_path
        else
          render :new
        end
    end
end