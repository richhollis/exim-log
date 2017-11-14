module Exim
  module Log
    class EventReader
      include Enumerable
      
      def initialize(file_path, opts)
        @file_path = file_path
        @opts = opts
      end

      def each
        parsers = parser_instances
        File.open(@file_path) do |file|
          reader = @file_path.include?(".gz") ? Zlib::GzipReader.new(file) : file
          reader.each_line.map do |line|             
            event_hash = {}            
            parsers.each{|parser| event_hash = parser.call(line, event_hash) }
            yield @opts[:event_class].new(event_hash)
          end 
        end
      end

      def all
        to_a
      end

      def find_in_batches(options = {})
        batch_size = options[:batch_size] || 1000
        if block_given?
          each_slice(batch_size) do |batch|
            yield batch
          end
        end
      end

      private

      def parser_instances
        @parser_instances ||= @opts[:parsers].map{|parser_class| parser_class.new }
      end
    end
  end
end
