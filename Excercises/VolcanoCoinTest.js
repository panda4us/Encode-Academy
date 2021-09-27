const VolcanoCoin = artifacts.require("VolcanoCoin");
const truffleAssert = require('truffle-assertions');
contract("VolcanoCoin", accounts => {
    it("should mint 10000 VolcanoCoin", async () => {
    const instance = await VolcanoCoin.deployed();
    //console.log(instance);
    const totalSupply = await instance.totalSupply.call();
    assert.equal(
        totalSupply.toNumber(),
       10000,
        "Minting Failed",
        );            
    });
    
    it("account 0xcB7C09fEF1a308143D9bf328F2C33f33FaA46bC2 should have zero balance", async() => {
        const instance = await VolcanoCoin.deployed();
        const balance = await instance.balanceOf("0xcB7C09fEF1a308143D9bf328F2C33f33FaA46bC2");
        assert.equal(
            balance.toNumber(),
            0,
            "balance is not zero!"
        );
    });
    
    it("Owner has balance of 10000 VolcanoCoin", async() => {
        const instance = await VolcanoCoin.deployed();
        const address = await instance.owner();
        console.log(address);
        
        const balance = await instance.balanceOf(address);


        console.log(balance.toString());
        const result = await _mint(address, 100000)
        const event = result.logs[0].args
        console.log(evemt.toString())
        //truffleAssert.eventEmitted(result, 'TestEvent', { param1: 10, param2: 20 });
        assert.equal(
            balance.toNumber(),
          10000,
            "Owner balance should be 10000"
        );
    });
});
