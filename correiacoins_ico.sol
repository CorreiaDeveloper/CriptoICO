pragma solidity ^0.4.11;

contract correiacoin_ico {
    //Numero maximo de correiacoins disponiveis no ICO
    uint public max_correiacoins = 1000000;

    //Cotacao Correiacoins para dolar
    uint public usd_to_correiacoins = 1000;

    //Total de correiacoins que foram compradas por investidores
    uint public total_correiacoins_bought = 0;

    //Funcao de equivalencia
    mapping(address => uint) equity_correiacoins;
    mapping(address => uint) equity_usd;

    //Verificando se o investidor pode comprar correiacoins
    modifier can_buy_correiacoins(uint usd_invested){
        require (usd_invested * usd_to_correiacoins + total_correiacoins_bought <= max_correiacoins);
        _;
    }

    //Retorna o valor do investimento em correiacoins
    function equity_in_correiacoins(address investor) external constant returns(uint){
        return equity_correiacoins[investor];
    }

        //Retorna o valor do investimento em usd
    function equity_in_usd(address investor) external constant returns(uint){
        return equity_usd[investor];
    }

    //Compra de correiacoins
    function buy_correiacoins(address investor, uint usd_invested) external can_buy_correiacoins(usd_invested){
        uint correiacoins_bought = usd_invested * usd_to_correiacoins;
        equity_correiacoins[investor] += correiacoins_bought;
        equity_usd[investor] = equity_correiacoins[investor] / 1000;
        total_correiacoins_bought += correiacoins_bought;
    }

    //Venda de correiacoins
    function sell_correiacoins(address investor, uint correiacoins_sold) external {
        equity_correiacoins[investor] -= correiacoins_sold;
        equity_usd[investor] = equity_correiacoins[investor] / 1000;
        total_correiacoins_bought += correiacoins_sold;
    }
}