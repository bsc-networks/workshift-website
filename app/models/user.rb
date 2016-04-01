class User < ActiveRecord::Base
    has_secure_password
    validates :email, uniqueness: true
    
    belongs_to :unit
    has_many :shifts
    
    PERMISSION = {
          :member => 0, :manager => 1, :ws_manager =>2
    }
    
    def self.import(file)
        # puts file
        spreadsheet = open_spreadsheet(file)
        # puts spreadsheet.info
        header = spreadsheet.row(1)
        added = []
        (2..spreadsheet.last_row).each do |i|
          row = Hash[[header, spreadsheet.row(i)].transpose]
          user = find_by(email: row["email"]) || new
          user.attributes = row.to_hash.slice(*row.to_hash.keys)
          user.password = User.random_pw
          if (not user.sent_confirmation) and user.save
            added += [user]
          end
        end
        return added
    end
    
    def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
        when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
        when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
        when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
        else raise "Unknown file type: #{file.original_filename}"           
      end
    end
    
    def full_name
      return first_name.capitalize + " " + last_name.capitalize
    end
    
    
    def self.send_confirmation(id)
      user = find(id)
      if user
        mg_client = Mailgun::Client.new Rails.application.secrets.api_key
        user.update_attributes!(:sent_confirmation => true)
        new_password = User.random_pw
        user.update_attribute(:password, new_password)
        message_params = {
                          :from    => Rails.application.secrets.username,
                          :to      => user.email,
                          :subject => 'Welcome to Coop Workshift',
                          :text    => 'Your temporary password is ' + new_password + ' be sure to change this when you sign in.'
                        }
        mg_client.send_message(Rails.application.secrets.domain, message_params)
      else
        # puts "Couldnt find user"
      end
    end
    
    def self.random_pw
      x = ('0'..'z').to_a.shuffle.first(8).join
      return x
    end
    
    def is_ws_manager
      permissions == PERMISSION[:ws_manager]
    end
    
    def is_manager
      permissions == PERMISSION[:manager]
    end
    
    def is_member
      permissions == PERMISSION[:member]
    end 
end
