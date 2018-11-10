pragma solidity ^0.4.20;

contract MyToken {
    /* Funzioni Vuote che possono essere chiamate dai clienti dell' etherum Wallet
    per tenere traccia  delle attività che avvengono nel contratto*/    
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* This creates an array with all balances */
    /* mapping è un array associativo, ovvero associazione 
     * dell'indirizzo con il balances
     * adress è in formato esadecimale
     * balace è un intero che va da 0 a 115 virgintili???
     * public render la variabile pubblica a tutti gli utenti della block chain.
     * quindi tutti i balance sono pubblici e visibili
     */
    mapping (address => uint256) public balanceOf;

    /* variabili pubbliche del contratto
     * inizializzate al momento della uploa del contratto nel network
     */
    string public name;
    string public symbol;
    uint8 public decimal;
    
    /* Initializes contract with initial supply tokens to the creator of the contract */
    /* Creazione di alcuni tocken alla generazione del contratto 
     * il costruttore viene eseguito solo una volta  quando il contratto è caricato
     * nella rete 
     * 
     * initalSupplay : ammountare di token che si vogliono creare
     * msg.sender : l'utente che ha sviluppato il contratto
     * setto il bilancio dell'utente che ha sviluppato questo contratto a 21 milioni
     */
    constructor (
        uint256 initialSupplay,
        string tokenName,
        string tokenSymbol,
        uint8 decimalUnits
        ) public {
        balanceOf[msg.sender] = initialSupplay;              // Give the creator all initial tokens
        name = tokenName;
        symbol = tokenSymbol;
        decimal = decimalUnits;
    }

    /* Traferimento Token */
    /* Metodo per il traferimensto dei tocken da un utente ad un altro */
    function transfer(address _to, uint256 _value) public {
        /*l'esecuzione del seguente contratto verrà fermata  se chi invia il token
        * non ne ha abbastanza: Prevenzione del debito*/
        /*cosi facendo prevengo la perdita di token per chi invia ??*/
        require(balanceOf[msg.sender] >= _value  && balanceOf[_to] + _value >= balanceOf[_to]);
        
        /* togli l'ammontare di _value all'utente del contratto*/
        balanceOf[msg.sender] -= _value;
        /* aggiungi all'ammontare di _value all'utente x*/
        balanceOf[_to] += _value;
        
        /*notifico a chiuche in ascolto che il trasferimento sta prendendo piede*/
        emit Transfer(msg.sender, _to, _value);
    }
}
