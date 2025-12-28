let lucid;
const scriptAddress = "addr_test1wqj0uh0f0vwl5g7v6vdyf9j7m3k3tz5p8fn2lzmlv9kktqldq6lkg";
const blockfrostKey = "preprodYjRkHfcazNkL0xxG9C2RdUbUoTrG7wip";

async function connectWallet() {
  try {
    const api = await window.cardano.nami.enable();
    lucid = await Lucid.new(new Lucid.Blockfrost("https://cardano-preprod.blockfrost.io/api/v0", blockfrostKey), "Preprod");
    lucid.selectWallet(api);
    document.getElementById("status").innerText = "Wallet Connected!";
  } catch (e) {
    document.getElementById("status").innerText = "Wallet connection failed.";
  }
}

async function lockAda() {
  try {
    const amount = document.getElementById("amount").value;
    const tx = await lucid.newTx()
      .payToAddress(scriptAddress, { lovelace: BigInt(amount) * 1_000_000n })
      .complete();
    const signed = await tx.sign().complete();
    const txHash = await signed.submit();
    document.getElementById("status").innerText = "Deposit Successful! TX: " + txHash;
  } catch (e) {
    document.getElementById("status").innerText = "Deposit Error: " + e;
  }
}

async function withdrawAda() {
  try {
    const utxos = await lucid.utxosAt(scriptAddress);
    const tx = await lucid.newTx()
      .collectFrom(utxos)
      .complete();
    const signed = await tx.sign().complete();
    const txHash = await signed.submit();
    document.getElementById("status").innerText = "Withdraw Successful! TX: " + txHash;
  } catch (e) {
    document.getElementById("status").innerText = "Withdraw Error: " + e;
  }
}