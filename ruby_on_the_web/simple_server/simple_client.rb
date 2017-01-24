require 'socket'
require 'json'

hostname = 'localhost'
port = 2000
s = TCPSocket.open(hostname, port)
path = "/index.html"

until @option == 'GET' || @option == 'POST'
puts "What type of request would you like to send: 'GET' or 'POST'"
@option = gets.chomp
end

if @option == 'GET'
	request = "GET #{path} HTTP1.0\r\n\r\n"
	s.print(request)
	header = s.readline.split(" ")
	if header[1] != '200'
	  puts header.join(" ")
	else
	  puts header.join(" ")
	  puts s.readlines
	end
elsif @option == 'POST'
	puts "Welcome Viking, what is your name?"
	user_name = gets.chomp
	puts "What is your email?"
	user_email = gets.chomp
	post_data = {:viking => {:name => user_name, :email => user_email}}
	request = "POST /viking.cgi HTTP/1.0\r\nContent-Type: application/x-www-form-urlencoded
			   \r\nContent-Length: #{post_data.to_json.size}\r\n#{post_data.to_json}\r\n\r\n"
	s.print(request)
	puts s.readlines
end