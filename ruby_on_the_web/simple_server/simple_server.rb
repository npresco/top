require 'socket'
require 'json'

server = TCPServer.open(2000)


loop {
  client = server.accept
  header = client.readline.split(" ")
  if header[0] == 'GET'
  	if File.exist?(".#{header[1]}")
	  	client.print "HTTP/1.0 200 OK\r\nDate: #{Time.now.ctime}\r\nContent-Type: text/html
	  	\r\nContent-Lenght: #{File.open(".#{header[1]}", "r").size}\r\n\r\n"
	    File.open(".#{header[1]}", "r") do |f|
		  f.each_line do |line|
		    client.print(line)
	  	  end
		  end
	    client.close
	  else
		  client.puts "HTTP/1.0 404 File Not Found\r\n"
		  client.close
	  end
  else
    whole = ""
    while true 
      whole << client.readline
      break if whole =~ /\r\n\r\n$/
    end
    data = whole.split[-1]
  	params = JSON.parse(data)
    thanks = File.open("./thanks.html")
    client.print(thanks.read.gsub("<%= yield %>", "<li>Name: #{params['viking']['name']}</li><li>Email: #{params['viking']['email']}</li>"))
  	client.close
  end
}
