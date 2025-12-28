import { Lucid, Blockfrost } from "https:                                                               

const blockfrostAPI = "https://cardano-preprod.blockfrost.io/api/v0";
const blockfrostKey = "preprodYjRkHfcazNkL0xxG9C2RdUbUoTrG7wip";
const scriptHash = "67f38a1b6d5c4e3f2d1a0c9b8e7d6f5a4c3b2d1e";
const scriptAddress = "addr_test1wrxxy9x8xxs0p2qxxc8xx5xx4xx7xx9xx6xx3xxxnz82xxs4xxx";

const lucid = await Lucid.new(
  new Blockfrost(blockfrostAPI, blockfrostKey),
  "Preprod"
);

document.getElementById("connect").onclick = async () => {
  const api = await lucid.wallet();
  const address = await api.getAddress();
  alert(`Connected: ${address}`);
};

document.getElementById("lock").onclick = async () => {
  const api = await lucid.wallet();
  const tx = await lucid
    .tx()
    .payToContract(scriptAddress, { inline: { beneficiary: "61c2c5d8c94c7d5a8f8f5a1d4e3c2b1a0f9e8d7c6" } }, { lovelace: 1000000n })
    .complete();
  const signedTx = await api.signTx(tx);
  await lucid.submitTx(signedTx);
};

document.getElementById("unlock").onclick = async () => {
  const api = await lucid.wallet();
  const tx = await lucid
    .tx()
    .readFrom(scriptAddress)
    .collectFrom(scriptAddress, { inline: "Unlock" })
    .complete();
  const signedTx = await api.signTx(tx);
  await lucid.submitTx(signedTx);
};
