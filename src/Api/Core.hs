{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module Api.Core where

import           Api.Service.TodoService
import           Control.Lens            (makeLenses)
import           Data.ByteString
import           Snap.Core
import           Snap.Snaplet

------------------------------------------------------------------------------
-- | Our Base Api Snaplet.
data Api = Api
    { _todoService :: Snaplet TodoService
    }

makeLenses ''Api

statusHandler :: MonadSnap m => m ()
statusHandler = method GET (modifyResponse $ setResponseCode 200)

apiRoutes :: [(ByteString, Handler b Api ())]
apiRoutes = [("status",   statusHandler)]

------------------------------------------------------------------------------
-- | All snapets must have an initializer function. This can be constructed by calling
-- the makeSnaplet. This returns a snaplet which can be composed inside any base application.
apiInit :: SnapletInit b Api
apiInit = makeSnaplet "api" "Core Api" Nothing $ do
  ts <- nestSnaplet "todos" todoService todoServiceInit
  addRoutes apiRoutes
  return $ Api ts
