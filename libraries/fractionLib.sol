pragma solidity ^ 0.8.0;

// with Solidity 0.8 or later, the compiler's built in overflow checks made this library does not need to depend on SafeMath

library fractionLib {
    // defining a strtuct for fraction expression
    struct Fraction {
        uint256 numerator;
        uint256 denominator;
    }
    // odering numbers by their size
    // ***********has time complexity of O(1)
    function sort(uint256 a, uint256 b) internal pure returns(uint256, uint256){
        if (a > b){
            return (a,b);
        } else return (b,a);
    }
    // function for getting greatest common diviosor which is pretty useful operating fractions
    // using Euclidean Algoithm, you can find info's here: https://en.wikipedia.org/wiki/Euclidean_algorithm
    // ***********has time complexity of O(log(min(a,b))), and a nice proof for this: https://www.geeksforgeeks.org/time-complexity-of-euclidean-algorithm/
    function gcd(uint256 a, uint256 b) internal pure returns(uint256){
        (a,b) = sort(a,b);
        while(b != 0) {
            a = a % b;
            (a,b) = sort(a,b);
        }
        return a;
    }
    // function for getting least common multiplier
    // ***********has time complexity of O(log(min(a,b)))
    function lcm(uint256 a, uint256 b) internal pure returns(uint256){
        return (a / gcd(a,b) ) * b;
    }
    // check if a Fraction's denominator is 0
    modifier denominatorIsNotZero(Fraction memory frac) {
        require (frac.denominator != 0, "denominator cannot be 0");
        _;
    }
    // is Fraction a reducible fraction 
    // ***********has time complexity of O(log(min(numerator,denominator)))
    function isAbbreviatable(Fraction memory frac) internal pure denominatorIsNotZero(frac) returns(bool) {
        if(gcd(frac.numerator,frac.denominator) != 1) return true;
        else return false;
    }
    // making Fraction into reduced fraction
    // ***********has time complexity of O(log(min(numerator,denominator)))
    function abbreviate(Fraction memory frac)internal pure denominatorIsNotZero(frac) returns (Fraction memory){
        if (isAbbreviatable(frac)) {
            uint256 _gcd = gcd(frac.numerator, frac.denominator);
            return Fraction(frac.numerator / _gcd, frac.denominator / _gcd);
        } else return frac;
    }
    // ***********has time complexity of O(1)
    function toReciprocal(Fraction memory frac) internal pure denominatorIsNotZero(frac) returns(Fraction memory){
        require(frac.numerator != 0, "denominator cannot be 0");
        return Fraction( frac.denominator, frac.numerator );
    }
    // finding lcm of denominators of two Fractions
    // ***********has time complexity of O(log(max(min(a.numerator, a.denominator), min(b.numerator, b.denominator)))))
    function reduceToCommonDenomiantor(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory, Fraction memory){
        uint256 lcm = lcm(a.denominator, b.denominator);
        uint256 numerator0 = (lcm / a.denominator) * a.numerator;
        uint256 numerator1 = (lcm / b.denominator) * b.numerator;
        return (Fraction(numerator0, lcm), Fraction(numerator1, lcm));
    }
    // ***********has time complexity of O(log(max(min(big.numerator, big.denominator), min(small.numerator, small.denominator)))))
    function isGreaterThan(Fraction memory big, Fraction memory small)internal pure denominatorIsNotZero(big) denominatorIsNotZero(small) returns(bool) {
        Fraction memory c;
        Fraction memory d;
        (c, d) = reduceToCommonDenomiantor(big, small);
        if (c.numerator >= d.numerator) return true;
        else return false;
    }

    // for some uses which do not need abbreviation
    // ***********has time complexity of O(log(max(min(a.numerator, a.denominator), min(b.numerator, b.denominator)))))
    function _add(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        (a,b) = reduceToCommonDenomiantor(a,b);
        c = Fraction( a.numerator + b.numerator, a.denominator );
    }
    // ***********has time complexity of O(log(max(min(a.numerator, a.denominator), min(b.numerator, b.denominator)))))
    function add(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        c = abbreviate(_add(a,b));
    }
    // for some uses which do not need abbreviation
    // ***********has time complexity of O(log(max(min(a.numerator, a.denominator), min(b.numerator, b.denominator)))))
    function _sub(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        require( isGreaterThan(a, b), "Fraction: Underflow" );
        (a,b) = reduceToCommonDenomiantor(a,b);
        c = Fraction( a.numerator - b.numerator, a.denominator );
    }
    // ***********has time complexity of O(log(max(min(a.numerator, a.denominator), min(b.numerator, b.denominator)))))
    function sub(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        c = abbreviate(_sub(a,b));
    }
    // for some uses which do not need abbreviation
    // ***********has time complexity of O(1)
    function _mul(Fraction memory a, Fraction memory b)internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c){
        c = Fraction(a.numerator * b.numerator, a.denominator * b.denominator);
    }
    // ***********has time complexity of O(log(max(min(a.numerator, a.denominator), min(b.numerator, b.denominator)))))
    function mul(Fraction memory a, Fraction memory b) internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory result) {
        a = abbreviate(a);
        b = abbreviate(b);
        Fraction memory c = abbreviate(Fraction( a.numerator , b.denominator));
        Fraction memory d = abbreviate(Fraction( b.numerator , a.denominator));
        result = Fraction( c.numerator * d.numerator , c.denominator * d.denominator);
    }
    // for some uses which do not need abbreviation
    // ***********has time complexity of O(1)
    function _div(Fraction memory a, Fraction memory b)internal pure denominatorIsNotZero(a) denominatorIsNotZero(b) returns(Fraction memory c) {
        require( b.numerator != 0, "denominator cannot be 0");
        c = _mul(a, toReciprocal(b));
    }
    // ***********has time complexity of O(log(max(min(a.numerator, a.denominator), min(b.numerator, b.denominator)))))
    function div(Fraction memory a, Fraction memory b) denominatorIsNotZero(a) denominatorIsNotZero(b) internal pure returns(Fraction memory result){
        require(b.numerator != 0, "denominator cannot be 0");
        result = mul(a, toReciprocal(b));
    }
    // by adjusting divider, it can help the Fraction not to overflow.
    // since dividing both numerator and denomiantor with same number keeps the original value of fraction,
    // but as in solidity which is only able to express integers not floats, integers divided by some integers give out approximated value
    // ***********has time complexity of O(1)
    function preventOverflow(Fraction memory frac, uint256 divider) internal pure denominatorIsNotZero(frac) returns(Fraction memory){
        return abbreviate(Fraction(frac.numerator / divider, frac.denominator / divider));
    }
    // ***********has time complexity of O(log(min(frac.numerator - (integer * frac.denominator), frac.denominator)))
    function fractionToMixed(Fraction memory frac) internal pure denominatorIsNotZero(frac) returns(uint256 integer, Fraction memory fraction){
        integer = frac.numerator / frac.denominator;
        fraction = abbreviate(Fraction(frac.numerator - (integer * frac.denominator), frac.denominator));
    }
    // by giving an uint and [0,1] to this function, it can also work as translator uint -> Fraction
    // therefore, using mixedToFraction() -> any computing functions given -> fractionToMixed() -> (result in uint, ) 
    // and the result uint can be more precise than just using uint computations, since uint's computation always round down more than Fraction's round down    
    // ***********has time complexity of O(log(min(frac.numerator + (integer * frac.denominator), frac.denominator)))
    function mixedToFraction(uint256 integer, Fraction memory frac) internal pure denominatorIsNotZero(frac) returns(Fraction memory result){
        result = abbreviate(Fraction(frac.numerator + integer * frac.denominator, frac.denominator));
    }
}
