import { error, log } from 'console';
class Event {
  constructor(contract) {
    this.contract = contract;
  }

  on = () => {
    this.onCreateFunding();
    this.onFund();
    this.onWithdrawAsFunder();
    this.onWithdrawAsFundraiser();
  }

  onCreateFunding = () => {
    this.contract.events.CreateFunding() 
      .on('data', event => {
        const funding = event.returnValues;
        const date = new Date(parseInt(funding.beginTime)*1000).toDateString();
        console.log(`CreateFunding: ${funding.title} has been created by ${funding.owner} as id ${funding.id}. The funding will be begin in ${date}.`);
      })
      .on('error', error);
  }

  onFund = () => {
    this.contract.events.Fund()
      .on('data', event => {
        const funded_info = event.returnValues;
        const time = new Date(parseInt(funded_info.time)*1000).toDateString();
        console.log(`Funer ${funded_info.funder} has funded ${funded_info.amount} wei at funding ID ${funded_info.fundingId}. Time: ${time}.`);
      })
      .on('error', error);
  }

  onWithdrawAsFunder = () => {
    this.contract.events.WithdrawAsFunder()
      .on('data', event => {
        const time = new Date(parseInt(event.returnValues.time)*1000).toDateString();
        console.log(`Funer ${event.returnValues.funder} has widthdraw ${event.returnValues.amount} wei. Time: ${time}`);
      })
      .on('error', console.error);
  }

  onWithdrawAsFundraiser = () => {
    this.contract.events.WithdrawAsFundraiser()
      .on('data', event => {
        const time = new Date(parseInt(event.returnValues.time)*1000).toDateString();
        console.log(`Funer ${event.returnValues.fundraiser} has widthdraw ${event.returnValues.amount} wei. Time: ${time}`);
      })
      .on('error', console.error);
  }
}

export default Event;