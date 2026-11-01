# INDORE FLOOD INTELLIGENCE (IFI)
### AI-Powered Urban Drainage & Flash Flood Predictive Management System
**Indore Municipal Corporation (IMC) — 24-Hour Hackathon Production Deliverable**

---

## 1. Executive Summary

**Indore Flood Intelligence (IFI)** is a full-stack, enterprise-grade SaaS application designed to predict, monitor, and mitigate urban flash flooding across the Indore metropolitan basin (22.7196° N, 75.8577° E).

### Key Technological Pillars:
1. **Physics-Informed AI Hydrology**: Combines the Rational Method ($Q_p = 0.278 \cdot C \cdot I \cdot A$) and SCS Curve Numbers for Indore's black cotton soils (Vertisols) to compute multi-horizon flood hazard depths (1h, 2h, and 3h horizons with 90% confidence intervals).
2. **Topological Flood-Aware Road Routing**: Graph routing that applies quadratic flood hazard impedance penalties to avoid inundated underpasses and calculate safe alternative evacuation routes.
3. **Interactive 3D Digital Twin**: WebGL Cesium-compatible digital twin visualizing the 553m AMSL Indore depression, riverbed channels (Kahn River & Saraswati River), dynamic floodwater rise, and scenario mitigation comparisons.
4. **IoT Telemetry & Edge Simulator**: ESP32 hardware telemetry endpoint with range validation, stale sensor monitoring, and intelligent pump operation recommendations with engineering rationales.
5. **Multi-Agency Unified Command**: 4 specialized role-based dashboards (Citizen, Municipal Official, Field Drainage Engineer, Fire & Emergency Rescue) linked through a single shared data source.

---

## 2. Role-Based Portals & Quick Demo Credentials

| Role | Target Persona | Key Capabilities | Demo Access |
|---|---|---|---|
| **Citizen** | Indore Resident (`citizen@indore.gov.in`) | Risk map, rainfall telemetry, 1h-3h forecasts, safe navigation route, emergency SOS distress beacon, shelters | One-click Demo Pill / Password: `citizen123` |
| **Municipal Official** | Disaster Management Cell (`municipal@indore.gov.in`) | City command overview, Recharts hydrographs, AI pump advisories, incident verification, firefighter dispatch, scenario simulator, broadcast alerts | One-click Demo Pill / Password: `admin123` |
| **Field Engineer** | Drainage & Sewerage Tech (`engineer@indore.gov.in`) | Work orders, asset inspection sign-offs, desilting verification, IoT sensor diagnostics & calibration, fault ticketing | One-click Demo Pill / Password: `engineer123` |
| **Firefighter** | Rescue Commander (`firefighter@indore.gov.in`) | Priority SOS queue, flood-aware response navigation, boat deployment, rescue status lifecycle (Dispatched &rarr; On Scene &rarr; Evacuating &rarr; Completed) | One-click Demo Pill / Password: `rescue123` |

---

## 3. Technology Stack

- **Frontend**:
  - React 18, TypeScript 5.8, Vite 8.3
  - Tailwind CSS v4 with `@tailwindcss/vite`
  - React Router v7
  - Lucide React icons
  - Recharts (Interactive area & bar charts)
  - Leaflet 1.9 (OpenStreetMap GIS with custom zone overlays & markers)
  - Interactive HTML5 Canvas / WebGL 3D Digital Twin
- **Backend**:
  - Python 3.11+ / 3.14
  - SQLite with thread-safe `RLock` & PostGIS spatial abstraction layer
  - Multi-threaded REST & SSE server (`backend/app/server.py`)
  - FastAPI production app (`backend/app/main_fastapi.py`)
  - HMAC-SHA256 JWT authentication & 4-tier server-side RBAC
- **AI & Geospatial Engines**:
  - Physics-informed rainfall-runoff baseline (`backend/app/flood_engine.py`)
  - Reproducible ML training pipeline (`backend/ml/train.py`, `evaluate.py`)
  - Flood-aware graph routing engine (`backend/app/routing_engine.py`)
  - ESP32 IoT telemetry simulator & pump rule advisor (`backend/app/iot_simulator.py`)

