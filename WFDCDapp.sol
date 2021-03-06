pragma solidity 0.8.0;

contract WFDCDapp {

  string private version = "v2";

  uint256 private DappReward = 25000;

  address private WFDCContract = 0x63D6e1E46d3b72D2BB30D3A8D2C811cCb180Ab60;
    
  WrappedFreedomDividendCoin private WFDCToken;
  
  constructor() {
    WFDCToken = WrappedFreedomDividendCoin(WFDCContract);
  }

  function dappCollectFreedomDividend(address Address) external returns (bool) {

    WFDCToken.collectFreedomDividendWithAddress(Address);
    
    uint rewardLeft = WFDCToken.balanceOf(address(this));

    if (rewardLeft >= DappReward) {
      WFDCToken.transfer(Address, DappReward);
    }

    return true;
  }

  function getVersion() external view returns (string memory) {
    return version;
  }

}

interface WrappedFreedomDividendCoin {
    function balanceOf(address owner) external returns(uint);
    function transfer(address to, uint256 value) external returns(bool);
    function collectFreedomDividendWithAddress(address collectionAddress) external returns(bool);
}