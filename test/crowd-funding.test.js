const crowd_funding = artifacts.require('CrowdFunding');

contract('CrowdFunding', accounts => {
	let contractInstance;
	before(async () => {
		contractInstance = await crowd_funding.deployed();
	})

	// it('should type a begin time that is after now.',async () => {
	// 	console.log(accounts);
	// 	// const result = contractInstance.createFunding(
	// 	// 	'title',
	// 	// 	'subTitle',
	// 	// 	'content',
	// 	// 	10000,
	// 	// 	10,
	// 	// 	Date.now(),
	// 	// 	Date.now()+86400,
	// 	// 	{from: accounts[0]}
	// 	// )
	// })

	it('should type a begin time that is after now.', () => {
		crowd_funding.deployed()
			.then(instance => {
				return instance.getBalance.call(accounts[0]);
			})
			.then(outCoinBalance => assert.equal(outCoinBalance, 100, '??'));
	})
})

