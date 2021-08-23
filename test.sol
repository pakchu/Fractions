pragma solidity ^0.8.0;

import './libraries/fractionLib.sol';

contract testing{

    using fractionLib for fractionLib.Fraction;
    
    function _sort(uint256 a, uint256 b) public view returns(uint256, uint256){
        return fractionLib.sort(a,b);
    }
    function _gcd(uint256 a, uint256 b) public view returns(uint256){
        return fractionLib.gcd(a,b);
    }
    function _lcm(uint256 a, uint256 b) public view returns(uint256){
        return fractionLib.lcm(a,b);
    }
    function _isAbbreviatable(fractionLib.Fraction memory a) public view returns(bool){
        return a.isAbbreviatable();
    }
    function _abbreviate(fractionLib.Fraction memory a) public view returns(fractionLib.Fraction memory){
        return a.abbreviate();
    }
    function _toReciprocal(fractionLib.Fraction memory a) public view returns(fractionLib.Fraction memory){
        return a.toReciprocal();
    }
    function _reduceToCommonDenomiantor(fractionLib.Fraction memory a, fractionLib.Fraction memory b) public view returns(fractionLib.Fraction memory, fractionLib.Fraction memory){
        return a.reduceToCommonDenomiantor(b);
    }
    function _isGreaterThan(fractionLib.Fraction memory big, fractionLib.Fraction memory small) public view returns(bool){
        return big.isGreaterThan(small);
    }
    function _addWithOutAbbreviation(fractionLib.Fraction memory a, fractionLib.Fraction memory b) public view returns(fractionLib.Fraction memory){
        return a._add(b);
    }
    function _add(fractionLib.Fraction memory a, fractionLib.Fraction memory b) public view returns(fractionLib.Fraction memory){
        return a.add(b);
    }
    function _subtractWithOutAbbreviation(fractionLib.Fraction memory a, fractionLib.Fraction memory b) public view returns(fractionLib.Fraction memory){
        return a._sub(b);
    }
    function _sub(fractionLib.Fraction memory a, fractionLib.Fraction memory b) public view returns(fractionLib.Fraction memory){
        return a.sub(b);
    }
    function _multiplyWithOutAbbreviation(fractionLib.Fraction memory a, fractionLib.Fraction memory b) public view returns(fractionLib.Fraction memory){
        return a._mul(b);
    }
    function _mul(fractionLib.Fraction memory a, fractionLib.Fraction memory b) public view returns(fractionLib.Fraction memory){
        return a.mul(b);
    }
    function _div(fractionLib.Fraction memory a,fractionLib.Fraction memory b) public view returns(fractionLib.Fraction memory){
        return a.div(b);
    }
    function _divideWithOutAbbreviation(fractionLib.Fraction memory a, fractionLib.Fraction memory b) public view returns(fractionLib.Fraction memory){
        return a._div(b);
    }
    function _preventOverflow(fractionLib.Fraction memory a, uint256 b) public view returns(fractionLib.Fraction memory){
        return a.preventOverflow(b);
    }
    function fractionToMixed(fractionLib.Fraction memory a) public view returns(uint256 integer, fractionLib.Fraction memory fraction){
        (integer, fraction) = a.fractionToMixed();
    }
    function _mixedToFraction(uint256 integer, fractionLib.Fraction memory fraction) public view returns(fractionLib.Fraction memory result){
        result = fractionLib.mixedToFraction(integer, fraction);
    }
}
