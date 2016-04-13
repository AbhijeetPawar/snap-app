{-# LANGUAGE OverloadedStrings #-}
import           Data.ByteString
import           Database.PostgreSQL.Migrations

main = defaultMain up down

up = migrate $
      create_table "todos"
        [ column "id" "SERIAL NOT NULL"
        , column "text" "TEXT NOT NULL"
        , column "status" "BOOLEAN DEFAULT TRUE"
        ]

down = migrate $ drop_table "todos"
