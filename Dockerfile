FROM cassandra:4.1.1

# Reference - https://blog.pythian.com/step-step-monitoring-cassandra-prometheus-grafana/
# Updated the versions of JMX Prometheus JavaAgent

RUN mkdir /opt/jmx_prometheus

# https://github.com/prometheus/jmx_exporter
RUN wget -P /opt/jmx_prometheus https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.18.0/jmx_prometheus_javaagent-0.18.0.jar
COPY jmx_prometheus/cassandra.yaml /opt/jmx_prometheus/cassandra.yaml

RUN echo 'JVM_OPTS="$JVM_OPTS -javaagent:/opt/jmx_prometheus/jmx_prometheus_javaagent-0.18.0.jar=7070:/opt/jmx_prometheus/cassandra.yaml"' >> /etc/cassandra/cassandra-env.sh

EXPOSE 7070