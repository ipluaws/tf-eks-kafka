{{- define "producer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "producer.fullname" -}}
{{- printf "%s-%s" (include "producer.name" .) .Release.Name -}}
{{- end -}}

