{{/*
 Expand the name of the chart.
 */}}
{{- define "awm.name" -}}
{{- default .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
 Create chart name and version as used by the chart label.
 */}}
{{- define "awm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
 Common labels
 */}}
{{- define "awm.labels" -}}
helm.sh/chart: {{ include "awm.chart" . }}
{{ include "awm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ include "awm.instance" . }}
{{- end }}

{{/*
 Expand the name of the chart.
 */}}
{{- define "awm.instance" -}}
{{- if .Values.instanceOverride -}}
{{- .Values.instanceOverride -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "randAlphaNum" }}
{{- end }}
{{- end }}

{{/*
 Selector labels
 */}}
{{- define "awm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "awm.name" . }}
{{- end }}

{{/*
 Service
 */}}
{{- define "awm.service-type" -}}
{{- if .Values.ingress.enabled -}}
NodePort
{{- else -}}
{{ .Values.service.type }}
{{- end }}
{{- end }}

{{/*
 Ingress
 */}}
{{- define "awm.ingress-annotations" -}}
{{- if .Values.ingress.annotations -}}
{{- .Values.ingress.annotations -}}
{{- else -}}
kubernetes.io/ingress.class: gce
networking.gke.io/v1beta1.FrontendConfig: {{ required "gkeAnnotationPrefix is required" .Values.ingress.gkeAnnotationPrefix }}-ingress-security-config
kubernetes.io/ingress.global-static-ip-name: {{ required "gkeAnnotationPrefix is required" .Values.ingress.gkeAnnotationPrefix }}
networking.gke.io/managed-certificates: {{ required "gkeAnnotationPrefix is required" .Values.ingress.gkeAnnotationPrefix }}
{{- end }}
{{- end }}
