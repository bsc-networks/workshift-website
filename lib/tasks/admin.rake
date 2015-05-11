namespace :admin do
  desc "Make a user a workshift manager"
  task :set, [:email] => :environment do |task, args|
    user = User.find_by_email(args.email)
    if not user
      puts "User not found! Is the email spelled correctly?"
      exit 1
    end
    user.workshift_manager = true
    user.save
    puts "Success! The user with email address '#{args.email}' now has workshift manager privileges."
  end
end
