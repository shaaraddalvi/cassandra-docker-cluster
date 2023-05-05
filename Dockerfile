FROM cassandra:4.1.1

# Reference - https://blog.pythian.com/step-step-monitoring-cassandra-prometheus-grafana/

# https://github.com/instaclustr/cassandra-exporter - Using this instead of the exporter mentioned in above reference
RUN wget -P /opt/cassandra/lib https://github.com/instaclustr/cassandra-exporter/releases/download/v0.9.12/cassandra-exporter-agent-0.9.12-SNAPSHOT.jar

RUN echo 'JVM_OPTS="$JVM_OPTS -javaagent:$CASSANDRA_HOME/lib/cassandra-exporter-agent-0.9.12-SNAPSHOT.jar"' >> /etc/cassandra/cassandra-env.sh

EXPOSE 9500