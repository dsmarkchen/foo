# !/bin/awk
# markc Apr 2013
# Brief: check leap year 
# Usage: 
#   echo "2013" | awk -f leapyear.awk
#
# Autotest:
#   echo "AUTOTEST" | awk -f leapyear.awk   

# use the algoirthm from wiki to determine leap year
function IsLeapYear(year)
{
    if(year % 400 == 0) return 1;
    else if(year % 100 == 0) return 0;
    else if (year %4 == 0) return 1;
    return 0;
}

# tdd 
function autotest()
{
    ref_2001 = 0;
    s = IsLeapYear(2001);
    print "2001 " ((s==ref_2001)? "OK":"FAIL");

    ref_1996 = 1;
    s = IsLeapYear(1996);
    print "1996 " ((s==ref_1996)? "OK":"FAIL");

    ref_1900 = 0;
    s = IsLeapYear(1900);
    print "1900 " ((s==ref_1900)? "OK":"FAIL");

    ref_2000 = 1;
    s = IsLeapYear(2000);
    print "2000 " ((s==ref_2000)? "OK":"FAIL");
}

BEGIN {
    common_str = "Common";
    leap_str = "Leap";

}
{
    if($1 == "AUTOTEST") {
        autotest();
        exit 0;
    }

    if(IsLeapYear($1)) 
        print $1 " is a " leap_str " year.";
    else
        print $1 " is a " common_str " year.";
}
