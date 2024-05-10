package db

import (
	"context"
	"testing"

	"github.com/Fuuma0000/evork/db/util"
	"github.com/stretchr/testify/require"
)

func createRandomAffiliation(t *testing.T) GetAffiliationByIdRow {
	name := util.RandomString(10)
	result, err := testQueries.CreateAffiliation(context.Background(), name)
	require.NoError(t, err)

	lastInsertIDInt64, err := result.LastInsertId()
	require.NoError(t, err)

	lastInsertID := uint32(lastInsertIDInt64)

	affiliation, err := testQueries.GetAffiliationById(context.Background(), lastInsertID)
	require.NoError(t, err)

	require.Equal(t, name, affiliation.Name)
	require.Equal(t, lastInsertID, affiliation.ID)

	return affiliation
}

func TestCreateRandomAffiliation(t *testing.T) {
	name := util.RandomString(10)
	result, err := testQueries.CreateAffiliation(context.Background(), name)
	require.NoError(t, err)

	lastInsertIDInt64, err := result.LastInsertId()
	require.NoError(t, err)

	lastInsertID := uint32(lastInsertIDInt64)

	affiliation, err := testQueries.GetAffiliationById(context.Background(), lastInsertID)
	require.NoError(t, err)

	require.Equal(t, name, affiliation.Name)
	require.Equal(t, lastInsertID, affiliation.ID)
}

func TestGetAffiliationById(t *testing.T) {
	affiliation1 := createRandomAffiliation(t)
	affiliation2, err := testQueries.GetAffiliationById(context.Background(), affiliation1.ID)

	require.NoError(t, err)
	require.Equal(t, affiliation1, affiliation2)
}
