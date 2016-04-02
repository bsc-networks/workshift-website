class MetashiftsController < ApplicationController
    def add_metashift
        @metashifts_uploaded = []
        new_metashift = Metashift.new
        new_metashift.update_attributes(metashift_params)
        new_metashift.save
        @metashifts_uploaded << new_metashift
        render "shifts/upload"
    end
    
    def metashift_params
        params.require(:metashift).permit(:category, :description, :multiplier)
    end
end
