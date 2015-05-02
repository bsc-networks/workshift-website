require 'rails_helper'

describe WorkshiftAssignmentsController do
  before :each do
    user = double('user')
    allow(user).to receive(:workshift_manager?) { true }
    sign_in(user)
  end

end
