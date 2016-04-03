{-# LANGUAGE OverloadedStrings #-}
module Api.Types where

import           Control.Monad
import           Data.Aeson
import           Data.Text
import           Prelude                       hiding (id)

data Todo = Todo
            { id     :: Integer
            , text   :: Text
            , status :: Bool
            } deriving (Eq, Show)


instance Ord Todo where
  compare (Todo id1 _ _) (Todo id2 _ _) = compare id1 id2


instance FromJSON Todo where
    parseJSON (Object v) = Todo <$>
                           v .: "id" <*>
                           v .: "text" <*>
                           v .: "status"
    parseJSON _          = mzero

instance ToJSON Todo where
    toJSON (Todo id text status) = object ["id" .= id, "text" .= text, "status" .= status]
