import { error } from 'console';
class Event {
  constructor(contract) {
    this.contract = contract;
  }

  on = () => {
    this.onCreateFunding();
    this.onFund();
    this.onWithdrawAsFunder();
  }

  onCreateFunding = () => {
    this.contract.events.CreateFunding() 
      .on('data', event => {
          const funding = event.returnValues;
          const date = new Date(funding.beginTime).getTime();
          console.log(`CreateFunding: ${funding.title} has been created by ${funding.owner} as id ${funding.id}. The funding will be begin in ${date}`);
      })
      .on('error', error);
  }

  onFund = () => {
    this.contract.events.Fund()
      .on('data', event => {
          const funded_info = event.returnValues;
          const date = new Date(funded_info.date).getTime();
          console.log(`Funer ${funded_info.funder} has funded ${funded_info.amount} wei at funding ID ${funded_info.fundingId} in ${date}`);
      })
      .on('error', error);
  }

  onWithdrawAsFunder = () => {
    this.contract.events.WithdrawAsFunder()
      .on('data', event => {
          console.log(`Funer ${event.returnValues.funder} has widthdraw ${event.returnValues.amount} wei`);
      })
      .on('error', console.error);
  }
}

export default Event;