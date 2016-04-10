{-# LANGUAGE OverloadedStrings #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
  ( app
  , routes
  , initDb
  ) where

------------------------------------------------------------------------------
import           Control.Applicative
import           Control.Monad.IO.Class        (liftIO)
import           Control.Monad.Reader
import qualified Controller.Exception          as Ex
import qualified Controller.Login              as Login
import qualified Controller.Todos              as Todos
import           Data.ByteString               (ByteString)
import           Data.Monoid
import qualified Data.Text                     as T
import           Snap.Core
import           Snap.Snaplet
import qualified Snap.Snaplet.PostgresqlSimple as P
import           Snap.Util.FileServe
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
         ] <|>
         Ex.routes


initDb :: ReaderT (Snaplet P.Postgres) IO ()
initDb = do P.execute_ "CREATE TABLE todos (id SERIAL, text TEXT, status BOOLEAN)"
            return ()

------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    db <- nestSnaplet "db" db P.pgsInit
--    liftIO $ runReaderT initDb db
    addRoutes routes
    return $ App db
