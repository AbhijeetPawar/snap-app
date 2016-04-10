{-# LANGUAGE OverloadedStrings #-}
module SiteSpec (spec) where

import qualified Data.Map        as M
import           Snap.Core
import           Test.Hspec
import qualified Test.Hspec.Snap as T

import Runner (specRunner)


spec :: Spec
spec = specRunner $ do
  describe "GET /status" $ do
     it "responds with 200" $
        T.get' "/status" (M.empty) >>= T.should200
