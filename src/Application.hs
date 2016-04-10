{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE FlexibleInstances #-}

------------------------------------------------------------------------------
-- | This module defines our application's state type and an alias for its
-- handler monad.
module Application where

------------------------------------------------------------------------------
import Control.Lens
import Control.Monad.State.Class
import Snap.Snaplet
import Snap.Snaplet.PostgresqlSimple

------------------------------------------------------------------------------
data App = App
    { _db  :: Snaplet Postgres
    }

makeLenses ''App

------------------------------------------------------------------------------
type AppHandler = Handler App App

instance HasPostgres (Handler b App) where
  getPostgresState = with db get
