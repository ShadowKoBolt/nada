desc "This task is called by the Heroku scheduler add-on"

task :renew_1 => :environment do
  User.where(renewal_date: 1.month.from_now).each do |user|
    puts "Sendind renew 1 to #{user.email}"
    ApplicationMailer.renew_1(user.id).deliver
  end
end

task :renew_2 => :environment do
  User.where(renewal_date: 2.weeks.from_now).each do |user|
    puts "Sendind renew 2 to #{user.email}"
    ApplicationMailer.renew_2(user.id).deliver
  end
end
