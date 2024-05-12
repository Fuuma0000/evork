# 所属

-- name: CreateAffiliation :execresult
INSERT INTO
    affiliations (name)
VALUES
    (?);

-- name: GetAffiliationById :one
SELECT
    id,
    name
FROM
    affiliations
WHERE
    id = ?;

-- name: ListAffiliations :many
SELECT
    id,
    name
FROM
    affiliations;
