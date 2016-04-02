{-# LANGUAGE OverloadedStrings #-}

module Api.Core where

import Snap.Snaplet

------------------------------------------------------------------------------
-- | Our Custom Snaplet.
data Api = Api

------------------------------------------------------------------------------
-- | All snapets must have an initializer function. This can be constructed by calling
-- the makeSnaplet. This returns a snaplet which can be composed inside any base application.
apiInit :: SnapletInit b Api
apiInit = makeSnaplet "api" "Core Api" Nothing $ return Api
