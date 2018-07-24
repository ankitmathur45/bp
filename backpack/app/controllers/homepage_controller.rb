class HomepageController < ApplicationController

	def homepage
		render json: {message: 'success', result: result}
	end

	def home
		images = params[:images]
		audios = params[:audios]
		gps = params[:gps]
		time_now = Time.now().to_i.to_s
		#dir = File.dirname("#{Rails.root}/lib/assets/" + time_now)
		#FileUtils.mkdir_p(dir) unless File.directory?(dir)
		images.each do |image|
			open("#{Rails.root}/lib/assets/" + image[:name], 'wb+') { |f|
				f.puts Base64.decode64(image[:content])
			}
		end
		audios.each do |audio|
			open("#{Rails.root}/lib/assets/" + audio[:name], 'wb+') { |f|
				f.puts Base64.decode64(audio[:content])
			}
		end
		gps.each do |loc|
			open("#{Rails.root}/lib/assets/loc" + Time.now().to_i.to_s + ".txt", 'wb+') { |f|
				f.puts loc.to_s
			}
		end		
		result = "Yo"
		render json: {message: 'success', result: result}
	end

end

#curl -X POST -H "Content-Type: application/json" -d '{"images":[{"name":"ABC","content":"ABCD","time":"12:12:12"},{"name":"XYZ","content":"ABCD","time":"12:12:12"}], "audios":[{"name":"ABC","content":"ABCD","time":"12:12:12"},{"name":"XYZ","content":"ABCD","time":"12:12:12"}], "gps":[{"latitude":"77.77", "longitude":"12.93", "time":"12:12:12"},{"latitude":"77.77", "longitude":"12.93", "time":"12:12:12"}]}' http://192.168.1.3:8000/home