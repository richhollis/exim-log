module Exim
  module Log
    module Parsers
      class TimeStampParser
        def call(line, event_hash)
          event_hash.tap do |h|
            h['time_raw'] = h['time']
            h['time'] = parse_time(h)
          end
        end

        private

        def parse_time(h)
          begin
           Time.parse(h['time']) if h.has_key?('time')
          rescue ArgumentError
            nil
          end || default_time
        end

        def default_time
          Time.new(1970,1,1)
        end
      end
    end
  end
end