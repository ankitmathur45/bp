class HomepageController < ApplicationController

	# def home
	# 	images = params[:images]
	# 	audios = params[:audios]
	# 	gps = params[:gps]
	# 	time_now = Time.now().to_i.to_s
	# 	#dir = File.dirname("#{Rails.root}/lib/assets/" + time_now)
	# 	#FileUtils.mkdir_p(dir) unless File.directory?(dir)
	# 	images.each do |image|
	# 		open("#{Rails.root}/lib/assets/" + image[:name], 'wb+') { |f|
	# 			f.puts Base64.decode64(image[:content])
	# 		}
	# 	end
	# 	audios.each do |audio|
	# 		open("#{Rails.root}/lib/assets/" + audio[:name], 'wb+') { |f|
	# 			f.puts Base64.decode64(audio[:content])
	# 		}
	# 	end
	# 	gps.each do |loc|
	# 		open("#{Rails.root}/lib/assets/loc" + Time.now().to_i.to_s + ".txt", 'wb+') { |f|
	# 			f.puts loc.to_s
	# 		}
	# 	end		
	# 	result = "Yo"
	# 	render json: {message: 'success', result: result}
	# end

	def home
		images = params[:images]
		audios = params[:audios]
		gps = params[:gps]
		#time_now = Time.now().to_i.to_s
		if images.count > 0 
			images.each do |image|
				new_info = Info.new(:date_time => image[:time], :info_type => 'Image', :info_name => image[:name], :info_value => image[:content])
				new_info.save!
			end
		end
		if audios.count 
			audios.each do |audio|
				new_info = Info.new(:date_time => audio[:time], :info_type => 'Audio', :info_name => audio[:name], :info_value => audio[:content])
				new_info.save!
			end
		end
		if gps.count
			gps.each do |loc|
				lat = loc[:latitude]
				long = loc[:longitude]
				lat_long = loc[:latitude].to_s + "-" + loc[:longitude].to_s
				new_info = Info.new(:date_time => loc[:time], :info_type => 'GPS', :info_name => "lat-long", :info_value => lat_long)
				new_info.save!
			end
		end 
		render json: {message: 'success'}
	end


	def homepage
		#time_now = Time.now().to_s
		#new_info = Info.new(:date_time => time_now, :info_type => 'Image', :info_value => 'ABCD')
		#new_info.save!
		#@data = Info.all
	end

	# $info = [
	# 	{:id => 1, :date_time => '12', :info_type => 'Image', :info_name => '123'},
	# 	{:id => 2, :date_time => '12', :info_type => 'Audio', :info_name => '123'},
	# 	{:id => 3, :date_time => '12', :info_type => 'GPS', :info_name => '123'}
	# ];
	
	def get_data
		rows = Info.select(:id, :date_time, :info_type, :info_name)
		render json: {message: "success", info: rows}
	end

	def get_info
		id = params[:id]
		row = Info.where(:id => id).first
		render json: {message: "success", info: row}
	end

end

#curl -X POST -H "Content-Type: application/json" -d '{"images":[{"name":"ABC","content":"ABCD","time":"12:12:12"},{"name":"XYZ","content":"ABCD","time":"12:12:12"}], "audios":[{"name":"ABC","content":"ABCD","time":"12:12:12"},{"name":"XYZ","content":"ABCD","time":"12:12:12"}], "gps":[{"latitude":"77.77", "longitude":"12.93", "time":"12:12:12"},{"latitude":"77.77", "longitude":"12.93", "time":"12:12:12"}]}' http://192.168.1.3:8000/home