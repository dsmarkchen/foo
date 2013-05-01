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
    common_year = 0;
    leap_year = 1;

    s = IsLeapYear(2001);
    print "2001 is a common year.." ((s==common_year)? "OK":"FAIL");

    s = IsLeapYear(1996);
    print "1996 is a leap year.." ((s==leap_year)? "OK":"FAIL");

    s = IsLeapYear(1900);
    print "1900 is a common year.." ((s==common_year)? "OK":"FAIL");

    s = IsLeapYear(2000);
    print "2000 is a leap year.." ((s==leap_year)? "OK":"FAIL");
}

BEGIN {
    common_str = "common";
    leap_str = "leap";

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
