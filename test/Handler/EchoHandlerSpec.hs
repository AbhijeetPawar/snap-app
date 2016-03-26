{-# LANGUAGE OverloadedStrings #-}
module Handler.EchoHandlerSpec (spec) where

import Test.Hspec
import Test.HUnit
import Snap.Test

import qualified Data.Map as M

import Handler.EchoHandler

spec :: Spec
spec = do
  describe "GET /echo/*" $ do
         it "responds with 200" $
            do response <- runHandler (get "/echo/" M.empty) echoHandler
               assertSuccess response

         it "echos given string in URL" $
            do response <- runHandler (get "/echo/" (M.singleton "echoparam" ["haskell", "is", "fun"])) echoHandler
               body <- getResponseBody response
               body `shouldBe` "haskell is fun"
