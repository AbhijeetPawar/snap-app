{-# LANGUAGE OverloadedStrings #-}
module Controller.Login(routes) where

import           Application
import           Data.ByteString
import           Snap.Core
import           Snap.Snaplet

------------------------------------------------------------------------------
-- | Handle Login
handleLogin = undefined

------------------------------------------------------------------------------
-- | Logs out and redirects the user to the site index.
handleLogout = undefined

------------------------------------------------------------------------------
-- | Handle new user form submit
handleNewUser = undefined

routes :: [(ByteString, AppHandler ())]
routes = [ ("/login",    handleLogin)
         , ("/logout",   handleLogout)
         , ("/new_user", handleNewUser)
         ]
