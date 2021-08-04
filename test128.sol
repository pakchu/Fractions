pragma solidity ^0.8.0;

import './libraries/FractionTuple128.sol';
import './libraries/SafeMath128.sol';

contract testing{
    using SafeMath128 for uint128;
    
    function _sort(uint128 a, uint128 b) external view returns(uint128, uint128){
        return FractionTuple128.sort(a,b);
    }
    function _sor256t(uint256 a, uint256 b) external view returns(uint256, uint256){
        return FractionTuple128.sort256(a,b);
    }
    function _gcd(uint128 a, uint128 b) external view returns(uint128){
        return FractionTuple128.gcd(a,b);
    }
    function _lcm(uint128 a, uint128 b) external view returns(uint128){
        return FractionTuple128.lcm(a,b);
    }
    function _abbreviate(FractionTuple128.Tuple memory wantedTuple) external view returns(FractionTuple128.Tuple memory){
        return FractionTuple128.abbreviate(wantedTuple);
    }
    function _reverseTuple(FractionTuple128.Tuple memory wantedTuple) external view returns(FractionTuple128.Tuple memory){
        return FractionTuple128.reverseTuple(wantedTuple);
    }
    function _commonDenominator(FractionTuple128.Tuple memory a, FractionTuple128.Tuple memory b) external view returns(FractionTuple128.Tuple memory, FractionTuple128.Tuple memory){
        return FractionTuple128.commonDenominator(a,b);
    }
    function _biggerTuple(FractionTuple128.Tuple memory big, FractionTuple128.Tuple memory small) external view returns(bool){
        return FractionTuple128.biggerTuple(big, small);
    }
    function _addTuple(FractionTuple128.Tuple memory a, FractionTuple128.Tuple memory b) external view returns(FractionTuple128.Tuple memory){
        return FractionTuple128.addTuple(a,b);
    }
    function _subtractTuple(FractionTuple128.Tuple memory a, FractionTuple128.Tuple memory b) external view returns(FractionTuple128.Tuple memory){
        return FractionTuple128.subtractTuple(a,b);
    }
    function _simpleMultiplyTuple(FractionTuple128.Tuple memory a, FractionTuple128.Tuple memory b) external view returns(FractionTuple128.Tuple memory){
        return FractionTuple128.simpleMultiplyTuple(a,b);
    }
    function _multiplyTuple(FractionTuple128.Tuple memory a, FractionTuple128.Tuple memory b) external view returns(FractionTuple128.Tuple memory){
        return FractionTuple128.multiplyTuple(a,b);
    }
    function _divideTuple(FractionTuple128.Tuple memory a, FractionTuple128.Tuple memory dividingTuple) external view returns(FractionTuple128.Tuple memory){
        return FractionTuple128.divideTuple(a, dividingTuple);
    }
    function _simpleDivideTuple(FractionTuple128.Tuple memory a, FractionTuple128.Tuple memory dividingTuple) external view returns(FractionTuple128.Tuple memory){
        return FractionTuple128.simpleDivideTuple(a, dividingTuple);
    }
    function _toFixed(FractionTuple128.Tuple memory a) external view returns(uint256){
        return FractionTuple128.toFixed(a);
    }
}







