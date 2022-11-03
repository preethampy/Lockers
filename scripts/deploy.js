async function main () {
    try{
        const Lockers = await ethers.getContractFactory('Lockers');
    console.log('Deploying Lockers');
    const livonObject = await Lockers.deploy();
    await livonObject.deployed();
    console.log('Lockers deployed to:', livonObject.address);
    }
    catch(err){
        console.log(err)
    }
    }
main()
.then(() => process.exit(0))
.catch(error => {
    console.error(error);
    process.exit(1);
    });