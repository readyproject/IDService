require 'thrift'

class InvalidSystemClock < ::Thrift::Exception
  include ::Thrift::Struct, ::Thrift::Struct_Union
  def initialize(message=nil)
    super()
    self.message = message
  end

  MESSAGE = 1

  FIELDS = {
      MESSAGE => {:type => ::Thrift::Types::STRING, :name => 'message'}
  }

  def struct_fields; FIELDS; end

  def validate
  end

  ::Thrift::Struct.generate_accessors self
end

