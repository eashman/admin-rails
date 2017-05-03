require 'pty'


class ViewerController < ApplicationController

  include ActionController::Live

  def index

#    streamer = lambda do |chunk, remaining_bytes, total_bytes|
#      puts chunk
#      puts "Remaining: #{remaining_bytes.to_f / total_bytes}%"
#    end

      logger.info "Stream start"
      response.headers['Content-Type'] = 'text/event-stream'


      begin
        PTY.spawn( "find /Users/eashman | grep png" ) do |stdout, stdin, pid|
          begin
            stdout.each { |line| response.stream.write line }
          rescue Errno::EIO
          end
        end
      rescue PTY::ChildExited
        puts "The child process exited!"
      end


      # (1..25).each do |num|
      #   response.stream.write "event: number = #{num}\n"
      #   sleep 1
      # end
        # Excon.get('http://geemus.com', :response_block => streamer)


    rescue IOError => e
      logger.info "Stream closed (IOError)"
    rescue Errno::ECONNRESET => e
      logger.info "Stream closed (Errno)"
    else
      logger.info "Stream closed (Normaly)"
    ensure
      logger.info "Countdown done"
      response.stream.close
    end


end
