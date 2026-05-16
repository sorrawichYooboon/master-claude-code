---
name: api-conventions
description: REST API design conventions for this project. Use when creating new
             endpoints, route handlers, HTTP middleware, or any HTTP-related code.
             Also use when reviewing or modifying existing API handlers.
---

# API Conventions

## URL structure

- Paths: kebab-case only → `/user-accounts` not `/userAccounts` not `/user_accounts`
- Version prefix on all routes: `/v1/`, `/v2/`
- Resources are plural nouns: `/v1/users`, `/v1/orders`
- Nested only one level deep: `/v1/users/{id}/orders` is ok, deeper is not

## Error responses

All errors use this exact format:
```json
{
  "error": "Human-readable message for display",
  "code": "SCREAMING_SNAKE_CASE_CODE"
}
```

HTTP status codes:
- 400 → validation errors (code: `INVALID_INPUT`)
- 401 → not authenticated (code: `UNAUTHENTICATED`)
- 403 → authenticated but not allowed (code: `FORBIDDEN`)
- 404 → not found (code: `NOT_FOUND`)
- 409 → conflict, already exists (code: `ALREADY_EXISTS`)
- 500 → internal error (code: `INTERNAL_ERROR`)

## Pagination

All list endpoints require pagination:
```json
{
  "data": [...],
  "pagination": {
    "cursor": "next_cursor_value",
    "hasMore": true,
    "total": 142
  }
}
```

Query params: `?cursor=<value>&limit=<int>` (default limit: 20, max: 100)

## Handler structure

```go
// Context is always the first parameter
func (h *UserHandler) List(ctx context.Context, w http.ResponseWriter, r *http.Request) {
    // 1. Parse and validate input
    // 2. Call store layer
    // 3. Return JSON
}
```

Handler files live in `internal/handlers/`, one file per resource.
