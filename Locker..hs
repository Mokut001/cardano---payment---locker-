{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}

module Locker where

import Plutus.V2.Ledger.Api
import Plutus.V2.Ledger.Contexts
import PlutusTx
import PlutusTx.Prelude hiding (Semigroup(..))
import Prelude (Semigroup(..))
import qualified Data.ByteString.Short as SBS
import qualified Data.ByteString.Lazy as LBS
import Codec.Serialise (serialise)

-- | Only the owner (PubKeyHash) can withdraw funds
{-# INLINABLE mkLocker #-}
mkLocker :: PubKeyHash -> () -> ScriptContext -> Bool
mkLocker ownerPKH _ ctx =
    traceIfFalse "Only owner can withdraw" signedByOwner
  where
    txInfo :: TxInfo
    txInfo = scriptContextTxInfo ctx

    signedByOwner :: Bool
    signedByOwner = txInfo `txSignedBy` ownerPKH

-- | Replace this PubKeyHash with your Preprod wallet's payment key hash
ownerPkh :: PubKeyHash
ownerPkh = "e310f50a0c46db309f4e8c644b47e1412e6ed26a1d7e42f633988069"

{-# INLINABLE wrapper #-}
wrapper :: () -> ScriptContext -> Bool
wrapper = mkLocker ownerPkh

-- | Compile the validator
validator :: Validator
validator = mkValidatorScript $$(PlutusTx.compile [|| wrapper ||])

-- | Plutus Script
script :: Script
script = unValidatorScript validator

-- | Short ByteString (ready to save as .plutus)
scriptShortBs :: SBS.ShortByteString
scriptShortBs = SBS.toShort . LBS.toStrict $ serialise script