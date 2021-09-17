//SPDX-License-Identifier: MIT;

pragma solidity >=0.4.22 <0.8.4;

import "./adamant.sol";

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract dis is Ownable {
    MAP inter = MAP(0xd9145CCE52D386f254917e481eB44e9943F39138);

    uint256 fees = 100;

    address MarAdd = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    function updateFees(uint256 _fee) public onlyOwner {
        fees = _fee;
    }

    function updateMar(address _new) public onlyOwner {
        MarAdd = _new;
    }

    function claim(uint256 _blocks) public {
        inter.transfer(msg.sender, _blocks * (fees / 5));
        inter.transfer(
            0x000000000000000000000000000000000000dEaD,
            _blocks * ((fees * 3) / 5)
        );
        inter.transfer(MarAdd, _blocks * (fees / 5));
    }
}
