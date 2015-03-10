class InvitationsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      InvitationsMailer.new_message(@message).deliver
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json => {
          :message=>@message.as_json(:only => [:email, :name])
        } }
      end
    end
  end
end
