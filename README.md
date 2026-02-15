# AWS + EKS + Temporal + Spring Boot — Appointment & Notification Scheduler (Production Starter)

This repo is a **production-oriented reference implementation** of a multi-tenant appointment booking platform for doctor offices with **durable scheduled notifications** powered by **Temporal**.

## What you get
- ✅ Transactional appointment booking with **double-booking protection**
- ✅ **Idempotent** APIs (Idempotency-Key header)
- ✅ **Outbox pattern** for reliable event publishing
- ✅ Temporal **workflow per appointment** (confirmation + reminders + follow-up)
- ✅ Kubernetes/Helm deployment scaffolding for **AWS EKS**
- ✅ Terraform scaffolding for AWS (VPC, EKS, Aurora Postgres, Redis, SQS/DLQ, ECR, KMS, WAF placeholders)
- ✅ Secure-by-default container + K8s settings (non-root, readonly FS, IRSA-ready)
- ✅ CI pipeline skeleton (build, test, scan placeholders, image build)

> Date generated: 2026-02-15

---

## High-level architecture
- **appointments-service** (Spring Boot): booking/reschedule/cancel; writes DB + outbox in one transaction; starts/updates Temporal workflows.
- **notifications-service** (Spring Boot + Temporal worker): runs workflows and activities to send email/SMS/push.
- **infra**:
  - Postgres (Aurora PostgreSQL recommended)
  - Redis (ElastiCache) for caching (optional)
  - SQS/DLQ for async fanout (optional; outbox publisher supports both “direct” and “queue” modes)
  - Temporal cluster (run on EKS via Helm or managed)

---

## Local quickstart (Docker Compose)
### 1) Start dependencies
```bash
cd local
docker compose up -d
```

Starts:
- Postgres
- Temporal (auto-setup) + UI

### 2) Run services
```bash
# terminal 1
cd services/appointments-service
./gradlew bootRun

# terminal 2
cd services/notifications-service
./gradlew bootRun
```

### 3) Book an appointment
```bash
curl -X POST http://localhost:8080/api/v1/appointments \
  -H 'Content-Type: application/json' \
  -H 'Idempotency-Key: demo-123' \
  -d '{
    "tenantId":"t-1",
    "clinicId":"c-1",
    "providerId":"p-1",
    "patientId":"u-1",
    "startTime":"2026-02-16T14:00:00Z",
    "endTime":"2026-02-16T14:30:00Z",
    "timeZone":"America/New_York",
    "contact":{"email":"patient@example.com","phone":"+15555550123"}
  }'
```

Open Temporal UI: http://localhost:8088

---

## Deploy to AWS EKS (outline)
1. `infra/terraform`: provision AWS foundation + EKS + databases.
2. Install controllers:
   - AWS Load Balancer Controller
   - ExternalDNS (optional)
   - cert-manager (optional)
3. Deploy Temporal to EKS (helm): see `k8s/temporal/`
4. Deploy services (helm): `helm/`

> Note: Terraform and Helm are provided as *safe scaffolding*. You should wire IAM roles, domain, and environment-specific values before production.

---

## Security posture (baseline)
- TLS everywhere (terminate at ALB + re-encrypt optional)
- Secrets in AWS Secrets Manager (IRSA access)
- KMS encryption for data at rest
- Least privilege IAM (IRSA)
- Kubernetes: non-root, no privilege escalation, drop capabilities, readonly root FS
- Audit log table and request tracing IDs

---

## Repo map
- `services/appointments-service` — booking API + outbox + Temporal signals
- `services/notifications-service` — Temporal worker + delivery adapters
- `local/` — docker compose for local dev
- `infra/terraform/` — AWS scaffolding
- `helm/` — Helm charts for services
- `k8s/temporal/` — Temporal Helm values + notes
- `.github/workflows/` — CI skeleton

---

## Next hardening steps for real production
- Enable mTLS service mesh (Istio/Linkerd) if required
- Add WAF rules (AWS Managed Rules) and bot protection
- Add Kyverno/Gatekeeper policies (signed images, required limits, no privileged pods)
- Add full audit exports to S3 with Object Lock (WORM) if compliance requires
- Multi-region DR plan (Aurora Global Database or cross-region backups)

