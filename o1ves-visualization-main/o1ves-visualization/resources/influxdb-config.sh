#!/bin/sh

INFLUXDB_URL="http://{{ .Release.Name }}-influxdb2.{{ .Release.Namespace }}"

influx config create --config-name influx \
    --host-url $INFLUXDB_URL \
    --org $INFLUXDB_ORG \
    --token $INFLUXDB_TOKEN \
    --active

{{ range .Values.buckets }}
influx bucket create \{{ if .description }}
    --description {{ .description }} \{{ end }}{{ if .retention }}
    --retention {{ .retention }} \{{ end }}{{ if .shardGroupDuration }}
    --shard-group-duration {{ .shardGroupDuration }} \{{ end }}{{ if .shardDuration }}
    --shard-duration {{ .shardDuration }} \{{ end }}
    --name {{ .name }}
{{ end }}
