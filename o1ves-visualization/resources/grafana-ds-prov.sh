#!/bin/sh

GRAFANA_URL="http://$GRAFANA_USERNAME:$GRAFANA_PASSWORD@{{ .Release.Name }}-grafana.{{ .Release.Namespace }}"
INFLUXDB_URL="http://{{ .Release.Name }}-influxdb2.{{ .Release.Namespace }}"

cat > /tmp/datasource.json << EOF
{
  "name":"InfluxDB",
  "type":"influxdb",
  "url":"$INFLUXDB_URL",
  "access":"proxy",
  "basicAuth":false,
  "isDefault":true,
  "jsonData": {
    "httpMode": "POST",
    "organization": "influxdata",
    "version": "Flux"
  },
  "secureJsonData": {
    "token": "$INFLUXDB_TOKEN"
  }
}
EOF

curl -X POST -H "Content-Type: application/json" -d @/tmp/datasource.json $GRAFANA_URL/api/datasources
exit $?
