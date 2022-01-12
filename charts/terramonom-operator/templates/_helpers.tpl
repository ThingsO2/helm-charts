{{/*
 Expand the name of the chart.
 */}}
{{- define "terramonom-operator.name" -}}
{{- default .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
 Create chart name and version as used by the chart label.
 */}}
{{- define "terramonom-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
 Common labels
 */}}
{{- define "terramonom-operator.labels" -}}
helm.sh/chart: {{ include "terramonom-operator.chart" . }}
{{ include "terramonom-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: {{ required "labelComponent is required" .Values.labelComponent }}
app.kubernetes.io/part-of: {{ required "labelPartOf is required" .Values.labelPartOf }}
app.kubernetes.io/instance: {{ include "terramonom-operator.instance" . }}
{{- end }}

{{/*
 Expand the name of the chart.
 */}}
{{- define "terramonom-operator.instance" -}}
{{- if .Values.instanceOverride -}}
{{- .Values.instanceOverride -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "randAlphaNum" }}
{{- end }}
{{- end }}

{{/*
 Selector labels
 */}}
{{- define "terramonom-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "terramonom-operator.name" . }}
{{- end }}