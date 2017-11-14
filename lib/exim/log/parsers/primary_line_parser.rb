module Exim
  module Log
    module Parsers
      class PrimaryLineParser
        def call(line, event_hash)
          event_hash.tap do |h|
            matchers.each do |re|
              m = line.match(re)
              if m && m.captures.count == re.names.count
                return m.names.zip(m.captures).to_h 
              end
            end
          end
        end

        private

        def matchers
          [
            full_log_line,
            partial_log_line,
            basic_log_with_time,
            basic_text_log           
          ]
        end

        def full_log_line
          /(?<time>[\-:\d\s]{19})\s(?<id>[a-zA-Z\-\d]{16})\s(?<flag>\W{2})\s(?<message>.*)/
        end

        def partial_log_line
          /(?<time>[\-:\d\s]{19})\s(?<id>[a-zA-Z\-\d]{16})\s(?<message>.*)/
        end

        def basic_log_with_time
          /(?<time>[\-:\d\s]{19})\s(?<message>.*)/
        end

        def basic_text_log
          /(?<message>.*)/
        end
      end
    end
  end
end