---

## 4. Local Execution Instructions (Windows PowerShell)

### Prerequisites:
- Node.js 18+ (tested on Node v26)
- Python 3.11+ (tested on Python 3.14.5)

### Step 1: Open Terminal in Workspace Directory
```powershell
cd C:\Users\Yash\.gemini\antigravity\scratch\indore-flood-intelligence
```

### Step 2: Run Automated Master Test Suite
```powershell
$env:PYTHONPATH="."
python backend/tests/run_all_tests.py
```
*Executes all 17 unit, integration, hydrological, and end-to-end workflow tests.*

### Step 3: Start the Backend Server (Terminal 1)
```powershell
.\start-backend.ps1
```
*Or manually: `python backend/app/server.py 8000`*
- REST API: `http://localhost:8000/api/v1`
- Health check: `http://localhost:8000/health`

### Step 4: Start the Frontend Application (Terminal 2)
```powershell
.\start-frontend.ps1
```
*Or manually: `npm run dev`*
- Open your browser at: `http://localhost:5173`

---

## 5. End-to-End Hackathon Demo Verification (18 Steps)

The application demonstrates this synchronized workflow across all dashboards:
1. **Municipal Dashboard**: Open `http://localhost:5173/dashboard/municipal`.
2. **Select Heavy-Rainfall Scenario**: Choose `Severe Cloudburst (85 mm/h)`.
3. **Run Prediction**: Click `Run Hydraulic Prediction`.
4. **Update Risk Zones**: Observe zone hazard levels update to `CRITICAL` (Red) and hydrograph charts spike.
5. **Show Affected Roads**: Check `impassable road segments` flagged in Rajwada and Sarafa.
6. **Calculate Safe Route**: Observe route engine calculating an impedance-weighted path avoiding submerged underpasses.
7. **Citizen Dashboard**: Switch role to `Citizen` (top-right pill) or visit `http://localhost:5173/dashboard/citizen`.
8. **Submit SOS**: Fill the distress beacon (e.g. 3 stranded, medical need) and click `TRANSMIT RESCUE BEACON NOW`.
9. **Display SOS in Municipal**: Switch to `Municipal Command` and verify the incident appears in the queue.
10. **Assign Firefighter**: Click `Dispatch Unit` and assign `Palasia Fire Rescue Unit 2`.
11. **Firefighter Dashboard**: Switch to `Firefighter` (`http://localhost:5173/dashboard/firefighter`).
12. **Update Status**: Click `On Scene` &rarr; `Evacuating` &rarr; `Completed`.
13. **Citizen Real-Time Feedback**: Switch back to Citizen to see the updated status immediately.
14. **Field Engineer Dashboard**: Switch to `Field Engineer` (`http://localhost:5173/dashboard/field-engineer`).
15. **Inspect Drainage Asset**: Select `Kahn Outfall Heavy Storm Pump #1`, desilt to 5%, and click `Sign Off Work Order`.
16. **3D Digital Twin**: Navigate to `3D Digital Twin` (`http://localhost:5173/digital-twin`).
17. **Compare Scenarios**: Toggle between `Pumps Active (Mitigated)` vs `Zero Pumps (Unmitigated)`.
18. **Simulated Sensor Readings & Pump Advisories**: Review live sensor telemetry and accept AI pump recommendations.

---

## 6. Project Architecture & File Tree

