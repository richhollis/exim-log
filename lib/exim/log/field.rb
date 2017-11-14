module Exim
  module Log
    class Field
      attr_reader :id, :desc
      
      def initialize(id, desc)
        @id = id
        @desc = desc
      end
      
      def self.all
        @all ||= [
          new('A',    "authenticator name (and optional id and sender)"),
          new('C',    "SMTP confirmation on delivery command list for 'no mail in SMTP session'"),
          new('CV',   "certificate verification status"),
          new('D',    "duration of 'no mail in SMTP session'"),
          new('DN',   "distinguished name from peer certificate"),
          new('DS',   "DNSSEC secured lookups"),
          new('DT',   "on => lines: time taken for a delivery"),
          new('F',    "sender address (on delivery lines)"),
          new('H',    "host name and IP address"),
          new('I',    "local interface used"),
          new('K',    "CHUNKING extension used"),
          new('id',   "message id for incoming message"),
          new('P',    "on <= lines: protocol used, on => and ** lines: return path"),
          new('PRDR', "PRDR extension used"),
          new('Q',    "alternate queue name"),
          new('QT',   "on => lines: time spent on queue so far, on 'Completed' lines: time spent on queue"),
          new('R',    "on <= lines: reference for local bounce, on =>  >> ** and == lines: router name"),
          new('S',    "size of message in bytes"),
          new('SNI',  "server name indication from TLS client hello"),
          new('ST',   "shadow transport name"),
          new('T',    "on <= lines: message subject (topic), on => ** and == lines: transport name"),
          new('U',    "local user or RFC 1413 identity"),
          new('X',    "TLS cipher suite")
        ]
      end
    end
  end
end