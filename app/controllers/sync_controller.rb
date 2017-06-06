class SyncController < ApplicationController
  def index
    IO.popen('find /Users/eashman/src 2> /dev/null') do |io|
      while (line = io.gets) do
        # Note - here you could use break to get out and sigpipe
        # subprocess to finish it early. It will however mean that your subprocess
        # will stop running early and you need to test if it will stop without
        # causing any trouble
        #next if selection.size > 5
        #selection << line if line =~ pattern

      end
    end
  end
end
