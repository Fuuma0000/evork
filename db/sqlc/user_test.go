package db

import (
	"context"
	"testing"

	"github.com/Fuuma0000/evork/db/util"
	"github.com/stretchr/testify/require"
)

func createRandomUser(t *testing.T) User {
	enrollment_year := util.RandomYear()
	arg := CreateUserParams{
		FirebaseUid:        util.RandomUUID(),
		Email:              util.RandomEmail(),
		Username:           util.RandomUserName(),
		AffiliationID:      uint32(util.RandomInt(1, 10)),
		EnrollmentYear:     enrollment_year,
		GraduationYear:     enrollment_year + 4,
		IsJobHuntCompleted: util.RandomBoolean(),
		SelfIntroduction:   util.RandomString(10),
	}

	// ユーザーを作成
	_, err := testQueries.CreateUser(context.Background(), arg)
	require.NoError(t, err)

	// 作成したユーザーを取得
	user, err := testQueries.GetUserByEmail(context.Background(), arg.Email)
	require.NoError(t, err)
	require.NotEmpty(t, user)

	require.Equal(t, arg.FirebaseUid, user.FirebaseUid)
	require.Equal(t, arg.Email, user.Email)
	require.Equal(t, arg.Username, user.Username)

	require.NotZero(t, user.ID)
	require.NotZero(t, user.CreatedAt)

	return user
}

func TestCreateUser(t *testing.T) {
	// 所属を作成
	affiliation := createRandomAffiliation(t)
	require.NotEmpty(t, affiliation)

	enrollment_year := util.RandomYear()
	arg := CreateUserParams{
		FirebaseUid:        util.RandomUUID(),
		Email:              util.RandomEmail(),
		Username:           util.RandomUserName(),
		AffiliationID:      affiliation.ID,
		EnrollmentYear:     enrollment_year,
		GraduationYear:     enrollment_year + 4,
		IsJobHuntCompleted: util.RandomBoolean(),
		SelfIntroduction:   util.RandomString(10),
	}

	// ユーザーを作成
	_, err := testQueries.CreateUser(context.Background(), arg)
	require.NoError(t, err)

	// 作成したユーザーを取得
	user, err := testQueries.GetUserByEmail(context.Background(), arg.Email)
	require.NoError(t, err)
	require.NotEmpty(t, user)

	require.Equal(t, arg.FirebaseUid, user.FirebaseUid)
	require.Equal(t, arg.Email, user.Email)
	require.Equal(t, arg.Username, user.Username)

	require.NotZero(t, user.ID)

}
