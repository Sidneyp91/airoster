# Airoster — Technical Overview

Airoster is built with an offline-first, scalable, and maintainable architecture. The system is designed to provide fast UI, reliable data handling, and long-term flexibility.

---

## Core Principles

- Offline-first operation
- Local database as single source of truth
- Clear separation of concerns
- Eventual consistency with background sync
- Scalable and testable architecture

---

## Architecture Overview

UI → State Management → Repositories → Local Database → Sync Queue → Remote API

The UI always reads from the local database. Network communication happens in the background.

---

## Local Database (Drift)

Drift is used as the local SQLite database.

- Strong typing and compile-time validation
- High performance for local reads and writes
- Reliable offline persistence

---

## Offline Sync System

User actions are written locally first and added to a sync queue. The sync service processes queued actions when connectivity is available.

- Supports offline usage
- Enables optimistic UI updates
- Handles retries automatically

---

## Connectivity Awareness

A connectivity service tracks network state and informs the sync and networking layers.

- Avoids unnecessary network calls
- Triggers background sync on reconnect
- Improves reliability in poor network conditions

---

## Data Models (Freezed)

Freezed is used for domain and API models. Drift entities are used for persistence and are kept separate.

- Prevents tight coupling to database schema
- Supports API evolution
- Allows local-only fields and sync metadata

---

## Repository Pattern

Repositories coordinate local storage, network access, sync logic, and connectivity state.

- Centralized business logic
- Enables offline-first behavior
- Keeps UI independent of API details

