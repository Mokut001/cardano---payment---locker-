{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE DeriveAnyClass      #-}
{-# LANGUAGE DeriveGeneric       #-}
{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE NoImplicitPrelude   #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell     #-}
{-# LANGUAGE TypeApplications    #-}
{-# LANGUAGE TypeFamilies        #-}

import           Cardano.Api.Scripts
import           PlutusTx.Prelude
import qualified PlutusTx
import           Ledger
import           Ledger.Ada         as Ada
import           Ledger.Constraints as Constraints
import           Ledger.Typed.Scripts
import           Wallet.Emulator.Wallet

data LockerDatum = LockerDatum
    { beneficiary :: PubKeyHash
    } deriving (Show, Generic, ToJSON, FromJSON)

PlutusTx.unstableMakeIsData ''LockerDatum

data LockerRedeemer = Unlock
    deriving (Show, Generic, ToJSON, FromJSON)

PlutusTx.unstableMakeIsData ''LockerRedeemer

{-# INLINABLE mkLockerValidator #-}
mkLockerValidator :: LockerDatum -> LockerRedeemer -> ScriptContext -> Bool
mkLockerValidator datum Unlock ctx =
    txSignedBy (scriptContextTxInfo ctx) (beneficiary datum)

validator :: TypedValidator LockerDatum LockerRedeemer
validator = mkTypedValidator
    $$(PlutusTx.compile [|| mkLockerValidator ||])

script :: Script
script = unTypedScript validator

scriptHash :: ScriptHash
scriptHash = scriptHash $ validatorScript validator

scriptAddress :: Address
scriptAddress = scriptAddress scriptHash
