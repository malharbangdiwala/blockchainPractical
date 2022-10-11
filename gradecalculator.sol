
//Malhar Bangdiwala BE Comps 2019130005
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract GradeSystem{
    function grader(uint m1, uint m2, uint m3, uint m4, uint m5) public pure returns (string memory){
        uint sum=m1+m2+m3+m4+m5;
        if(sum>=90){
            return "Grade A";
        }
        else if(sum >=70){
            return "Grade B";
        }
        else if (sum>=40){
            return "Grade C";
        }
        else{
            return "Fail";
        }
    }
}