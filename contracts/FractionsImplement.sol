pragma solidity ^0.8.0;

import './libraries/Fractions.sol';

contract FractionsImpl{
    using Fractions for Fractions.Fraction;

    uint256 v;
    uint256 w;
    uint256 x;
    uint256 y;
    Fractions.Fraction public a;
    Fractions.Fraction public b;
    
    constructor(
        uint256 _v,
        uint256 _w,
        uint256 _x,
        uint256 _y
    )
    {
        v = _v;
        w = _w;
        x = _x;
        y = _y;
        a = Fractions.Fraction(_v,_w);
        b = Fractions.Fraction(_x,_y);
    }
    
    // funtion setter(
    //     uint256 _v,
    //     uint256 _w,
    //     uint256 _x,
    //     uint256 _y
    //     ) external {
    //     v = _v;
    //     w = _w;
    //     x = _x;
    //     y = _y;
    //     a = Fractions.Fraction(_v,_w);
    //     b = Fractions.Fraction(_x,_y);
    //     }

    function gcdTest() external view returns(bool){
        uint256 gcd = Fractions.gcd(v,w);
        if (v % gcd == 0 && w % gcd == 0) return true;
        else return false;
    }
    function lcmTest() external view returns(bool){
        if (v * w != 0){
            uint256 lcm = Fractions.lcm(v,w);
            if (lcm % v == 0 && lcm % w == 0) return true;
            else return false;
        } else return true;
    }
    function abbreviateTest() external view returns(bool){
        Fractions.Fraction memory abbreviated = Fractions.Fraction(v,w).abbreviate();
        if(Fractions.gcd(abbreviated.numerator, abbreviated.denominator) == 1) return true;
        else return false;
    }
    function reduceTest() external view returns(bool){
        Fractions.Fraction memory c;
        Fractions.Fraction memory d;
        (c,d) = Fractions.reduceToCommonDenominator(a,b);
        // if ((a.abbreviate(), b.abbreviate()) == (c.abbreviate(), d.abbreviate())) return true;
        bool boo0 = a.abbreviate().numerator == c.abbreviate().numerator;
        bool boo1 = a.abbreviate().denominator == c.abbreviate().denominator;
        bool boo2 = b.abbreviate().numerator == d.abbreviate().numerator;
        bool boo3 = a.abbreviate().denominator == c.abbreviate().denominator;
        if (boo0 && boo1 && boo2 && boo3) return true;
        else return false;
    }
    function addAndSubTest() external view returns(bool){
        // if (a.add(b).sub(a).sub(b) == Fractions.Fraction(0,1)) return true;
        bool boo0 = a.add(b).sub(a).sub(b).numerator == 0;
        bool boo1 = a.add(b).sub(a).sub(b).denominator == 1;
        if (boo0 && boo1) return true;
        else return false;
    }
    function mulAndDivTest() external view returns(bool){
        // if (a.mul(b).div(a).div(b) == Fractions.Fraction(1,1)) return true;
        if( v * w * x * y !=0){
            bool boo0 = a.mul(b).div(a).div(b).numerator == 1;
            bool boo1 = a.mul(b).div(a).div(b).denominator == 1;
            if (boo0 && boo1) return true;
            else return false;
        } else return true;
    }
}
