pragma solidity ^0.4.16;

contract workPool {
   
   address[] parties = [0x3001cEcA51Bfa3635E5f7c8E06862eE0f61690Dd, 0x11226d0Cba87f94dBe8fB3F2b8e8Fc1244a04959, 0x7735d3fFA1DF57aa1119c7c0B91C21de66A9FB23];
 
   uint totalReceived = 0;
   
   mapping (address => uint) withdrawnAmounts; 

   string legal = 'This Agreement, dated 11 November, 2017, is entered into by and between: 0xbF2da138E6De9395Cf2E5bd3EA3035cf311Af064 (Finley Corp) - and – 0x3001cEcA51Bfa3635E5f7c8E06862eE0f61690Dd (“Content Writer”) - and – 0x11226d0Cba87f94dBe8fB3F2b8e8Fc1244a04959 (“UX/UI Designer”) -and – 0x7735d3fFA1DF57aa1119c7c0B91C21de66A9FB23 (“Front-End Developer”) In consideration of the covenants, agreements and releases set forth herein and for other good and valuable consideration, the receipt and sufficiency of which is hereby acknowledged, the Parties agree as follows: 1. Amount Payable a) The Employer shall pay to Content Writer by blockchain the sum of 180 ETH immediatly following the signing of this Agreement. b) The Employer shall pay to UX/UI Designer by blockchain the sum of 180 ETH immediatly following the signing of this Agreement. c)The Employer shall pay to Front-End Developer by blockchain the sum of 180 ETH immediatly following the signing of this Agreement. 2. Terms of Payment The afore listed payments will be payable to each of the persons set forth only in the event each of these persons performs the contracted services. Any person not providing such services will receive no payments, unless otherwise agreed to by the producer. 3. Execution Date This Agreement becomes final and binding on the Parties on the Execution Date. 4. Termination This Agreement will be automatically terminated in the event that the requisite amount of signatures have not been received after 7 days from the purported Execution Date. 5. Severability In the event any portion of this Agreement is deemed to be invalid or unenforceable, such portion shall be deemed severed and the parties agree that the remaining portions of this Agreement shall remain in full force and effect. 6. Assignment Neither party may assign or otherwise transfer this Agreement. This Agreement shall enure to the benefit of and bind the parties hereto and their respective legal representatives, successors and assigns. 7. Governing Law This Agreement shall be governed by and construed in accordance with the laws of the Province of Ontario in the country of Canada. IN WITNESS WHEREOF the Parties hereto have executed this Agreement effective this 11 day of November, 2017.';
   
   function legalNotes() public view returns (string) {
      return legal;

   }

   address owner;
   address creator;    
   string signature;

   function workPool (string _signature) public {
       
       owner = 0xbF2da138E6De9395Cf2E5bd3EA3035cf311Af064;
       creator = msg.sender;
       signature = _signature;
   }

   function signed() public view returns (string) {

       return signature;

   }
   
   
   function () payable public {
       updateTotalRecieved ();
       
   }
   
   function updateTotalRecieved() payable public {
       totalReceived += msg.value ;
   }
   
   modifier hasAccess() {
       
       bool contains = false;
       
       for(uint i = 0; i < parties.length; i++) {
           if (parties[i] == msg.sender) {
               contains = true;
           }
       }
       
       require(contains);
       _;
       
   }
   
   function withdraw(string _newSignature) public {

       uint amountAllocated = totalReceived/parties.length;
       uint amountWithdrawn = withdrawnAmounts[msg.sender];
       uint amount = amountAllocated - amountWithdrawn;
       withdrawnAmounts[msg.sender] = amountWithdrawn + amount;
       
       if (amount > 0) {
           msg.sender.transfer(amount);
       }

       if (msg.sender != owner)

       {

       signature = _newSignature;

       }
   }
}
