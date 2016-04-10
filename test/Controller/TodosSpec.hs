{-# LANGUAGE OverloadedStrings #-}
module Controller.TodosSpec(spec) where

import           Control.Monad.IO.Class        (liftIO)
import           Data.Aeson                    (decode)
import qualified Data.ByteString               as BS
import qualified Data.Map                      as M
import           Data.Maybe                    (fromJust)
import           Model.Todo                    (Todo (..))
import           Snap.Snaplet.PostgresqlSimple

import           Runner                        (specRunner)
import           Test.Hspec
import qualified Test.Hspec.Snap               as T


spec = specRunner $
  T.beforeEval insert $
  T.afterEval purge $
  describe "GET /todos/get" $
     it "gives all todos" $ do
        res <- T.get' "/todos/get" (M.empty)
        case res of
          (T.Json _ body) -> do let b' = decode body :: Maybe [Todo]
                                    actual = head . fromJust $ b'
                                text actual `T.shouldEqual` "TODO"
                                status actual `T.shouldEqual` False

insert = do execute_ "INSERT INTO todos (text, status) VALUES ('TODO', False)"
            return ()

purge = do execute_ "DELETE from todos"
           return ()
