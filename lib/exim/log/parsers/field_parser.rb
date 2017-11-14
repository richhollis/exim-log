module Exim
  module Log
    module Parsers
      class FieldParser
        def call(line, event_hash)
          event_hash.tap do |h|            
            if flag = h['flag']
              field_hash = extract(h['message'])
              h.merge!(field_hash)
            end
          end
        end

        private

        def extract(message)
          {}.tap do |h|
            fields = Field.all

            indexes = fields.map{|field| message.index(" #{field.id}=") }         
            indexes_present = indexes.select{|i| i.present? }.sort

            indexes.each_with_index do |start_pos, field_index|
              next unless start_pos.present?            
              field = fields[field_index]
              field_id = field.id
              start_pos += (2 + field_id.length) # 2 (1 space, 1 equals (=))
              end_pos = indexes_present.find{|i| i > start_pos} || message.length
              value = message.slice(start_pos..end_pos)
              h[field_id] = value
            end
          end
        end
      end
    end
  end
end