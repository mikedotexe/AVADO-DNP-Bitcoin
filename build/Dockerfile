FROM debian:bullseye-slim as binary
ARG VERSION=27.0

ENV FILENAME=bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz
ENV DOWNLOAD_URL=https://bitcoin.org/bin/bitcoin-core-${VERSION}/${FILENAME}

RUN echo "Building Bitcoin Core version: ${VERSION}"

# Step 1: Update the package list
RUN apt-get update && echo "Package list updated successfully"

# Step 2: Install required packages including 'file' for verification
RUN apt-get install -y wget tar ca-certificates file && echo "Required packages installed successfully"

# Step 3: Download Bitcoin Core
RUN wget ${DOWNLOAD_URL} -O /bitcoin.tar.gz && echo "Bitcoin Core downloaded successfully" || (echo "Bitcoin Core download failed" && exit 1)

# Step 4: Check the downloaded file
RUN ls -lh /bitcoin.tar.gz && file /bitcoin.tar.gz || (echo "File verification failed" && exit 1)

# Step 5: Extract Bitcoin Core
RUN tar xvf /bitcoin.tar.gz && mv /bitcoin-* /bitcoin && echo "Bitcoin Core extracted and moved successfully" || (echo "Extraction failed" && exit 1)

FROM debian:bullseye-slim AS final

COPY --from=binary /bitcoin/bin/bitcoind /usr/local/bin/

# Ensure the directory exists before adding the file
RUN mkdir -p /root/.bitcoin

# Copy the bitcoin.conf file to the correct location
ADD ./config/bitcoin.conf /root/.bitcoin/

ADD ./bin/docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
