{{/*
 Expand the name of the chart.
 */}}
{{- define "monom-react.name" -}}
{{- default .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
 Create chart name and version as used by the chart label.
 */}}
{{- define "monom-react.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
 Common labels
 */}}
{{- define "monom-react.labels" -}}
helm.sh/chart: {{ include "monom-react.chart" . }}
{{ include "monom-react.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: {{ required "labelComponent is required" .Values.labelComponent }}
app.kubernetes.io/part-of: {{ required "labelPartOf is required" .Values.labelPartOf }}
app.kubernetes.io/instance: {{ include "monom-react.instance" . }}
{{- end }}

{{/*
 Expand the name of the chart.
 */}}
{{- define "monom-react.instance" -}}
{{- if .Values.instanceOverride -}}
{{- .Values.instanceOverride -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "randAlphaNum" }}
{{- end }}
{{- end }}

{{/*
 Selector labels
 */}}
{{- define "monom-react.selectorLabels" -}}
app.kubernetes.io/name: {{ include "monom-react.name" . }}
{{- end }}

{{/*
 Service
 */}}
{{- define "monom-react.service-type" -}}
{{- if .Values.ingress.enabled -}}
NodePort
{{- else -}}
{{ .Values.service.type }}
{{- end }}
{{- end }}

{{/*
 Ingress
 */}}
{{- define "monom-react.ingress-annotations" -}}
{{- if .Values.ingress.annotations -}}
{{- .Values.ingress.annotations -}}
{{- else -}}
kubernetes.io/ingress.class: gce
networking.gke.io/v1beta1.FrontendConfig: {{ include "monom-react.name" . }}-ingress-security-config
kubernetes.io/ingress.global-static-ip-name: {{ include "monom-react.name" . }}
networking.gke.io/managed-certificates: {{ include "monom-react.name" . }}
{{- end }}
{{- end }}
