import User from './User.js';
import { readFileSync } from 'fs';
import path from 'path';
import HDWalletProvider from '@truffle/hdwallet-provider';
import Web3 from 'web3';
import Event from './Event.js';

class CrowdFunding extends User {
  constructor() {
    const mnemonic = readFileSync(path.resolve('.secret')).toString().trim();

    const account = '0x0602e801fd109DB0Edb8AE8AC92d138ca6cCf668'; // update account to yours.
    const contract_address = '0x8732FE7a3D5337836C85A2CDa5D371Ebc5308780';

    const web3 = new Web3(new HDWalletProvider(mnemonic, `https://ropsten.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161`));
    const web3_ws = new Web3(new Web3.providers.WebsocketProvider('wss://ropsten.infura.io/ws/v3/9aa3d95b3bc440fa88ea12eaa4456161'));

    const abi = JSON.parse(readFileSync('./build/contracts/CrowdFunding.json','utf-8')).abi;
    const contract = new web3.eth.Contract(abi,contract_address);
    const contract_event = new web3_ws.eth.Contract(abi,contract_address);

    super(contract, account);
    this.event = new Event(contract_event);
    this.event.on();
  }
}

export default CrowdFunding;