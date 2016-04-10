{-# LANGUAGE OverloadedStrings #-}
module Controller.Exception(routes) where

import           Application
import           Data.ByteString
import           Data.Monoid     ((<>))
import           Snap.Core
import           Snap.Snaplet


_404handler :: AppHandler ()
_404handler = do
  modifyResponse (setResponseStatus 404 "Not Found")
  req <- getRequest
  writeBS $ "No Handler Found: " <> rqURI req
  res <- getResponse
  finishWith res


routes :: [(ByteString, AppHandler ())]
routes = [("", _404handler)]
