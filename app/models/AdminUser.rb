class AdminUser < ActiveRecord::Base
  include DeviseInvitable::Inviter
end