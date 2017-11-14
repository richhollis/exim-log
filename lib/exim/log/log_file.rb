module Exim
  module Log
    class LogFile
      def initialize(file_path, opts = {})
        @file_path = file_path
        @opts = opts.merge(option_defaults)
      end

      def events
        EventReader.new(@file_path, @opts)
      end

      private

      def option_defaults
        {
          parsers: [
            Parsers::PrimaryLineParser,
            Parsers::TimeStampParser,
            Parsers::AddressParser,
            Parsers::FieldParser
          ],
          event_class: Event
        }
      end      
    end
  end
end