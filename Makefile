dc := docker compose

up:
	$(dc) up -d	

down:
	$(dc) down

restart:
	$(dc) restart

reup:
	@make down
	@make up

rmi:
	$(dc) down --rmi all
	@make up

ps:
	$(dc) ps

logs:
	$(dc) logs

logsf:
	$(dc) logs -f

mysql:
	$(dc) exec -it db bash  -c "mysql -u root -p evork"  

migrateup:
	migrate -path db/migration -database "mysql://root:password@tcp(localhost:3306)/evork" -verbose up

migratedown:
	migrate -path db/migration -database "mysql://root:password@tcp(localhost:3306)/evork" -verbose down

PHONY: up down restart reup rmi ps logs logsf mysql migrateup migratedown
