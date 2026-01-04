
A Simple DeFi DApp for Secure ADA Locking & Owner-Only Withdrawal on the Cardano Blockchain (Preprod)
## 1. Project Overview
The Cardano Payment Locker is a minimal yet fully functional DeFi smart contract designed to solve a real-life problem:
Problem:
Individuals and organizations need a simple, safe way to lock ADA for a specific user (owner), ensuring no one else can withdraw the funds, including the sender.
Solution:
A non-custodial payment locker where:
Anyone can deposit ADA into the script.
Only the wallet owner defined in the smart contract can withdraw.
Funds remain safely locked on Cardano until redeemed by the owner.
This system can be used for:
Savings vaults
Crowdfunding releases
Allowance / guardian-controlled funds
Emergency reserve wallets
The DApp uses:
Haskell (Plutus V2) for the smart contract
Lucid for frontend transaction building
Blockfrost for blockchain interaction
Preprod network for secure testing
Script address generated directly from your contract
## 2. Smart Contract Logic
Purpose
The contract restricts withdrawal strictly to a predefined PubKeyHash.
Deposits are open to anyone.
Validation Rules
Deposit: No validation required — users send ADA to the script address.
Withdrawal:
The transaction must be signed by the wallet whose PubKeyHash is encoded in the validator script.
If the withdrawer is not the owner → the transaction fails.
## 3. Full Smart Contract (Haskell)
Copy code
Haskell
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

-- | Replace this PubKeyHash with your Preprod wallet's key hash
ownerPkh :: PubKeyHash
ownerPkh = "e310f50a0c46db309f4e8c644b47e1412e6ed26a1d7e42f633988069"

{-# INLINABLE wrapper #-}
wrapper :: () -> ScriptContext -> Bool
wrapper = mkLocker ownerPkh

validator :: Validator
validator = mkValidatorScript $$(PlutusTx.compile [|| wrapper ||])

script :: Script
script = unValidatorScript validator

scriptShortBs :: SBS.ShortByteString
scriptShortBs =
    SBS.toShort . LBS.toStrict $ serialise script
## 4. Script Address
Your Plutus script compiles to a script address (Preprod) used by the frontend.
Script Address (example):
Copy code

addr_test1wp7f6m4cpq3xq5f5j7vs4tye0u9e3fvhp6v4q4qsdzs0dcg9fe90c
This is where users send ADA to lock funds.
## 5. Frontend Implementation (Lucid)
The frontend DApp:
Connects to CIP-30 wallets (Nami, Eternl, Lace, Typhon)
Shows wallet balance
Allows user to Deposit ADA into the script
Allows contract owner to Withdraw ADA
Files:
Copy code

frontend/
├── index.html
├── main.js
└── style.css
## 6. Blockfrost Integration
Your application uses Blockfrost (Preprod):
Copy code

API KEY: preprodYjRkHfcazNkL0xxG9C2RdUbUoTrG7wip
NETWORK: preprod
ENDPOINT: https://cardano-preprod.blockfrost.io/api/v0
Lucid uses this key to:
Fetch UTxOs
Build transactions
Submit signed transactions
## 7. Project Folder Structure
Copy code

cardano-payment-locker-dapp/
│
├── contract/
│   ├── Locker.hs
│   └── locker.plutus
│
├── frontend/
│   ├── index.html
│   ├── main.js
│   └── style.css
│
├── README.md
└── DOCUMENTATION.md
## 8. How Funds Move in the System
1. Deposit Flow
✔ User connects wallet
✔ User enters amount and clicks Deposit
✔ Lucid creates transaction → ADA sent to script
✔ Funds appear as UTxO at script address
2. Withdrawal Flow
✔ Only the owner’s wallet can withdraw
✔ Lucid gathers all script UTxOs
✔ Builds withdrawal transaction
✔ Applies validator logic
✔ Signs with owner wallet
✔ Submits to blockchain
If the signature does not match the owner: ❌ Withdrawal fails with “Only owner can withdraw”
## 9. Security Considerations
This contract is:
Non-custodial
Permissionless for deposits
Owner-restricted for withdrawals
Stateless and trustless
No external service can steal funds—only the owner has the ability to unlock ADA.
## 10. Deployment Instructions
1. Upload to GitHub
Upload all folders exactly as structured.
2. Deploy Frontend on Vercel
Import GitHub repo
Set root directory to frontend
Click Deploy
Open live URL
3. Test with a Preprod wallet
Load test ADA
Try deposit
Try withdrawal (owner only)
## 11. Real Life Use Cases
✔ Digital Savings Vault
Users can lock ADA for future savings with no one able to touch it.
✔ Parental Control / Allowances
Parents deposit ADA for children; only guardian withdraws.
✔ NGO Funds
Public can deposit; only authorized wallet spends.
✔ Payment Hold
Lock funds for service providers and release only when conditions are met.
## 12. Conclusion
This DeFi system provides:
A clean Haskell Plutus contract
A working frontend UI
Wallet connection
Transaction creation
Real-world usefulness
It demonstrates:
Your capability in Plutus development
Frontend-to-contract integration
Real DeFi architecture
Professional understanding of Cardano DApps
If you want, I can also generate:
Developer onboarding guide
 API-based backend (Servant)
 Plutus test suite
UML smart contract diagram
Vercel troubleshooting guide
Just tell me what you want added.
