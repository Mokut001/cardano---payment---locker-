# Cardano Payment Locker (Preprod)

## Description
A secure decentralized application where funds are locked in a Plutus V2 script. Only the designated owner (PubKeyHash: `e310f50a0c46db309f4e8c644b47e1412e6ed26a1d7e42f633988069`) can withdraw the funds.

## Files
- `index.html`: The user interface.
- `app.js`: Transaction logic using Lucid and Blockfrost.
- `Locker.hs`: Plutus V2 Haskell source code.

## Configuration
The `app.js` has been updated with your Blockfrost Project ID: `preprodIb3LJHd44Ilolee1XVbQPRLS1eIAh1xb`.

## How to Deploy
1. Host `index.html` and `app.js` on Vercel, Netlify, or GitHub Pages.
2. Access the URL via a Cardano Wallet's DApp browser (VESPR, Eternl, Nami).

## Smart Contract Info
- **Network**: Preprod
- **Owner PKH**: `e310f50a0c46db309f4e8c644b47e1412e6ed26a1d7e42f633988069`
