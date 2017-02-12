require 'socket'
require 'json'

host = 'localhost'
port = 2000
path = './index.css'

puts "Method? GET / POST"

method = gets.chomp.upcase

request = "#{method} #{path} HTTP/1.0\r\n\r\n"

socket = TCPSocket.open(host, port)
socket.puts(request)

case method
  when "GET"
    while line = socket.gets
      if line.include?("404")
        puts "Not Found"
      end

      puts line.chop
    end
  when "POST"
    puts "Name for viking:"
    name = gets.chomp
    puts "Email:"
    email = gets.chomp
    information = {:viking => { :name => name, :email => email } }

    socket.puts "Content-Lenght: #{information.to_json.size}"
    socket.puts information.to_json

    while line = socket.gets
      puts line.chop
    end

end
