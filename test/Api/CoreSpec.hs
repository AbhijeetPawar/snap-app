{-# LANGUAGE OverloadedStrings #-}
module Api.CoreSpec (spec) where

import           Snap.Test
import           Test.Hspec
import qualified Data.Map     as M
import           Snap.Core
import           Snap.Snaplet

import           Api.Core

spec :: Spec
spec =
  describe "GET /api/status" $
     it "responds with 200" $
        do response <- runHandler (get "/api/status" M.empty) statusHandler
           assertSuccess response
