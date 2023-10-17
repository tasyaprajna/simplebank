postgres:
	docker run --name postgres12 --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:alpine ;

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank ;

dropdb:
	docker exec -it postgres12 dropdb simple_bank ;

migrateup:
	migrate -path db/migration -database "postgresql://root:1ySQcUUwWHAaI2eGP5jN@simplebank.cukdkadqzhq3.ap-southeast-3.rds.amazonaws.com:5432/simple_bank" -verbose up 

migrateup1:
	migrate -path db/migration -database "postgresql://root:1ySQcUUwWHAaI2eGP5jN@simplebank.cukdkadqzhq3.ap-southeast-3.rds.amazonaws.com:5432/simple_bank" -verbose up 1 

migratedown:
	migrate -path db/migration -database "postgresql://root:1ySQcUUwWHAaI2eGP5jN@simplebank.cukdkadqzhq3.ap-southeast-3.rds.amazonaws.com:5432/simple_bank" -verbose down 

migratedown1:
	migrate -path db/migration -database "postgresql://root:1ySQcUUwWHAaI2eGP5jN@simplebank.cukdkadqzhq3.ap-southeast-3.rds.amazonaws.com:5432/simple_bank" -verbose down 1 

migrateforce:
	migrate -path db/migration -database "postgresql://root:1ySQcUUwWHAaI2eGP5jN@simplebank.cukdkadqzhq3.ap-southeast-3.rds.amazonaws.com:5432/simple_bank" force 2

migrateforce1:
	migrate -path db/migration -database "postgresql://root:1ySQcUUwWHAaI2eGP5jN@simplebank.cukdkadqzhq3.ap-southeast-3.rds.amazonaws.com:5432/simple_bank" force 1 

sqlc:
	sqlc generate

test: 
	go test -v -cover ./... ;

server:
	go run main.go ;

mock: 
	mockgen -package mockdb -destination db/mock/store.go github.com/tasyaprajna/simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migrateup1 migratedown migratedown1 migrateforce migrateforce1 sqlc test server mock