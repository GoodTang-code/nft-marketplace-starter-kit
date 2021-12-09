const {assert} = require('chai')

const kBird = artifacts.require("KryptoBirdz");

//check for chai
require('chai')
    .use(require('chai-as-promised'))
    .should()

// arrow function in javascript
//  let x = () => {}

// arrow anonymous function
contract('KryptoBirdz', (accounts) =>{
    let contract
    
    // hook: before
    before( async ()=>{
        contract = await kBird.deployed()
    })


    // testing container - describe
    describe('deployment', async() =>{
        // texst samples with writing it
        it('deployd successfuly', async() => {
            const address = contract.address;

            //address must not empty
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
            assert.notEqual(address, 0x0)           
        })
        it('name matched', async()=> {
            const name = await contract.name();
            assert.equal(name, 'KryptoBirdz')
        })

        it('symbol matched', async()=> {
            const symbol = await contract.symbol();
            assert.equal(symbol, 'KBIRDZ')
        })
    })

    describe('minting', async() => {
        it('create new NFT-Token', async () =>{
            const result = await contract.mint('https...1')
            const totalSupply = await contract.totalSupply()
            const event = result.logs[0].args

            //success
            assert.equal(totalSupply, 1)
            assert.equal(event._from, '0x0000000000000000000000000000000000000000','from is the contract')
            assert.equal(event._to, accounts[0], 'to is msg.sender')

            //assert Failure case
            //await contract.mint('http...1').should.be.rejected;

        })
    })

    describe('indexing', async() => {
        it('lists of KryptoBirdz', async () =>{
            await contract.mint('https...2')
            await contract.mint('https...3')
            await contract.mint('https...4')
            const totalSupply = await contract.totalSupply()

            // Loop through lists and grabs kBirds
            let result = []
            let kBird
            for (i = 1; i <= totalSupply; i++) {
                kBird = await contract.kryptoBird(i - 1) //array but () ?
                result.push(kBird)
            }
            let expected = ['https...1','https...2','https...3','https...4']
            assert.equal(result.join(','), expected.join(','))

        })

    })
})