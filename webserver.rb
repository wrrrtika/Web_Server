require 'socket'                                    # Require socket from Ruby Standard Library (stdlib)
													# This allows access to TCP server

host = 'localhost'
port = 2000

server = TCPServer.open(host, port)                 # Socket to listen to defined host and port
puts "Server started on #{host}:#{port} ..."        # Output to stdout that server started
													# Sockets are bi-directional, motherfucker.

loop do                                             # Server runs forever
  client = server.accept                            # Wait for a client to connect. Accept returns a TCPSocket
  													# CLient is a socket too in this instance.

  lines = []
  while (line = client.gets)  
  line = line.chomp
  	break if line.empty? 							# Read the request and collect it until it's empty
    lines << line
  end
  puts lines                                        # Output the full request to stdout

  filename = lines[0].gsub(/GET \//, '').gsub(/ HTTP.*/, '')
  
  if File.exists?(filename)
  	body = File.read(filename)
  	headers << "HTTP/1.1 200 OK"

  	
  	

  	headers << "Content-Type: text/html"
	else
  	body = "404: File not found\n"
 end

 headers = [								
  "Content-Length: #{body.size}",
  "Connection: Close"

 ]


  body = Time.now.ctime

  

headers.join("\r\n")
response = [headers, body].join("\r\n\r\n")

puts headers

#response = headers + body

  client.puts(response)                      		# Output the current time to the client
  client.close                                      # Disconnect from the client
end