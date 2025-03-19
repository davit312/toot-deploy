{{/* Application name */}}
{{- define "mastodon.name" -}}
    {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "mastodon.env.production" -}}
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
  value: {{ include "postgresql.v1.primary.svc.headless" . }}
- name: DB_PORT
  value: 5432
{{- end }}
