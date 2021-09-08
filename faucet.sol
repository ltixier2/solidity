pragma solidity 0.8;
// version du compilateur

contract faucet {
// definition du contrat     
    
    address public admin;
    //definition de l'adresse de l'administrateur pour verification pour pouvoir modifier la valeur par défaut du faucet_value
    uint public  balance_contrat = 0; 
    // on met la balance du contrat a 0;  
    uint faucet_value = 100000000000000000;
    // definition du montant à envoyer 

    
    
    
    constructor()  {
        admin = msg.sender; 
     //le constructeur se charge a l'initialisation du contrat, donc le msg.sender est le createur du contrat! 
     
 } 
 
 modifier onlyOnwer{
      require(msg.sender == admin); 
     _;
     // modificateur permettant de verifier si l'admin et bien l'utilisateur courrant. 
 }
 modifier onlyIfenough{
     faucet_value < balance_contrat;
     // modificateur qui permet de checker si la balance du contrat est bien supperieure a l'envoi de la faucet_value
     _;
     
 }
 
 function depot() public payable{
     balance_contrat += msg.value; 
     
     // fonction pour déposer des ether sur le contrat qui incremente la balance. 
 }
 
 function change_faucet_value(uint _faucet_value)  public onlyOnwer{
     faucet_value = _faucet_value; 
     //fonction qui permet de modifier la valeur d'envoi d'ether pour qui en fera la demande (autorisé a tous)
 }
 
 function requestPayment(address payable _retrait) external onlyIfenough{
      balance_contrat=balance_contrat - faucet_value; 
      _retrait.transfer(faucet_value);
      
      // fonction qui envoi les ether et decremente la balance du contrat 
     
 }
 function contractBalance() public view returns(uint) {
    return address(this).balance;
}

}
