# Example: Subdirectory CLAUDE.md for a Go backend

# This file lives at: backend/CLAUDE.md
# It only loads when Claude is working inside the backend/ directory.

## Build & Test

```bash
make build          # compile
make test           # run all tests
make test-unit      # unit tests only (fast)
make lint           # golangci-lint
```

Run a single test:
```bash
go test ./internal/auth/... -run TestTokenExpiry -v
```

## Package conventions

- `cmd/` — main packages only, no business logic
- `internal/` — all business logic, not importable outside this module
- `internal/handlers/` — one file per resource (users.go, orders.go)
- `internal/store/` — database layer only, no HTTP logic
- `pkg/` — public API, must be stable across versions

## Error handling

Always wrap errors with context:
```go
return fmt.Errorf("store.GetUser: %w", err)
```

Never swallow errors silently. No `_ = someFunc()`.

## Database

- ORM: sqlx (not GORM)
- Migrations: `make migrate-up` and `make migrate-down`
- Migration files: `migrations/YYYYMMDDHHMMSS_description.sql`
- Always write a down migration
