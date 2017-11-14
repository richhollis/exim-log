module Exim
  module Log
    class Flag
      def self.arrived
        '<='
      end

      def self.fake_rejected
        '(='
      end

      def self.delivered
        '=>'
      end

      def self.additional_address
        '->'
      end

      def self.cut_through
        '>>'
      end

      def self.suppressed
        '*>'
      end

      def self.failed
        '**'
      end

      def self.deferred
        '=='
      end

      def self.bounced
        "<>"
      end
    end
  end
end