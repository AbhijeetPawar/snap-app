{-# LANGUAGE ScopedTypeVariables, FlexibleContexts, OverloadedStrings #-}
module Util where

import qualified Data.Configurator              as C
import qualified Data.Configurator.Types        as C

connURI :: C.Config -> IO String
connURI conf = do (Just host) <- C.lookup conf "host"
                  (Just port :: Maybe Int) <- C.lookup conf "port"
                  (Just user) <- C.lookup conf "user"
                  (Just pass :: Maybe String) <- C.lookup conf "pass"
                  (Just db) <- C.lookup conf "db"
                  return $ "postgresql://" ++ user ++ password pass ++ "@" ++ host ++ ":" ++ show port ++ "/" ++ db
                where password p | null p    = ""
                                 | otherwise = ":" ++ p
