class TraccarController < Sinatra::Base

  post '/' do 
 	activity = JSON.parse(request.body.read)
    
    File.open('./log/traccaractivity.log', 'a') do |f|
      f << "#{activity}\n" 
      f << "#{activity['device']['name']}\n"
#       f << "#{activity['event']['type']}\n"
    end
    
    unless activity["geofence"].nil?
	  device = activity["device"]["name"].gsub(" ","%20")
	  geofence = activity["geofence"]["name"].gsub(" ","%20")
	  geofence_status = activity["event"]["type"].gsub("geofence","")  + "ed"
	  url = "https://graph-eu01-euwest1.api.smartthings.com/api/token/91150eb1-de4d-45a5-bb5a-77129d5c4f8c/smartapps/installations/327bca3d-4522-474f-a2ee-e84439fde8f5/execute/:248156d1b1cc4ee0e1f06cdf2567c326:?device=#{device}&geofence=#{geofence}&status=#{geofence_status}"
      uri = URI(url)
      response = Net::HTTP.get(uri)  
	end
    
    puts activity
#     puts activity["event"]["type"]
    puts activity["device"]["name"]
#     File.open("./log/traccaractivity.log", "w") { |file| file.puts "#{activity['event']['type']}"}
    puts url
  end 

end


