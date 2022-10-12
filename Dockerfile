FROM debian:bullseye


# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    flac \
    sox

# Clone the repository and install it
RUN cd /tmp && \
    git clone http://www.pogo.org.uk/~mark/bpm-tools.git &&\
    cd bpm-tools && \
    make && \
    make install

# Remove unnecessary dependencies
RUN apt-get remove -y git build-essential

# Remove dangling dependencies
RUN apt-get autoremove -y

# Arguments to pass to the container
ARG UNAME=bpm-tools
ARG PUID=1000
ARG PGID=1000
ARG INTERVAL

# User and group creation
RUN groupadd -g $PGID -o $UNAME
RUN useradd -m -u $PUID -g $PGID -o -s /bin/bash $UNAME
USER $UNAME

# Command that executes on container startup
CMD  while :; do find /music -name '*.flac' -print0 | xargs -0 -n1 -P4 bpm-tag; echo "$(date): done analysing library, sleeping for ${INTERVAL} seconds."; sleep ${INTERVAL}; done
