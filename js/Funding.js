import AbstractFunding from './AbstractFunding.js';

class Funding extends AbstractFunding{
  constructor(contract, account) {
    super(contract, account);
  }

  getFundings = async () => {
    return await this.contract.methods.getFundings().call();
  }

  getFunding = async (id) => {
    return await this.contract.methods.getFunding(id).call();
  }

  createFunding = async (title, subTitle, content, goalAmount, availableMinAmount, beginTime, endTime) => {
    const result = {};
    return this.contract.methods.createFunding(
      title,
      subTitle,
      content,
      goalAmount,
      availableMinAmount,
      beginTime,
      endTime
    )
    .send({from: this.account, gas: 3000000 })
    .then(() => {
      result.success = true;
      result.message = 'The createFunding method has done successfully.';
      return result;
    })
    .catch(() => {
      result.success = false;
      result.message = 'The createFunding method failed.';
      return result;
    })
  }
}

export default Funding;