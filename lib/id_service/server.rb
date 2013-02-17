require 'thrift'
require 'active_support/core_ext'

require 'id_service/helpers'
require 'id_service/processor'
require 'id_service/types'

require 'id_generator'

module IdService
  class Server < Thrift::SimpleServer
    attr_reader :hostname, :port, :host, :worker, :debug

    def initialize(options = {})
      options.symbolize_keys!
      options = default_options.merge(options)

      options.each { |key, value| instance_variable_set('@' + key.to_s, value) }

      @handler = IdGenerator.new(options)
      @processor = IdService::Processor.new(@handler)
      @server_transport = Thrift::ServerSocket.new(options[:hostname], options[:port].to_s)
      @transport_factory = Thrift::BufferedTransportFactory.new()
      @protocol_factory = Thrift::BinaryProtocolFactory.new
    end

  private
    def default_options
      {
          hostname: 'localhost',
          port:     9000,
          host:     1,
          worker:   1,
          debug:    false,
      }
    end
  end
end
