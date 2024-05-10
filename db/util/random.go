package util

import (
	"database/sql"
	"math/rand"
	"strings"
	"time"
)

const alphabet = "abcdefghijklmnopqrstuvwxyz"

func init() {
	// Seed the random number generator with the current time
	rand.Seed(time.Now().UnixNano())
}

// RandomInt generates a random integer between min and max
func RandomInt(min, max int64) int64 {
	return min + rand.Int63n(max-min+1)
}

// n以下のランダムな文字列を生成する
func RandomString(n int) string {
	var sb strings.Builder
	k := len(alphabet)

	for i := 0; i < n; i++ {
		c := alphabet[rand.Intn(k)]
		sb.WriteByte(c)
	}

	return sb.String()
}

// ランダムなsql.NullInt32を生成する
func RandomNullInt32InRange(min, max int64) sql.NullInt32 {
	value := min + int64(rand.Int31n(int32(max-min+1)))
	return sql.NullInt32{Int32: int32(value), Valid: true}
}

// 2000年から2028年の間のランダムなint32を生成する
func RandomYear() int32 {
	return 2000 + rand.Int31n(29)
}

// ランダムなboolean値を生成する
func RandomBoolean() bool {
	return rand.Intn(2) == 1
}

// ランダムなUUIDを生成する
func RandomUUID() string {
	return RandomString(32)
}

// ランダムなユーザ名を生成する
func RandomUserName() string {
	return RandomString(6)
}

// ランダムなメールアドレスを生成する
func RandomEmail() string {
	return RandomString(6) + "@gmail.com"
}

// ランダムな自己紹介を生成する
func RandomBio() string {
	return RandomString(32)
}

// ランダムなURLを生成する
func RandomURL() string {
	return "https://" + RandomString(6) + ".com"
}
