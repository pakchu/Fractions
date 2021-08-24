// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.0;

/**
 * @dev with Solidity 0.8.0 <= version <=0.9.0, the compiler's built in overflow checker made possible for this library not to depend on SafeMath.
 */

library Fractions {
    /**
     * @dev Defining a strtuct for Fractional expression.
     */
    struct Fraction {
        uint256 numerator;
        uint256 denominator;
    }

    function sort(uint256 a, uint256 b) internal pure returns(uint256, uint256){
        if (a > b){
            return (a,b);
        } else return (b,a);
    }
    /**
     * @dev Function for getting greatest common divisor, which is inevitable to operate Fractions.
     * This function is using Euclidean Algoithm, you can find info's here: https://en.wikipedia.org/wiki/Euclidean_algorithm
     * Has time complexity of O(log(min(a,b))), and a nice proof for this: https://www.geeksforgeeks.org/time-complexity-of-euclidean-algorithm/
     */
    function gcd(uint256 a, uint256 b) internal pure returns(uint256){
        (a,b) = sort(a,b);
        while(b != 0) {
            a = a % b;
            (a,b) = sort(a,b);
        }
        return a;
    }
    /** 
     * @dev Function for getting least common multiplier.
     * Has the same time complexity as gcd().
     */
    function lcm(uint256 a, uint256 b) internal pure returns(uint256){
        return (a / gcd(a,b) ) * b;
    }

    /**
     * @dev Check if a Fraction's denominator is 0.
     */

    modifier denominatorIsNotZero(Fraction memory frac) {
        require (frac.denominator != 0, "denominator cannot be 0");
        _;
    }
    /**
     * @dev Has the same time complexity as abbreviate()
     */
    function isAbbreviatable(Fraction memory frac) internal pure denominatorIsNotZero(frac) returns(bool) {
        if(gcd(frac.numerator,frac.denominator) != 1) return true;
        else return false;
    }
    /**
     * @dev Making Fraction into reduced Fraction.
     * Has time complexity of O(log(min(numerator,denominator)))
     */
    function abbreviate(Fraction memory frac)internal pure denominatorIsNotZero(frac) returns (Fraction memory){
        if (isAbbreviatable(frac)) {
            uint256 _gcd = gcd(frac.numerator, frac.denominator);
            return Fraction(frac.numerator / _gcd, frac.denominator / _gcd);
        } else return frac;
    }

    function toReciprocal(Fraction memory frac) internal pure denominatorIsNotZero(frac) returns(Fraction memory){
        require(frac.numerator != 0, "denominator cannot be 0");
        return Fraction(frac.denominator, frac.numerator);
    }
    /**
     * @dev Finding lcm of denominators of two Fractions, and reduce to common denominator with lcm.
     * Has time complexity of O(log(min(a.denominator, b.denominator)))
     */

    function reduceToCommonDenomiantor(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory, Fraction memory){
        uint256 lcm = lcm(a.denominator, b.denominator);
        uint256 numerator0 = (lcm / a.denominator) * a.numerator;
        uint256 numerator1 = (lcm / b.denominator) * b.numerator;
        return (Fraction(numerator0, lcm), Fraction(numerator1, lcm));
    }

    /**
     * @dev Has time complexity of O(log(min(big.denominator, small.denominator)))
     */
    function isGreaterThan(Fraction memory big, Fraction memory small)internal pure denominatorIsNotZero(big) denominatorIsNotZero(small) returns(bool) {
        Fraction memory c;
        Fraction memory d;
        (c, d) = reduceToCommonDenomiantor(big, small);
        if (c.numerator >= d.numerator) return true;
        else return false;
    }

    /**
     * @dev For some use cases which do not need abbreviation.
     * Has the same time complexity as reduceToCommonDenomiantor().
     */
    function _add(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        (a,b) = reduceToCommonDenomiantor(a,b);
        c = Fraction(a.numerator + b.numerator, a.denominator);
    }
    
    /**
     * @dev Has time complexity of O(log(max(min(_add(a,b).numerator, _add(a,b).denominator), min(_add(a,b).numerator, _add(a,b).denominator)))).
     */
    function add(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        c = abbreviate(_add(a,b));
    }
    /**
     * @dev For some use cases which do not need abbreviation.
     * Has the same time complexity as reduceToCommonDenomiantor().
     */
    function _sub(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        require( isGreaterThan(a, b), "Fraction: Underflow" );
        (a,b) = reduceToCommonDenomiantor(a,b);
        c = Fraction( a.numerator - b.numerator, a.denominator );
    }
    /**
     * @dev Has time complexity of O(log(max(min(_sub(a,b).numerator, _sub(a,b).denominator), min(_sub(a,b).numerator, _sub(a,b).denominator)))).
     */
    function sub(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        c = abbreviate(_sub(a,b));
    }
    /**
     * @dev For some use cases which do not need abbreviation.
     */
    function _mul(Fraction memory a, Fraction memory b)internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        c = Fraction(a.numerator * b.numerator, a.denominator * b.denominator);
    }
    /**
     * @dev Has time complexity of O(log(max(min(a.numerator, a.denominator), min(b.numerator, b.denominator), min(a.numerator, b.denominator), min(b.numerator, a.denominator))).
     * max(...) = second or third maximum element of (a.numerator, a.denominator, b.numerator, b.denominator).
     * If the second maximum element is paired with the maximum element at least once, max(...) = second maximum of (...)
     * Else max(...) = third maximum of (...)
     */
    function mul(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory result) {
        a = abbreviate(a);
        b = abbreviate(b);
        Fraction memory c = abbreviate(Fraction(a.numerator , b.denominator));
        Fraction memory d = abbreviate(Fraction(b.numerator , a.denominator));
        result = Fraction(c.numerator * d.numerator , c.denominator * d.denominator);
    }
    /**
     * @dev For some use cases which do not need abbreviation.
     */
    function _div(Fraction memory a, Fraction memory b)internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c) {
        require( b.numerator != 0, "denominator cannot be 0");
        c = _mul(a, toReciprocal(b));
    }
    /**
     * @dev Has time complexity of O(log(max(min(a.numerator, a.denominator), min(b.numerator, b.denominator), min(a.numerator, b.numerator), min(a.denominator, b.denominator))).
     * max(...) = second or third maximum element of (a.numerator, a.denominator, b.numerator, b.denominator).
     * If the second maximum element is paired with the maximum element at least once, max(...) = second maximum of (...)
     * Else max(...) = third maximum of (...)
     */
    function div(Fraction memory a, Fraction memory b) denominatorIsNotZero(a) denominatorIsNotZero(b) internal pure returns(Fraction memory result){
        require(b.numerator != 0, "denominator cannot be 0");
        result = mul(a, toReciprocal(b));
    }
    /**
     * @dev By using this function with proper divider, it can help the Fraction not to overflow.
     * Since dividing both numerator and denomiantor with same number keeps the original value of Fraction,
     * but as in solidity which is only able to express integers, not floats, integer divided by some integer may give out approximated value.
     */
    function preventOverflow(Fraction memory frac, uint256 divider) internal pure denominatorIsNotZero(frac) returns(Fraction memory){
        return abbreviate(Fraction(frac.numerator / divider, frac.denominator / divider));
    }
    /**
     * @dev Has time complexity of O(log(min(frac.numerator - (integer * frac.denominator), frac.denominator))).
     */
    function fractionToMixed(Fraction memory frac) internal pure denominatorIsNotZero(frac) returns(uint256 integer, Fraction memory fraction){
        integer = frac.numerator / frac.denominator;
        fraction = abbreviate(Fraction(frac.numerator - (integer * frac.denominator), frac.denominator));
    }
    /**
     * @dev by giving an uint and [0,1] to this function, it can also work as translator uint -> Fraction.
     +
     * Therefore, using mixedToFraction() -> any computing functions given -> FractionToMixed() -> (result in uint, ) 
     * and the result uint can be more precise than just using uint computations, since uint's computation always round down more than Fraction's round down  
     *
     * Has time complexity of O(log(min(frac.numerator + (integer * frac.denominator), frac.denominator)))
     */
    function mixedToFraction(uint256 integer, Fraction memory frac) internal pure denominatorIsNotZero(frac) returns(Fraction memory){
        return abbreviate(Fraction(frac.numerator + integer * frac.denominator, frac.denominator));
    }
}