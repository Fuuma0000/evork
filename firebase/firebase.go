package firebase

import (
	"context"
	"fmt"
	"log"

	firebase "firebase.google.com/go/v4"
	"firebase.google.com/go/v4/auth"
	"google.golang.org/api/option"
)

type AppInterface interface {
	CreateUser(ctx context.Context, params *auth.UserToCreate) (*auth.UserRecord, error)
}

type App struct {
	authClient *auth.Client
}

func NewApp() (*App, error) {
	opt := option.WithCredentialsFile("serviceAccountKey.json")
	firebaseApp, err := firebase.NewApp(context.Background(), nil, opt)
	if err != nil {
		log.Fatalf("error initializing firebase app: %v\n", err)
	}

	authClient, err := firebaseApp.Auth(context.Background())
	if err != nil {
		log.Fatalf("error getting Auth client: %v\n", err)
	}

	return &App{authClient: authClient}, nil
}

func newActionCodeSettings() *auth.ActionCodeSettings {
	actionCodeSettings := &auth.ActionCodeSettings{
		URL: "https://evork.fuuma.net",
	}
	return actionCodeSettings
}

func sendCustomEmail(email, displayName, link string) {
	fmt.Print("ここでメールを送信する処理を実装します")
}

func (app *App) CreateUser(ctx context.Context) (*auth.UserRecord, error) {
	displayName := "fuuma"
	email := "masa81hiro619@gmail.com"
	password := "password"

	params := (&auth.UserToCreate{}).
		Email(email).
		EmailVerified(false).
		Password(password).
		DisplayName(displayName).
		Disabled(false)

	userRecord, err := app.authClient.CreateUser(ctx, params)
	if err != nil {
		return nil, fmt.Errorf("error creating user: %v", err)
	}

	// メール認証リンクを生成する
	actionCodeSettings := newActionCodeSettings()
	link, err := app.authClient.EmailVerificationLinkWithSettings(ctx, email, actionCodeSettings)
	if err != nil {
		return nil, fmt.Errorf("error generating email verification link: %v", err)
	}

	// カスタムメールを送信する
	sendCustomEmail(email, displayName, link)

	return userRecord, nil
}
