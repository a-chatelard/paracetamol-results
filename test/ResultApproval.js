const ParacetamolResult = artifacts.require("ParacetamolResult");
const utils = require("./helpers/utils");
const patientRefs = ["Enzo", "Yanis", "Antoine"];
const lotLabels = ["1", "2"];
contract("ResultApproval", (accounts) => {
    let [medicalEnterprise, approvedUser, dissapprovedUser] = accounts;
    let contractInstance;
    beforeEach(async () => {
        contractInstance = await ParacetamolResult.new();
    });

    it("should be able to approve a user", async () => {
        const result = await contractInstance.approve(approvedUser, { from: medicalEnterprise });
        assert.equal(result.receipt.status, true);
    })

    it("should be able to dissapprove a user", async () => {
        const result = await contractInstance.disapprove(dissapprovedUser, { from: medicalEnterprise });
        assert.equal(result.receipt.status, true);
    })

    it("shouldn't be able to add a new result as a dissaproved user", async () => {
        await utils.shouldThrow(contractInstance.addResult(patientRefs[0], lotLabels[0], true, { from: dissapprovedUser }));
    })

    it("shouldn't be able to close as a dissaproved user", async () => {
        await utils.shouldThrow(contractInstance.close({ from: dissapprovedUser }));
    })
})