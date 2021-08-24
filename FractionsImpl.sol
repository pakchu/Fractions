pragma solidity ^0.8.0;

import './libraries/Fractions.sol';

contract FractionsImpl{

    using Fractions for Fractions.Fraction;
    
    function _sort(uint256 a, uint256 b) public view returns(uint256, uint256){
        return Fractions.sort(a,b);
    }
    function _gcd(uint256 a, uint256 b) public view returns(uint256){
        return Fractions.gcd(a,b);
    }
    function _lcm(uint256 a, uint256 b) public view returns(uint256){
        return Fractions.lcm(a,b);
    }
    function _isAbbreviatable(Fractions.Fraction memory a) public view returns(bool){
        return a.isAbbreviatable();
    }
    function _abbreviate(Fractions.Fraction memory a) public view returns(Fractions.Fraction memory){
        return a.abbreviate();
    }
    function _toReciprocal(Fractions.Fraction memory a) public view returns(Fractions.Fraction memory){
        return a.toReciprocal();
    }
    function _reduceToCommonDenomiantor(Fractions.Fraction memory a, Fractions.Fraction memory b) public view returns(Fractions.Fraction memory, Fractions.Fraction memory){
        return a.reduceToCommonDenomiantor(b);
    }
    function _isGreaterThan(Fractions.Fraction memory big, Fractions.Fraction memory small) public view returns(bool){
        return big.isGreaterThan(small);
    }
    function _addWithOutAbbreviation(Fractions.Fraction memory a, Fractions.Fraction memory b) public view returns(Fractions.Fraction memory){
        return a._add(b);
    }
    function _add(Fractions.Fraction memory a, Fractions.Fraction memory b) public view returns(Fractions.Fraction memory){
        return a.add(b);
    }
    function _subtractWithOutAbbreviation(Fractions.Fraction memory a, Fractions.Fraction memory b) public view returns(Fractions.Fraction memory){
        return a._sub(b);
    }
    function _sub(Fractions.Fraction memory a, Fractions.Fraction memory b) public view returns(Fractions.Fraction memory){
        return a.sub(b);
    }
    function _multiplyWithOutAbbreviation(Fractions.Fraction memory a, Fractions.Fraction memory b) public view returns(Fractions.Fraction memory){
        return a._mul(b);
    }
    function _mul(Fractions.Fraction memory a, Fractions.Fraction memory b) public view returns(Fractions.Fraction memory){
        return a.mul(b);
    }
    function _div(Fractions.Fraction memory a,Fractions.Fraction memory b) public view returns(Fractions.Fraction memory){
        return a.div(b);
    }
    function _divideWithOutAbbreviation(Fractions.Fraction memory a, Fractions.Fraction memory b) public view returns(Fractions.Fraction memory){
        return a._div(b);
    }
    function _preventOverflow(Fractions.Fraction memory a, uint256 b) public view returns(Fractions.Fraction memory){
        return a.preventOverflow(b);
    }
    function fractionToMixed(Fractions.Fraction memory a) public view returns(uint256 integer, Fractions.Fraction memory fraction){
        (integer, fraction) = a.fractionToMixed();
    }
    function _mixedToFraction(uint256 integer, Fractions.Fraction memory fraction) public view returns(Fractions.Fraction memory result){
        result = Fractions.mixedToFraction(integer, fraction);
    }
}
