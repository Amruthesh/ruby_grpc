# ruby_grpc
Hello world application to learn gRpc with client and servers in Ruby

## Pre-requisites
Install grpc and grpc-tools
```
gem install grpc --no-document
gem install grpc-tools --no-document
```

## Creating this application

### Proto file, client and server interfaces

1. Add a new file called hello_world.proto in the protos directory. Add line that indicates the version of proto ``` syntax = "proto3" ```
2. Define the hello_world service using protocol buffers.
``` 
    service HelloWorld {
      ...
    }
```
3. Add the rpc methods that needs to be implemented by the server and consumed by the client.
```
  rpc SayHello(HelloMessage) returns (HelloResponse) {}
  ...
```
4. Add the protocol message buffer definitions outside the service module.
```
  message HelloMessage {
    string name = 1;
  }
```
5. Compile the proto file to generate the client and server definitions.
``` 
grpc_tools_ruby_protoc -I ./protos --ruby_out=./lib --grpc_out=./lib ./protos/hello_world.proto 
```
This should generate the interfaces in the lib directory - hello_world_pb and hello_world_services_pb

### Creating the Server

1. Create a new ruby file for the server - ``` helloworld_server.rb ```
2. Make sure to include the lib directory in the $load_path
3. Require 'grpc' and 'hello_world_services_pb'
4. Create a new server implementation class that extends ``` HelloWorld::Service ```
5. Implement the rpc calls which have been defined in the proto file.
6. After the server class definition, add the main method that starts the server.
7. Provide the host, port details to start the server.
```
port = '0.0.0.0:50051'
s = GRPC::RpcServer.new
s.add_http2_port(port, :this_port_is_insecure)    
```
8. Call the main method at the end.
9. To start the server, in the terminal, cd into the application directory and use the following command.
``` 
ruby hello_world_server.rb 
```
This should start the server listening on localhost, 50051 port

### Creating the Client

1. Create a new ruby file for the client - ``` hello_world_server.rb ```
2. Make sure to include the lib directory in the $load_path.
3. Require 'grpc' and 'hello_world_services_pb'
4. Define the main method.
5. Instantiate the stub with the host and port details on which the server is listening.
6. Pass the stub to the methods that call the rpc calls.
```
def run_greetings(stub)
...
end
```
7. Call the rpc methods on the stub with the protocol buffer messages
```
stub.say_hello(HelloMessage.new(name: name))
```
8. This should execute the call on the server and return the defined protocol buffer message response
```
resp.responseMessage
```
9. Call the main method in the end
10. Open a new terminal, cd into the application directory and run the following command.
```
ruby hello_world_client.rb
```
This should call the rpc on the server and process the response.
