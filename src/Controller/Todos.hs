{-# LANGUAGE OverloadedStrings #-}
module Controller.Todos(routes) where

import           Application
import           Data.Aeson      (encode)
import           Data.ByteString
import           Data.Monoid
import           Model.Todo
import           Snap.Core
import           Snap.Snaplet


getTodos :: AppHandler ()
getTodos = do
     todos <- getAllTodos
     modifyResponse $ setHeader "Content-Type" "application/json"
     writeLBS . encode $ (todos :: [Todo])


base = "/todos"

routes :: [(ByteString, AppHandler ())]
routes = [(base <> "/get", method GET getTodos)]
