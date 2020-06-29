this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'hello_world_services_pb'

class ServerImpl < HelloWorld::Service
    def say_hello(hello_message, _call)
        puts "Hai there, #{hello_message.name}"
        HelloResponse.new(responseMessage: "Message printed")
    end
end

def main
    port = '0.0.0.0:50051'
    s = GRPC::RpcServer.new
    s.add_http2_port(port, :this_port_is_insecure)
    puts "Starting server..."
    GRPC.logger.info("... running insecurely on #{port}")
    s.handle(ServerImpl.new)
    puts "... running insecurely on #{port}"
    # Runs the server with SIGHUP, SIGINT and SIGQUIT signal handlers to 
    #   gracefully shutdown.
    # User could also choose to run server via call to run_till_terminated
    s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main