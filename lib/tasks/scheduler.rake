desc "This task is called by the Heroku scheduler add-on"
task :reset_attendees => :environment do
  
    # Clear Attendees Day After Open Mic
    
    yesterday = ""
    
    if Time.now.wday == 0
      yesterday = "Saturday"
    else
      yesterday = Date::DAYNAMES[Time.now.wday-1]
    end
    
    puts "Removing attendees for open mics on " + yesterday + "..."
    OpenMic.find_all_by_day_of_week(yesterday).each do |open_mic|
      open_mic.remove_all_attendees
      puts "Removing attendees for " + open_mic.name
    end
    
    puts "...finished removing attendees."
    
end