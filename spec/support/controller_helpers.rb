module ControllerHelpers
    def sign_in(user = double('user'))
      if user.nil?
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
        allow(controller).to receive(:current_user).and_return(nil)
      else
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end
    end

    def mock_authorize(record, authorize)
      expectation = expect(controller).to receive(:authorize).with(record)
      expectation.and_raise(Pundit:NotAuthorizedError) unless authorize

      allow(controller).to receive(:verify_authorized)
    end

  end
