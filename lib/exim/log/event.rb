module Exim
  module Log
    class Event
      def self.always_present(*fields)
        fields.each do |field|
          define_method(field) { @hash[field.to_s] }
        end
      end

      always_present :time, :id, :message, :address, :flag

      def initialize(hash)
        @hash = hash
      end

      def to_h
        @hash
      end

      def method_missing(method_name, *args, &block)
        if @hash.has_key?(method_name.to_s)
          @hash[method_name.to_s]
        else
          raise NoMethodError.new("undefined method '#{method_name}'")
        end
      end

      def respond_to?(method_name, include_private = false)
        @hash.has_key?(method_name.to_s) || super
      end
    end
  end
end