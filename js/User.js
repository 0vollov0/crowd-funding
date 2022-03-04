import Funding from './Funding.js';

class User extends Funding{
  constructor(contract, account) {
    super(contract, account);
  }

  fund = async (id, amount) => {
    const result = {};
    return this.contract.methods.fund(id)
      .send({from: this.account, gas: 3000000, value: amount })
      .on('error',(error) => console.error(error, 'heelo?'))
      .then(() => {
        result.success = true;
        result.message = 'The fund method has done successfully.';
        return result;
      })
      .catch(error => {
        result.success = true;
        result.message = error;
        return result;
      });
  }

  getMyFundingAccountPapers = async (id) => {
    return this.contract.methods.getMyFundingAccountPapers(id).call({from: this.account});
  }

  withdrawAsFunder = async (id) => {
    const result = {};
    return this.contract.methods.withdrawAsFunder(id)
      .send({from: this.account, gas: 3000000})
      .then(() => {
        result.success = true;
        result.message = 'The withdrawAsFunder method has done successfully.';
        return result;
      })
      .catch(error => {
        result.success = false;
        result.message = error;
        return result;
      })
  }

  withdrawAsFundraiser = async (id) => {
    const result = {};
    return this.contract.methods.withdrawAsFundraiser(id)
      .send({from: this.account, gas: 3000000})
      .then(() => {
        result.success = true;
        result.message = 'The withdrawAsFundraiser method has done successfully.';
        return result;
      })
      .catch(error => {
        result.success = false;
        result.message = error;
        return result;
      })
  }

  setAvailableMinAmount = async (id, amount) => {
    const result = {};
    return this.contract.methods.setAvailableMinAmount(id, amount)
      .send({from: this.account, gas: 3000000})
      .then(() => {
        result.success = true;
        result.message = 'The setAvailableMinAmount method has done successfully.';
        return result;
      })
      .catch(error => {
        result.success = false;
        result.message = error;
        return result;
      })
  }
}

export default User;