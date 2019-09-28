FROM ubuntu:bionic
RUN apt-get update -y
RUN apt-get install -y netcat
EXPOSE 8080
CMD while true ; do nc -l -p 8080 -c 'echo "HTTP/1.1 200 OK\n\n$(date)"' ; done
