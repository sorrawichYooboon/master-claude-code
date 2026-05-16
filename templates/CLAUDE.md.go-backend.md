# Go Backend CLAUDE.md Template

# Copy this to: /your-go-project/CLAUDE.md
# Designed for Go backend services with REST APIs, PostgreSQL, and Docker.

## Build & Test

```bash
make build              # compile
make test               # all tests
make test-unit          # unit tests only (fast, no DB)
make test-integration   # integration tests (requires running Docker)
make lint               # golangci-lint

# Single test
go test ./internal/auth/... -run TestTokenExpiry -v

# With race detector
go test -race ./...
```

## Package structure

- `cmd/<service>/` — `main.go` only, no business logic
- `internal/` — all business logic (not importable outside module)
- `internal/handlers/` — HTTP handlers, one file per resource
- `internal/store/` — database layer, no HTTP logic
- `internal/service/` — business logic layer between handlers and store
- `pkg/` — public packages, stable API

## Error handling

Always wrap with context:
```go
return fmt.Errorf("store.GetUser: %w", err)
```

Never swallow errors: no `_ = someFunc()`, no empty catch blocks.

## Database

- Library: sqlx (not GORM)
- Migrations: `make migrate-up` / `make migrate-down`
- Migration files: `migrations/YYYYMMDDHHMMSS_description.sql`
- Always write a down migration
- New columns: must have NOT NULL + default, or be nullable with explicit reason

## HTTP conventions

- URL paths: kebab-case (`/user-accounts` not `/userAccounts`)
- Version prefix: `/v1/`, `/v2/`
- Error format: `{"error": "message", "code": "SCREAMING_SNAKE"}`
- List endpoints: always paginated with `cursor` + `limit`

## Docker

```bash
docker compose up -d     # start all services
docker compose down      # stop all services
docker compose logs -f   # follow logs
```

## Environment

- Config: environment variables only, loaded via `internal/config/config.go`
- No `.env` files in production — use secrets manager
- Local development: copy `.env.example` to `.env`
