{-# LANGUAGE OverloadedStrings #-}
module SiteSpec (spec) where

import           Snap.Test
import           Test.Hspec
import qualified Data.Map     as M
import           Snap.Core
import           Snap.Snaplet

import           Site

spec :: Spec
spec =
  describe "GET /status" $
     it "responds with 200" $
        do response <- runHandler (get "/status" M.empty) statusHandler
           assertSuccess response
