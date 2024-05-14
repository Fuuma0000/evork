package api

import (
	db "github.com/Fuuma0000/evork/db/sqlc"
	"github.com/Fuuma0000/evork/firebase"
	"github.com/gin-gonic/gin"
)

type Server struct {
	router   *gin.Engine
	queries  *db.Queries
	firebase *firebase.App
}

func NewServer(queries *db.Queries, firebase *firebase.App) *Server {
	router := gin.Default()
	server := &Server{router: router, queries: queries, firebase: firebase}

	router.GET("/affiliation/:id", server.getAffiliation)
	router.POST("/auth/login", server.createUser)

	server.router = router
	return server
}

func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}
