# cardano---payment---locker-
# Payment Locker DApp

## Overview
A simple escrow DApp on Cardano Preprod that locks ADA into a Plutus script and unlocks it later.
## Smart Contract (locker.hs)
* **Purpose**: Lock ADA into a script, unlockable by beneficiary.
* **Datum**: `LockerDatum { beneficiary :: PubKeyHash }`
* **Redeemer**: `Unlock`
* **Logic**: `txSignedBy (beneficiary)`

## Frontend (main.js)
* **Lucid integration**: Connects to Cardano wallet and interacts with script.
* **Functions**:
  + `connect`: Connects wallet.
  + `lock`: Locks ADA into script.
  + `unlock`: Unlocks ADA from script.
