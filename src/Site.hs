{-# LANGUAGE OverloadedStrings #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
  ( app
  , statusHandler
  ) where

------------------------------------------------------------------------------
import           Control.Applicative
import           Data.ByteString               (ByteString)
import           Data.Monoid
import qualified Data.Text                     as T
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.PostgresqlSimple (pgsInit)
import           Snap.Util.FileServe
import qualified Controller.Login as Login
import qualified Controller.Todos as Todos
------------------------------------------------------------------------------
import           Application


statusHandler :: MonadSnap m => m ()
statusHandler = method GET (modifyResponse $ setResponseCode 200)

------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = Login.routes <|>
         Todos.routes <|>
         [ ("/status",   statusHandler)
         , ("",          serveDirectory "static")
         ]

------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    db <- nestSnaplet "db" db pgsInit
    addRoutes routes
    return $ App db
