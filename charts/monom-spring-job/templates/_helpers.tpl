{{/*
 Expand the name of the chart.
 */}}
{{- define "monom-spring-job.name" -}}
{{- default .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
 Create chart name and version as used by the chart label.
 */}}
{{- define "monom-spring-job.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
 Common labels
 */}}
{{- define "monom-spring-job.labels" -}}
helm.sh/chart: {{ include "monom-spring-job.chart" . }}
{{ include "monom-spring-job.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: {{ required "labelComponent is required" .Values.labelComponent }}
app.kubernetes.io/part-of: {{ required "labelPartOf is required" .Values.labelPartOf }}
app.kubernetes.io/instance: {{ include "monom-spring-job.instance" . }}
{{- end }}

{{/*
 Expand the name of the chart.
 */}}
{{- define "monom-spring-job.instance" -}}
{{- if .Values.instanceOverride -}}
{{- .Values.instanceOverride -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "randAlphaNum" }}
{{- end }}
{{- end }}

{{/*
 Selector labels
 */}}
{{- define "monom-spring-job.selectorLabels" -}}
app.kubernetes.io/name: {{ include "monom-spring-job.name" . }}
{{- end }}
