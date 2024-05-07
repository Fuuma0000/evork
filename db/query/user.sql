-- name: GetUser :one
SELECT * FROM user
WHERE id = ? LIMIT 1;

-- name: ListUsers :many
SELECT * FROM user;

-- name: CreateUser :execresult
INSERT INTO user (
  firebase_uid, email, username, affiliation_id, enrollment_year, graduation_year, is_job_hunt_completed, self_introduction, icon_url, show_profile_in_public_event, show_profile_in_shared_url
) VALUES (
  $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
);

-- name: DeleteUser :exec
DELETE FROM user
WHERE id = ?;
