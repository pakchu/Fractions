pragma solidity ^0.8.0;

import './libraries/FractionTuple.sol';
import './libraries/SafeMath.sol';

contract testing{
    using SafeMath for uint256;
    
    function _sort(uint256 a, uint256 b) external view returns(uint256, uint256){
        return FractionTuple.sort(a,b);
    }
    function _gcd(uint256 a, uint256 b) external view returns(uint256){
        return FractionTuple.gcd(a,b);
    }
    function _lcm(uint256 a, uint256 b) external view returns(uint256){
        return FractionTuple.lcm(a,b);
    }
    function _abbreviate(FractionTuple.Tuple memory wantedTuple) external view returns(FractionTuple.Tuple memory){
        return FractionTuple.abbreviate(wantedTuple);
    }
    function _reverseTuple(FractionTuple.Tuple memory wantedTuple) external view returns(FractionTuple.Tuple memory){
        return FractionTuple.reverseTuple(wantedTuple);
    }
    function _commonDenominator(FractionTuple.Tuple memory a, FractionTuple.Tuple memory b) external view returns(FractionTuple.Tuple memory, FractionTuple.Tuple memory){
        return FractionTuple.commonDenominator(a,b);
    }
    function _biggerTuple(FractionTuple.Tuple memory big, FractionTuple.Tuple memory small) external view returns(bool){
        return FractionTuple.biggerTuple(big, small);
    }
    function _addTuple(FractionTuple.Tuple memory a, FractionTuple.Tuple memory b) external view returns(FractionTuple.Tuple memory){
        return FractionTuple.addTuple(a,b);
    }
    function _subtractTuple(FractionTuple.Tuple memory a, FractionTuple.Tuple memory b) external view returns(FractionTuple.Tuple memory){
        return FractionTuple.subtractTuple(a,b);
    }
    function _simpleMultiplyTuple(FractionTuple.Tuple memory a, FractionTuple.Tuple memory b) external view returns(FractionTuple.Tuple memory){
        return FractionTuple.simpleMultiplyTuple(a,b);
    }
    function _multiplyTuple(FractionTuple.Tuple memory a, FractionTuple.Tuple memory b) external view returns(FractionTuple.Tuple memory){
        return FractionTuple.multiplyTuple(a,b);
    }
    function _divideTuple(FractionTuple.Tuple memory a, FractionTuple.Tuple memory dividingTuple) external view returns(FractionTuple.Tuple memory){
        return FractionTuple.divideTuple(a, dividingTuple);
    }
    function _simpleDivideTuple(FractionTuple.Tuple memory a, FractionTuple.Tuple memory dividingTuple) external view returns(FractionTuple.Tuple memory){
        return FractionTuple.simpleDivideTuple(a, dividingTuple);
    }
}







