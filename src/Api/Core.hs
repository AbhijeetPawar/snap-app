{-# LANGUAGE OverloadedStrings #-}

module Api.Core where

import Snap.Core
import Snap.Snaplet
import Data.ByteString

------------------------------------------------------------------------------
-- | Our Custom Api Snaplet.
data Api = Api

statusHandler :: MonadSnap m => m ()
statusHandler = method GET (modifyResponse $ setResponseCode 200)

apiRoutes :: [(ByteString, Handler b Api ())]
apiRoutes = [("status",   statusHandler)]

------------------------------------------------------------------------------
-- | All snapets must have an initializer function. This can be constructed by calling
-- the makeSnaplet. This returns a snaplet which can be composed inside any base application.
apiInit :: SnapletInit b Api
apiInit = makeSnaplet "api" "Core Api" Nothing $ do
  addRoutes apiRoutes
  return Api
