{-# INLINEABLE mkValidator #-}
mkValidator :: PubKeyHash -> () -> () -> ScriptContext -> Bool
mkValidator ownerPkh _ _ ctx = txSignedBy (scriptContextTxInfo ctx) ownerPkh

-- | Replace this PubKeyHash with your Preprod wallet's payment key hash
ownerPkh :: PubKeyHash
ownerPkh = "e310f50a0c46db309f4e8c644b47e1412e6ed26a1d7e42f633988069"
