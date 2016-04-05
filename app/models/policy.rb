class Policy < ActiveRecord::Base
    belongs_to :unit
    serialize :fine_days, Array
    
    def get_fine_days
        arr = []
        str = ""
        fine_days.each do |date|
            arr << date.strftime("%B %d, %Y")
        end
        arr.join(", ")
    end
end
