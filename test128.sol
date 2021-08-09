pragma solidity ^0.8.0;

import './libraries/FractionTuple128.sol';

contract testing128{
    function _sort(uint128 a, uint128 b) external view returns(uint128, uint128){
        return FractionTuple128.sort(a,b);
    }
    function _sort256(uint256 a, uint256 b) external view returns(uint256, uint256){
        return FractionTuple128.sort256(a,b);
    }
    function _gcd(uint128 a, uint128 b) external view returns(uint128){
        return FractionTuple128.gcd(a,b);
    }
    function _lcm(uint128 a, uint128 b) external view returns(uint128){
        return FractionTuple128.lcm(a,b);
    }
    function _abbreviatable(FractionTuple128.Tuple memory wantedTuple) external view returns(bool){
        return FractionTuple128.abbreviatable(wantedTuple);
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
    function _isbiggerTuple(FractionTuple128.Tuple memory big, FractionTuple128.Tuple memory small) external view returns(bool){
        return FractionTuple128.isbiggerTuple(big, small);
    }
    function _biggerTuple(FractionTuple128.Tuple memory a, FractionTuple128.Tuple memory b) external view returns(FractionTuple128.Tuple memory){
        return FractionTuple128.biggerTuple(a, b);
    }
    function _addTuple(FractionTuple128.Tuple memory a, FractionTuple128.Tuple memory b) external view returns(FractionTuple128.Tuple memory){
        return FractionTuple128.addTuple(a,b);
    }
    function _subtractTuple(FractionTuple128.Tuple memory a, FractionTuple128.Tuple memory subtractingTuple) external view returns(FractionTuple128.Tuple memory){
        return FractionTuple128.subtractTuple(a,subtractingTuple);
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
    function sortingByFixed(FractionTuple128.Tuple memory a, FractionTuple128.Tuple memory b) external view returns(uint256, FractionTuple128.Tuple memory) {
        uint256 _a;
        uint256 _b;
        (_a,_b) = FractionTuple128.sort256(FractionTuple128.toFixed(a), FractionTuple128.toFixed(b));
        FractionTuple128.Tuple memory c;
        FractionTuple128.Tuple memory d;
        if (FractionTuple128.isbiggerTuple(a, b)){
            (c,d) = (a,b);
        } else {
            (c,d) = (b,a);
        }
        require( _a == FractionTuple128.toFixed(c) && _b == FractionTuple128.toFixed(d),"something went wrong, plz let me know if this message shows");
        return (_a, c);
    }
}