```
indore-flood-intelligence/
├── AGENTS.md                          # Autonomous agent roles & operating directives
├── PROGRESS.md                        # Master progress tracker
├── README.md                          # Documentation & execution instructions
├── .env.example                       # Environment configuration template
├── package.json                       # Frontend dependencies & scripts
├── vite.config.ts                     # Vite build configuration with Tailwind v4
├── tsconfig.json                      # TypeScript configuration
├── Dockerfile                         # Container build recipe
├── docker-compose.yml                 # Multi-container service orchestrator
├── run-dev.ps1                        # Master local PowerShell launcher
├── start-backend.ps1                  # Backend launcher script
├── start-frontend.ps1                 # Frontend launcher script
├── docs/
│   ├── ARCHITECTURE.md                # System topology & data flow
│   ├── API_CONTRACTS.md               # Versioned REST contracts
│   ├── DATABASE_DESIGN.md             # Relational & spatial schema
│   ├── AI_PREDICTION_PLAN.md          # Rational Method & SCS-CN baseline
│   └── IMPLEMENTATION_PLAN.md         # Phased execution checklist
├── backend/
│   ├── indore_flood.db                # Persistent SQLite database
│   ├── requirements.txt               # Backend dependencies
│   ├── app/
│   │   ├── database.py                # Database connection & schema tables
│   │   ├── seed_data.py               # Authentic Indore geospatial seeds
│   │   ├── auth.py                    # JWT token issuance & RBAC guard
│   │   ├── flood_engine.py            # Physics-informed rainfall-runoff model
│   │   ├── routing_engine.py          # Topological Dijkstra route engine
│   │   ├── iot_simulator.py           # ESP32 validator & pump advisory rules
│   │   ├── server.py                  # Multi-threaded REST & SSE server
│   │   └── main_fastapi.py            # FastAPI production application
│   ├── ml/
│   │   ├── dataset_generator.py       # Synthetic hydrology generator
│   │   ├── train.py                   # Reproducible ML training pipeline
│   │   ├── evaluate.py                # Benchmark evaluation script
│   │   └── model_metadata.json        # Exported metrics (R²=0.87, F1=0.94)
│   └── tests/
│       ├── test_flood_engine.py       # Hydrological calculation tests
│       ├── test_routing_engine.py     # Graph routing & disclaimer tests
│       ├── test_iot_telemetry.py      # Telemetry bounds & pump tests
│       ├── test_incidents.py          # SOS lifecycle & assignment tests
│       ├── test_auth_rbac.py          # JWT & RBAC permission tests
│       ├── test_e2e_workflow.py       # 18-step master workflow test
│       └── run_all_tests.py           # Master test discoverer & runner
└── src/
    ├── main.tsx                       # React application bootstrap
    ├── App.tsx                        # Master routing & layout wrapper
    ├── index.css                      # Tailwind v4 directives & animations
    ├── types/
    │   └── index.ts                   # Full TypeScript definitions
    ├── context/
    │   ├── AuthContext.tsx            # Session, JWT, and demo role switcher
    │   ├── ThemeContext.tsx           # Dark / Light mode manager
    │   └── FloodDataContext.tsx      # Live shared state & 8s auto-poll
    ├── services/
    │   ├── api.ts                     # REST client with offline fallback
    │   └── demoData.ts                # Geographically authentic Indore data
    ├── components/
    │   ├── layout/
    │   │   ├── Navbar.tsx             # Brand header, hazard badge & switcher
    │   │   └── Sidebar.tsx            # Responsive role-specific navigation
    │   ├── map/
    │   │   └── IndoreMapView.tsx      # Leaflet OpenStreetMap with layer toggles
    │   └── 3d/
    │       └── IndoreDigitalTwin3D.tsx# 3D Canvas / WebGL Digital Twin
    ├── pages/
    │   ├── LandingPage.tsx            # Public SaaS landing page
    │   ├── LoginPage.tsx              # Login & One-Click Demo access
    │   ├── CitizenDashboard.tsx       # Citizen portal with SOS & routes
    │   ├── MunicipalDashboard.tsx     # Command center with AI pump recs
    │   ├── FieldEngineerDashboard.tsx # Work orders & sensor diagnostics
    │   ├── FirefighterDashboard.tsx   # Priority dispatch & rescue route
    │   ├── DigitalTwinPage.tsx        # 3D twin full view
    │   ├── RoutePlannerPage.tsx       # Dedicated route engine page
    │   ├── SettingsPage.tsx           # Preferences & diagnostics
    │   └── UserProfilePage.tsx        # User profile & organization
    └── tests/
        └── app.test.ts                # Vitest architecture test suite
```
