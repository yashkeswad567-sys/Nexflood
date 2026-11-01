# AGENTS.md — Autonomous Engineering Team Roster & Operating Directives

## 1. Project Overview
- **System**: Indore Flood Intelligence (IFI) — AI-Powered Urban Drainage & Flash Flood Predictive Management Platform
- **Scope**: Production-grade full-stack SaaS with 4 role-based dashboards, physics-informed flood prediction, flood-aware routing engine, 3D digital twin, IoT telemetry ingestion, incident & dispatch lifecycle, and audit trail.
- **Geographic Context**: Indore Municipal Corporation (IMC), Madhya Pradesh, India (22.7196° N, 75.8577° E). Drainage basins: Kahn River (Khan Nadi), Saraswati River, Bilawali Lake, Pipliyapala Lake.

---

## 2. Autonomous Agent Roles & Responsibilities

| Agent Role | Scope & Specialization | Key Deliverables |
|---|---|---|
| **Principal Software Architect** | System topology, modular service interfaces, high availability, role-based access control (RBAC), end-to-end data contracts. | `docs/ARCHITECTURE.md`, `docs/API_CONTRACTS.md`, system state management |
| **Full-Stack Engineer** | React 18, Vite, TypeScript, Tailwind CSS, REST/WebSocket API integration, 4 role-based dashboards, authentication, responsive design. | Enterprise UI components, Citizen/Municipal/Engineer/Firefighter dashboards |
| **AI & Hydrology Engineer** | Physics-informed rainfall-runoff modeling (Rational Method + SCS curve numbers), 1h/2h/3h horizon hazard forecasting, confidence intervals, ML training pipeline. | `backend/app/flood_engine.py`, `backend/ml/train.py`, evaluation metrics |
| **GIS & Routing Developer** | OpenStreetMap integration, Indore catchment zones, topological graph routing with dynamic water depth penalties, alternative paths. | `backend/app/routing_engine.py`, Leaflet map views, road blockage engine |
| **3D Digital Twin Specialist** | 3D WebGL / CesiumJS-compatible terrain & urban drainage visualization, scenario scrubber, camera presets, flood level extrusions. | `IndoreDigitalTwin3D.tsx`, scenario comparison slider |
| **IoT & DevOps Engineer** | ESP32 telemetry ingestion endpoint, timestamp validation, sensor heartbeat monitor, pump automation recommendations, Docker Compose, Windows startup scripts. | `iot_simulator.py`, `run-dev.ps1`, `docker-compose.yml` |
| **QA & Verification Lead** | Automated testing (unit, integration, routing, prediction, incident lifecycle), end-to-end demo workflow verification, bug triage. | `backend/tests/`, Vitest test cases, `PROGRESS.md` |

---

## 3. Engineering Operating Standards
1. **Safety First**: Emergency routing must never describe experimental paths as guaranteed safe. Always provide clear disclaimers.
2. **Deterministic Fallbacks**: Zero external network reliance during offline local execution. The demo dataset must be geographically authentic to Indore landmarks (Rajwada, Vijay Nagar, Palasia, Bhanwarkuan, etc.) without fabricating municipal records.
3. **Data Consistency**: A single unified database and reactive state layer connects all four dashboards. An SOS submitted by a Citizen must instantly notify the Municipal and Firefighter queues.
4. **No Autonomous Equipment Control**: Pump recommendations are decision-support advisories with human-in-the-loop verification; no autonomous mechanical actuator commands without municipal sign-off.
