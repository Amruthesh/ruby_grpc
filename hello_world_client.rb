this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'hello_world_services_pb'

def run_greetings(stub)
    name = "Amruthesh"
    resp = stub.say_hello(HelloMessage.new(name: name))
    puts resp.responseMessage
end

def main
    stub = HelloWorld::Stub.new('0.0.0.0:50051', :this_channel_is_insecure)
    run_greetings(stub) 
end

main