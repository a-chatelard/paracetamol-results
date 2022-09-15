const ParacetamolResult = artifacts.require("ParacetamolResult");
const utils = require("./helpers/utils");
const patientRefs = ["Enzo", "Yanis", "Antoine"];
const lotLabels = ["1", "2"];
contract("ParacetamolResult", (accounts) => {
    let [medicalEnterprise, tester] = accounts;
    let contractInstance;
    beforeEach(async () => {
        contractInstance = await ParacetamolResult.new();
    });
    it("should be able to add a new result", async () => {
        const result = await contractInstance.addResult(patientRefs[0], lotLabels[0], true, { from: medicalEnterprise });
        assert.equal(result.receipt.status, true);
        console.log(result);
    })
    it("shouldn't be able to add a new result on an existing patient", async () => {
        await contractInstance.addResult(patientRefs[0], lotLabels[0], true, { from: medicalEnterprise });
        await utils.shouldThrow(contractInstance.addResult(patientRefs[0], lotLabels[0], true, { from: medicalEnterprise }));
    })

    it("should be able to get the total result", async () => {
        await contractInstance.addResult(patientRefs[0], lotLabels[0], true, { from: medicalEnterprise });
        await contractInstance.addResult(patientRefs[1], lotLabels[0], false, { from: medicalEnterprise });
        const result = await contractInstance.getResultSnapshot();
        assert.equal(result, 50);
    })

    it("shouldn't be able to add new result when closed", async () => {
        await contractInstance.close({ from: medicalEnterprise });
        await utils.shouldThrow(contractInstance.addResult(patientRefs[0], lotLabels[0], true, { from: medicalEnterprise }));
    })


})