{-# LANGUAGE OverloadedStrings #-}
module Handler.EchoHandler (echoHandler) where

import Snap.Core

echoHandler :: Snap ()
echoHandler = do
    param <- getParam "echoparam"
    maybe (writeBS "must specify echo/param in URL")
          writeBS param
