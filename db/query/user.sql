-- name: GetUser :one
SELECT
  *
FROM
  users
WHERE
  id = ?
LIMIT
  1;

-- name: ListUsers :many
SELECT
  *
FROM
  users;

-- name: CreateUser :execresult
INSERT INTO
  users (
    firebase_uid,
    email,
    username,
    affiliation_id,
    enrollment_year,
    graduation_year,
    is_job_hunt_completed,
    self_introduction,
    icon_url,
    show_profile_in_public_event,
    show_profile_in_shared_url
  )
VALUES
  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

-- name: DeleteUser :exec
DELETE FROM
  users
WHERE
  id = ?;

-- name: GetUserByEmail :one
SELECT
  *
FROM
  users
WHERE
  email = ?
LIMIT
  1;
