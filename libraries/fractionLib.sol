pragma solidity ^ 0.8.0;

import './SafeMath.sol';

library fractionLib {
    using SafeMath for uint256;
    // defining a strtuct for fraction expression
    struct Fraction {
        uint256 numerator;
        uint256 denominator;
    }
    // odering numbers by their size
    function sort(uint256 a, uint256 b) internal pure returns(uint256, uint256){
        if (a > b){
            return (a,b);
        } else return (b,a);
    }
    // function for getting greatest common diviosor which is pretty useful operating fractions
    // using Euclidean Algoithm, you can find info's here: https://en.wikipedia.org/wiki/Euclidean_algorithm
    // it has time complexity of: O(log(min(a,b))) = O(log(n)), and nice proof for this: https://www.geeksforgeeks.org/time-complexity-of-euclidean-algorithm/
    function gcd(uint256 a, uint256 b) internal pure returns(uint256){
        (a,b) = sort(a,b);
        while(b != 0 ) {
            a = a % b;
            (a,b) = sort(a,b);
        }
        return a;
    }
    // function for getting least common multiplier
    function lcm(uint256 a, uint256 b) internal pure returns(uint256){
        return (a / gcd(a,b) ).mul(b);
    }
    // check if a Fraction's denominator is 0
    modifier denominatorIsNotZero(Fraction memory frac) {
        require (frac.denominator != 0, "denominator cannot be 0");
        _;
    }
    // is Fraction a reducible fraction 
    function isAbbreviatable(Fraction memory frac) internal pure denominatorIsNotZero(frac) returns(bool) {
        if(gcd(frac.numerator,frac.denominator) != 1) return true;
        else return false;
    }
    // making Fraction into reduced fraction
    function abbreviate(Fraction memory frac)internal pure denominatorIsNotZero(frac) returns (Fraction memory){
        if (isAbbreviatable(frac)) {
            uint256 _gcd = gcd(frac.numerator, frac.denominator);
            return Fraction(frac.numerator / _gcd, frac.denominator / _gcd);
        } else return frac;
    }
    
    function toReciprocal(Fraction memory frac) internal pure denominatorIsNotZero(frac) returns(Fraction memory){
        require(frac.numerator != 0, "denominator cannot be 0");
        return Fraction( frac.denominator, frac.numerator );
    }
    // finding lcm of denominators of two Fractions
    function reduceToCommonDenomiantor(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory, Fraction memory){
        uint256 lcm = lcm(a.denominator, b.denominator);
        uint256 numerator0 = (lcm / a.denominator).mul(a.numerator);
        uint256 numerator1 = (lcm / b.denominator).mul(b.numerator);
        return (Fraction(numerator0, lcm), Fraction(numerator1, lcm));
    }
    
    function isGreaterThan(Fraction memory big, Fraction memory small)internal pure denominatorIsNotZero(big) denominatorIsNotZero(small) returns(bool) {
        Fraction memory c;
        Fraction memory d;
        (c, d) = reduceToCommonDenomiantor(big, small);
        if (c.numerator >= d.numerator) return true;
        else return false;
    }

    // for some uses which do not need abbreviation
    function _add(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        (a,b) = reduceToCommonDenomiantor(a,b);
        c = Fraction( a.numerator.add(b.numerator) , a.denominator );
    }
    
    function add(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        c = abbreviate(_add(a,b));
    }
    // for some uses which do not need abbreviation
    function _sub(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        require( isGreaterThan(a, b), "Fraction: Underflow" );
        (a,b) = reduceToCommonDenomiantor(a,b);
        c = Fraction( a.numerator.sub(b.numerator) , a.denominator );
    }

    function sub(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        c = abbreviate(_sub(a,b));
    }
    // for some uses which do not need abbreviation
    function _mul(Fraction memory a, Fraction memory b)internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        c = Fraction(a.numerator.mul(b.numerator) , a.denominator.mul(b.denominator));
    }
    
    function mul(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory result) {
        a = abbreviate(a);
        b = abbreviate(b);
        Fraction memory c = abbreviate(Fraction( a.numerator , b.denominator));
        Fraction memory d = abbreviate(Fraction( b.numerator , a.denominator));
        result = Fraction( c.numerator.mul(d.numerator) , c.denominator.mul(d.denominator));
    }
    // for some uses which do not need abbreviation
    function _div(Fraction memory a, Fraction memory b)internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c) {
        require( b.numerator != 0, "denominator cannot be 0");
        c = _mul(a, toReciprocal(b));
    }
    function div(Fraction memory a, Fraction memory b) denominatorIsNotZero(a) denominatorIsNotZero(b) internal pure returns(Fraction memory result){
        require(b.numerator != 0, "denominator cannot be 0");
        result = mul(a, toReciprocal(b));
    }
    // by adjusting divider, it can help the Fraction not to overflow.
    // since dividing both numerator and denomiantor with same number keeps the original value of fraction,
    // but as in solidity which is only able to express integers not floats, integers divided by some integers give out approximated value
    function preventOverflow(Fraction memory frac, uint256 divider) internal pure denominatorIsNotZero(frac) returns(Fraction memory){
        return Fraction(frac.numerator / divider, frac.denominator / divider);
    }
    function fractionToMixed(Fraction memory a) internal pure denominatorIsNotZero(a) returns(uint256 integer, Fraction memory fraction){
        integer = a.numerator / a.denominator;
        fraction = abbreviate(Fraction(a.numerator.sub((integer.mul(a.denominator))), a.denominator));
    }
    // by giving an uint and [0,1] to this function, it can also work as translator uint -> Fraction
    // therefore, using mixedToFraction() -> any computing functions given -> fractionToMixed() -> (result in uint, ) 
    // and the result uint can be more precise than just using uint computations, since uint's computation always round down more than Fraction's round down    
    function mixedToFraction(uint256 integer, Fraction memory fraction) internal pure denominatorIsNotZero(fraction) returns(Fraction memory result){
        result = abbreviate(Fraction(fraction.numerator.add( integer.mul(fraction.denominator)), fraction.denominator));
    }
}
