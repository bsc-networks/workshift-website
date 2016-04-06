class Shift < ActiveRecord::Base
  belongs_to :metashift
  belongs_to :user
  
  def full_json
    self.as_json( include: [:metashift, :user] )
  end
end
