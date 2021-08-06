pragma solidity ^ 0.8.0;

import './SafeMath.sol';

library FractionTuple {
    using SafeMath for uint256;
    // defining tuple for fraction expression
    struct Tuple {
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
    function gcd(uint256 a, uint256 b) internal view returns(uint256){
        (a,b) = sort(a,b);
        while(b != 0 ) {
            a = a % b;
            (a,b) = sort(a,b);
        }
        return a;
    }
    // function for getting least common multiplier
    function lcm(uint256 a, uint256 b) internal view returns(uint256){
        return (a / gcd(a,b) ).mul(b);
    }
    // is tuple a reduced fraction 
    function abbreviatable(Tuple memory wantedTuple) internal view returns(bool) {
        if(gcd(wantedTuple.numerator,wantedTuple.denominator) != 1) return true;
        else return false;
    }
    // check if denominator is not 0
    modifier zeroDivide(Tuple memory tuple) {
        require (tuple.denominator != 0, "denominator cannot be 0");
        _;
    }
    // making tuple into reduced fraction
    function abbreviate(Tuple memory wantedTuple)internal view zeroDivide(wantedTuple) returns (Tuple memory){
        if (abbreviatable(wantedTuple)) {
            uint256 _gcd = gcd(wantedTuple.numerator, wantedTuple.denominator);
            return Tuple(wantedTuple.numerator / _gcd, wantedTuple.denominator / _gcd);
        } else return wantedTuple;
    }
    
    function reverseTuple(Tuple memory wantedTuple) internal view zeroDivide(wantedTuple) returns(Tuple memory result){
        require(wantedTuple.numerator != 0, "denominator cannot be 0");
        result = Tuple( wantedTuple.denominator, wantedTuple.numerator );
        return result;
    }
    // finding lcm of denominators of two tuples
    function commonDenominator(Tuple memory a, Tuple memory b) internal view zeroDivide(a) zeroDivide(b) returns(Tuple memory, Tuple memory){
        uint256 lcm = lcm(a.denominator, b.denominator);
        uint256 numerator0 = ( lcm / a.denominator ).mul(a.numerator);
        uint256 numerator1 = (lcm / b.denominator).mul(b.numerator);
        return (Tuple(numerator0, lcm), Tuple(numerator1, lcm));
    }
    
    function biggerTuple(Tuple memory big, Tuple memory small)internal view zeroDivide(big) zeroDivide(small) returns(bool) {
        Tuple memory c;
        Tuple memory d;
        (c, d) = commonDenominator(big, small);
        if (c.numerator >= d.numerator) return true;
        else return false;
    }

    function addTuple(Tuple memory a, Tuple memory b) internal view zeroDivide(a) zeroDivide(b) returns(Tuple memory c){
        (a,b) = commonDenominator(a,b);
        c = abbreviate(Tuple( a.numerator.add(b.numerator) , a.denominator ));
        return c;
    }
    
    function subtractTuple(Tuple memory a, Tuple memory b) internal view zeroDivide(a) zeroDivide(b) returns(Tuple memory c){
        require( biggerTuple(a, b), "Tuple: Underflow" );
        (a,b) = commonDenominator(a,b);
        c = abbreviate(Tuple( a.numerator.sub(b.numerator) , a.denominator ));
        return c;
    }
    
    function multiplyTuple(Tuple memory a, Tuple memory b) internal view zeroDivide(a) zeroDivide(b) returns(Tuple memory result) {
        a = abbreviate(a);
        b = abbreviate(b);
        Tuple memory c = abbreviate(Tuple( a.numerator , b.denominator));
        Tuple memory d = abbreviate(Tuple( b.numerator , a.denominator));
        result = Tuple( c.numerator.mul(d.numerator) , c.denominator.mul(d.denominator));
        return result;
    }
    // for gas saving
    function simpleMultiplyTuple(Tuple memory a, Tuple memory b)internal view zeroDivide(a) zeroDivide(b) returns(Tuple memory c){
        c = abbreviate(Tuple(a.numerator.mul(b.numerator) , a.denominator.mul(b.denominator)));
        return c;
    }

    function divideTuple(Tuple memory a, Tuple memory dividingTuple) zeroDivide(a) zeroDivide(dividingTuple) internal view returns(Tuple memory result){
        require(dividingTuple.numerator != 0, "denominator cannot be 0");
        result = multiplyTuple(a, reverseTuple(dividingTuple));
        return result;
    }
    // for gas saving
    function simpleDivideTuple(Tuple memory a, Tuple memory dividingTuple)internal view zeroDivide(a) zeroDivide(dividingTuple) returns(Tuple memory c) {
        require( dividingTuple.numerator != 0, "denominator cannot be 0");
        c = simpleMultiplyTuple(a, reverseTuple(dividingTuple));
        return c;
    }
}
