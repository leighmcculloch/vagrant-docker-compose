FROM ubuntu:bionic as builder

RUN apt-get update -y && \
  apt-get install -y \
    build-essential \
    curl

RUN cd /tmp && \
  curl -O http://download.redis.io/redis-stable.tar.gz && \
  tar xvzf redis-stable.tar.gz && \
  cd redis-stable && \
  make && \
  chmod 755 src/redis-cli

FROM ubuntu:bionic

# Install nc for web serving
RUN apt-get update -y && apt-get install -y netcat curl

# Install redis-cli
COPY --from=builder /tmp/redis-stable/src/redis-cli /usr/local/bin/

# Serve the date and a counter
EXPOSE 8080
CMD while true ; do nc -l -p 8080 -c 'echo "HTTP/1.1 200 OK\n\n$(date)\nVisit count: $(redis-cli -h redis incr visit_counter)"' ; done
