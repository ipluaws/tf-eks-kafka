{{/*
Expand the name of the chart.
*/}}
{{- define "consumer.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "consumer.fullname" -}}
{{- printf "%s-%s" (include "consumer.name" .) .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

