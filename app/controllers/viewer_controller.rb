require 'pty'
require 'reloader/sse'
class ViewerController < ApplicationController

  include ActionController::Live

  #before_filter :authenticate

  ANSI_COLOR_CODE = {
      0 => 'black',
      1 => 'red',
      2 => 'green',
      3 => 'yellow',
      4 => 'blue',
      5 => 'purple',
      6 => 'cyan',
      7 => 'white'
  }

  def sanitize_ansi_data(data)
    data.gsub!(/\033\[1m/,"<b>")
    data.gsub!(/\033\[0m/,"</b></span>")

    data.gsub!(/\033\[[\d\;]{2,}m.*?<\/b><\/span>/){ |data|
      span = "<span style='"
      content = ""
      /\033\[([\d\;]{2,})m(.*?)<\/b><\/span>/.match(data) {|m|
        content = m[2]
        m[1].split(";").each do |code|
          #puts code
          if match = /(\d)(\d)/.match(code)
            case match[1]
              when "3"
                span += "color: #{ANSI_COLOR_CODE[match[2].to_i]}; "
              when "4"
                span += "background-color: #{ANSI_COLOR_CODE[match[2].to_i]}; "
              else
                #do nothing
            end
          else
            span += "font-weight:bold; "
          end
        end
      }
      span += "'>"
      "#{span}#{content}</b></span>"
    }
    data
  end



  def index
    render 'viewer/index'
  end


  def watch

  end

  def index_stream
    response.headers['Content-Type'] = 'text/event-stream'
    sse = Reloader::SSE.new(response.stream)
    begin

      # (1..25).each do |num|
      #   text = "event: number = #{num}\n"
      #
      #   sse.write( text, event: 'results')
      #   logger.info text
      #   sleep 1
      # end


        begin
#         PTY.spawn( "lolcat -h" ) do |stdout, stdin, pid|

            PTY.spawn( "cd /Users/eashman/src/sync-data; ./sync-all.sh staging production" ) do |stdout, stdin, pid|
            begin
              stdout.each { |line| sse.write( line, event: 'results') }
            rescue Errno::EIO
            end
          end
        rescue PTY::ChildExited
          puts "The child process exited!"
        end
        sse.write( 'finished', event: 'finished')
        sse.close

    rescue IOError
      # When the client disconnects, we'll get an IOError on write
    ensure
      sse.close
    end

    # begin
    #   sse.write(last_updated, event: 'results')
    # rescue IOError
    #   # When the client disconnects, we'll get an IOError on write
    # ensure
    #   sse.close
    # end


  end


  def files

#    streamer = lambda do |chunk, remaining_bytes, total_bytes|
#      puts chunk
#      puts "Remaining: #{remaining_bytes.to_f / total_bytes}%"
#    end

      logger.info "Stream start"
      response.headers['Content-Type'] = 'text/event-stream'


      # begin
      #   PTY.spawn( "find /Users/eashman | grep png" ) do |stdout, stdin, pid|
      #     begin
      #       stdout.each { |line| response.stream.write line }
      #     rescue Errno::EIO
      #     end
      #   end
      # rescue PTY::ChildExited
      #   puts "The child process exited!"
      # end


      (1..25).each do |num|
        response.stream.write "event: number = #{num}\n"
        sleep 1
      end
        # Excon.get('http://geemus.com', :response_block => streamer)


    rescue IOError => e
      logger.info "Stream closed (IOError)"
    rescue Errno::ECONNRESET => e
      logger.info "Stream closed (Errno)"
    else
      logger.info "Stream closed (Normaly)"
    ensure
      logger.info "View is done"
      response.stream.close
    end


end
