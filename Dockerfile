FROM cassandra:3.11.1

ENV CLUSTER_FROM=cluster1 \
    CLUSTER_TO=cluster2 \
    DC_NAME=dc \
    SOURCE_RF=3 \
    TARGET_RF=1 

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

ADD cassandra-exporter/package.json /package.json

RUN npm install /

ADD cassandra-exporter/export.js /export.js
ADD cassandra-exporter/import.js /import.js
ADD cassandra-exporter/index.js /index.js
ADD entrypoint.sh /entrypoint.sh

WORKDIR /
ENTRYPOINT ["/entrypoint.sh"]
