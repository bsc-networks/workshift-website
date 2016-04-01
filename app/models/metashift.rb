class Metashift < ActiveRecord::Base
    has_many :shifts
    
     def self.import(file)
        puts file
        spreadsheet = open_spreadsheet(file)
        puts spreadsheet.info
        # header = spreadsheet.row(1)
        # added = []
        # (2..spreadsheet.last_row).each do |i|
        #   row = Hash[[header, spreadsheet.row(i)].transpose]
        #   user = find_by(email: row["email"]) || new
        #   user.attributes = row.to_hash.slice(*row.to_hash.keys)
        #   user.password = User.random_pw
        #   if (not user.sent_confirmation) and user.save
        #     added += [user]
        #   end
        # end
        # return added
    end
    
    def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
        when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
        else raise "Unknown file type: #{file.original_filename}"           
      end
    end
    
end
