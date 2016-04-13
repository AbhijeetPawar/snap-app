{-# LANGUAGE OverloadedStrings #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
  ( app
  , routes
  ) where

------------------------------------------------------------------------------
import           Control.Applicative
import           Control.Monad.IO.Class         (liftIO)
import           Control.Monad.Reader
import qualified Controller.Exception           as Ex
import qualified Controller.Login               as Login
import qualified Controller.Todos               as Todos
import           Data.ByteString                (ByteString)
import qualified Data.Configurator              as C
import qualified Data.Configurator.Types        as C
import qualified Data.Text                      as T
import qualified Database.PostgreSQL.Migrate    as M
import qualified Database.PostgreSQL.Migrations as M
import           Snap.Core
import           Snap.Snaplet
import qualified Snap.Snaplet.PostgresqlSimple  as P
import           Snap.Util.FileServe
import           System.Directory               (getCurrentDirectory)
import           System.Environment             (setEnv)
import           System.FilePath                ((</>))
import           System.IO                      (stdout)
------------------------------------------------------------------------------
import           Application
import           Util                           (connURI)

------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = Login.routes <|>
         Todos.routes <|>
         [ ("/status",   statusHandler)
         , ("",          serveDirectory "static")
         ] <|>
         Ex.routes


statusHandler :: MonadSnap m => m ()
statusHandler = method GET (modifyResponse $ setResponseCode 200)

------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application" Nothing $ do
    config <- getEnvConf
    execMigrations config
    pgsConf <- P.mkPGSConfig config
    db <- nestSnaplet "db" db (P.pgsInit' pgsConf)
    addRoutes routes
    return $ App db


getEnvConf :: Initializer App App C.Config
getEnvConf = do env <- getEnvironment
                path <- liftIO getCurrentDirectory
                liftIO $ C.load [ C.Required $ path </> "resources" </> (env ++ ".cfg") ]


execMigrations :: C.Config -> Initializer App App ()
execMigrations conf = liftIO $ do
                        uri <- connURI conf
                        setEnv "DATABASE_URL" uri
                        base <- getCurrentDirectory
                        M.initializeDb
                        M.runMigrationsForDir stdout (base </> "db" </> "Migration")
                        return ()
