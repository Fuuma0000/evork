package main

import (
	"database/sql"
	"fmt"
	"log"

	"github.com/Fuuma0000/evork/api"
	db "github.com/Fuuma0000/evork/db/sqlc"
	"github.com/Fuuma0000/evork/firebase"
	_ "github.com/go-sql-driver/mysql"
)

func main() {
	fmt.Println("Hello, World!")

	firebase, err := firebase.NewApp()

	dsn := "root:password@tcp(localhost:3306)/evork?parseTime=true"
	testDB, err := sql.Open("mysql", dsn)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	queries := db.New(testDB)

	server := api.NewServer(queries, firebase)

	err = server.Start("0.0.0.0:8080")
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}
