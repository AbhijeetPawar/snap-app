{-# LANGUAGE OverloadedStrings #-}
module Runner (specRunner) where

import           Snap.Core
import qualified Test.Hspec.Snap               as T

import           Site                          (routes, app)


specRunner = T.snap (route routes) app
