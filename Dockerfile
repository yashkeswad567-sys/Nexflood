# Multi-stage Dockerfile for Indore Flood Intelligence (IFI)

FROM node:20-alpine AS frontend-builder
WORKDIR /app/frontend
COPY package.json ./
RUN npm install --legacy-peer-deps
COPY . .
RUN npm run build

FROM python:3.11-slim AS runtime
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    sqlite3 curl && \
    rm -rf /var/lib/apt/lists/*

COPY backend/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt || true

COPY . .
COPY --from=frontend-builder /app/frontend/dist ./frontend/dist

ENV PYTHONPATH=/app
ENV PORT=8000

EXPOSE 8000 5173

CMD ["python", "backend/app/server.py", "8000"]
