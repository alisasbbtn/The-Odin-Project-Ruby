require 'socket'
require 'json'

server = TCPServer.open(2000)
loop {
  client = server.accept
  request = client.gets.split
  case request[0]
    when "GET"
      path = request[1]
      body = ''
      if File.exist?(path)
        body = File.read(path)
        status_code = 200
        reason_phrase = 'OK'
      else
        status_code = 404
        reason_phrase = 'Not found'
      end

      client.puts "#{request[2]} #{status_code} #{reason_phrase}"
      client.puts "Date: #{Time.now.ctime}"
      client.puts "Content-Length: #{body.size}"
      client.puts body
    when "POST"
      client.gets
      client.gets

      params = JSON.parse(client.gets)
      file = File.read("./thanks.html")

      file.gsub!("<%= yield %>", "<li>Name: #{params["viking"]["name"]} </li><li> Email: #{params["viking"]["email"]}</li>")

      client.puts file

  end


  client.close
}