{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module Api.Service.TodoService
    ( TodoService(TodoService)
    , todoServiceInit
    ) where

import           Api.Types                     (Todo (Todo))
import           Control.Lens                  (makeLenses)
import           Control.Monad.State.Class     (get)
import           Data.Aeson                    (encode)
import           Data.ByteString
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.PostgresqlSimple

data TodoService = TodoService
    { _db :: Snaplet Postgres
    }

makeLenses ''TodoService

getTodos :: (MonadSnap m, HasPostgres m) => m ()
getTodos = method GET $
  do todos <- query_ "SELECT * FROM todos"
     modifyResponse $ setHeader "Content-Type" "application/json"
     writeLBS . encode $ (todos :: [Todo])

todoRoutes :: [(ByteString, Handler b TodoService ())]
todoRoutes = [("/", getTodos)]


todoServiceInit :: SnapletInit b TodoService
todoServiceInit = makeSnaplet "todos" "Todo Service" Nothing $ do
  db <- nestSnaplet "db" db pgsInit
  addRoutes todoRoutes
  return $ TodoService db

instance HasPostgres (Handler b TodoService) where
  getPostgresState = with db get
