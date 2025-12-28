# Cardano Payment Locker DApp Documentation

## Overview
This DApp allows users to lock ADA into a Plutus smart contract. Only the owner can withdraw funds.

## Steps to use
1. Connect your Preprod wallet (Nami or Eternl).
2. Deposit ADA using the frontend.
3. Withdraw ADA (only allowed for the owner).

## Files
- `frontend/` : frontend HTML, JS, CSS.
- `contract/locker.plutus` : precompiled Plutus script.
- `README.md` : basic instructions.
- `DOCUMENTATION.md` : detailed explanation.

## Deployment
Upload the folders to GitHub, then deploy `frontend` on Vercel with root folder as `frontend`.