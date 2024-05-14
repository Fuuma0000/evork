package api

import (
	"database/sql"
	"net/http"

	"github.com/gin-gonic/gin"
)

type getAffiliationRequest struct {
	ID int64 `uri:"id" binding:"required,min=1"`
}

func (server *Server) getAffiliation(ctx *gin.Context) {
	var req getAffiliationRequest
	if err := ctx.ShouldBindUri(&req); err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	affiliation, err := server.queries.GetAffiliationById(ctx, uint32(req.ID))
	if err != nil {
		if err == sql.ErrNoRows {
			ctx.JSON(http.StatusNotFound, errorResponse(err))
			return
		}

		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, affiliation)
}
