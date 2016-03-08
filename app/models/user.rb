class User < ActiveRecord::Base
    has_secure_password
    
    def self.import(file)
        # puts file
        spreadsheet = open_spreadsheet(file)
        puts spreadsheet.info
        header = spreadsheet.row(1)
        (2..spreadsheet.last_row).each do |i|
          row = Hash[[header, spreadsheet.row(i)].transpose]
        #   print row
          user = find_by_id(row["id"]) || new
          user.attributes = row.to_hash.slice(*row.to_hash.keys)
          user.password = ('0'..'z').to_a.shuffle.first(8).join
          user.save!
      end
    end
    
    def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
        when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
        when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
        when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
        else raise "Unknown file type: #{file.original_filename}"           
      end
    end
end
