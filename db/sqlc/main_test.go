package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	_ "github.com/go-sql-driver/mysql"
)

var testQueries *Queries
var testDB *sql.DB

func TestMain(m *testing.M) {
	dsn := "root:password@tcp(localhost:3306)/evork?parseTime=true"
	testDB, err := sql.Open("mysql", dsn)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testQueries = New(testDB)

	os.Exit(m.Run())
}
