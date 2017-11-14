module Exim
  module Log
    module Parsers
      class AddressParser
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

            address = ""
            indexes = fields.map{|field| message.index(" #{field.id}=") }         
            indexes_present = indexes.select{|i| i.present? }.sort
            colon_index = message.index(":") 
            
            if indexes_present.empty?            
              address = colon_index ? message[0..colon_index-1] : ""
            else
              address = message.slice(0, indexes_present.first)
              if colon_index = address.index(":")
                address = address[0..colon_index-1]
              end
            end
            
            remove_after_phrase("routing defer", address)

            h['address'] = address
          end
        end

        def remove_after_phrase(phrase, address)
          if phrase_pos = address.index(phrase)
            msg = address[phrase_pos..-1]
            address.gsub!(msg, "")
          end
        end
      end
    end
  end
end