{-# LANGUAGE OverloadedStrings #-}
module Controller.Todos(routes) where

import           Application
import           Data.Aeson      (encode)
import           Data.ByteString
import           Model.Todo
import           Snap.Core
import           Snap.Snaplet


getTodos :: AppHandler ()
getTodos = do
     todos <- getAllTodos
     modifyResponse $ setHeader "Content-Type" "application/json"
     writeLBS . encode $ (todos :: [Todo])


routes :: [(ByteString, AppHandler ())]
routes = [("/", method GET getTodos)]
