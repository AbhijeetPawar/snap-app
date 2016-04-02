{-# LANGUAGE OverloadedStrings #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
  ( app
  ) where

------------------------------------------------------------------------------
import           Control.Applicative
import           Data.ByteString (ByteString)
import           Data.Monoid
import qualified Data.Text as T
import           Snap.Core
import           Snap.Snaplet
import           Snap.Util.FileServe
------------------------------------------------------------------------------
import           Application

import Api.Core (Api(Api), apiInit)


------------------------------------------------------------------------------
-- | Handle Login
handleLogin = undefined

------------------------------------------------------------------------------
-- | Logs out and redirects the user to the site index.
handleLogout = undefined

------------------------------------------------------------------------------
-- | Handle new user form submit
handleNewUser = undefined


------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = [ ("/login",    handleLogin)
         , ("/logout",   handleLogout)
         , ("/new_user", handleNewUser)
         , ("",          serveDirectory "static")
         ]


------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    api <- nestSnaplet "api" api apiInit
    addRoutes routes
    return $ App api
