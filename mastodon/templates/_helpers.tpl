{{/* Application name */}}
{{- define "mastodon.name" -}}
    {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "mastodon.environment" -}}
- name: LOCAL_DOMAIN
  value: {{ .Values.localDomain }}
- name: SINGLE_USER_MODE
  value: "false"
- name: ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.existingEncriptionSecretName }}
      key: ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY
- name: OTP_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ .Values.existingEncriptionSecretName }}
      key: OTP_SECRET
- name: SECRET_KEY_BASE
  valueFrom:
    secretKeyRef:
      name: {{ .Values.existingEncriptionSecretName }}
      key: SECRET_KEY_BASE
- name: VAPID_PRIVATE_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.existingEncriptionSecretName }}
      key: VAPID_PRIVATE_KEY
- name: VAPID_PUBLIC_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.existingEncriptionSecretName }}
      key: VAPID_PUBLIC_KEY
- name: ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.existingEncriptionSecretName }}
      key: ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY
- name: ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT
  valueFrom:
    secretKeyRef:
      name: {{ .Values.existingEncriptionSecretName }}
      key: ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT
- name: DB_HOST
  value: {{ include "mastodon.postgresql.fullname" . }}
- name: DB_PORT
  value: 5432
- name: DB_NAME
  value: {{ .Values.postgresql.auth.database }}
- name: DB_USER
  value: {{ .Values.postgresql.auth.username }}
- name: DB_PASS
  valueFrom:
    secretKeyRef:
      name: {{ .Values.postgresql.auth.existingSecret }}
      key: {{ .Values.postgresql.auth.secretKeys.userPasswordKey }}
- name: REDIS_HOST
  value: {{ include "mastodon.redis.fullname" . }}
- name: REDIS_PORT
  value: "6379"
- name: REDIS_PASSWORD
  value: ""
- name: SMTP_SERVER
  value: "smtp.mailgun.org"
- name: SMTP_PORT
  value: "587"
- name: SMTP_LOGIN
  value: ""
- name: SMTP_PASSWORD
  value: ""
- name: SMTP_AUTH_METHOD
  value: "plain"
- name: SMTP_OPENSSL_VERIFY_MODE
  value: "none"
- name: SMTP_ENABLE_STARTTLS:
  value: "auto"
- name: SMTP_FROM_ADDRESS
  value: "Mastodon <notifications@localhost>"
- name: UPDATE_CHECK_URL
  value: ""
{{- end }}

{{- define "mastodon.redis.fullname" -}}
{{- printf "%s-%s" .Release.Name "redis" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mastodon.postgresql.fullname" -}}
{{- printf "%s-%s" .Release.Name "postgresql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}