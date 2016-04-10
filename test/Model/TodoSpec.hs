{-# LANGUAGE OverloadedStrings #-}
module Model.TodoSpec (spec) where

import           Data.Aeson
import           Data.Text
import           Model.Todo
import           Test.Hspec

spec :: SpecWith ()
spec =
  describe "From and To JSON for Todo" $ do
    it "should encode Todo to JSON" $
      encode (Todo 1 "First Task" False)
      `shouldBe` "{\"status\":false,\"text\":\"First Task\",\"id\":1}"

    it "should decode Todo from JSON" $
      decode "{\"status\":false,\"text\":\"First Task\",\"id\":2}"
      `shouldBe` (Just $ Todo 2 "First Task" False)

    it "should return identity on encode . decode" $
      let x = Todo 1 "First Task" False
      in (decode . encode $ x) `shouldBe` Just x
