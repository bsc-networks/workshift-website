class Policy < ActiveRecord::Base
    belongs_to :unit
    serialize :fine_days, Array
    
    def get_first_day
        if first_day
            first_day.strftime("%B %d, %Y")
        else
            nil
        end
    end
    
    def get_last_day
        if last_day
            last_day.strftime("%B %d, %Y")
        else
            nil
        end
    end
    
    def get_fine_days
        if fine_days
            arr = []
            str = ""
            fine_days.each do |date|
                arr << date.strftime("%B %d, %Y")
            end
            return arr.join(", ")
        else
            nil
        end
    end
end
