#cd app/services/grpc-python-app && source venv/bin/activate && python server.py

from concurrent import futures
import grpc
#import hello_pb2
#import hello_pb2_grpc
import greeter_pb2
import greeter_pb2_grpc

class GreeterServicer(greeter_pb2_grpc.GreeterServicer):
    def SayHello(self, request, context):
    #def say_hello(self, request, context):
        #print("python SayHello start")
        #return "a"
        return greeter_pb2.HelloReply(message='Hello, %s!' % request.name)

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    greeter_pb2_grpc.add_GreeterServicer_to_server(GreeterServicer(), server)
    server.add_insecure_port('[::]:50051')
    print("Starting server on port 50051...")
    server.start()
    server.wait_for_termination()

if __name__ == '__main__':
    serve()