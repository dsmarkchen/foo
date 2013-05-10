# !/bin/awk
# markc Apr 2013
# Brief: binary representation
# Usage: awk -f binrep.awk INPUT_FILE
#   or:  echo "15" | awk -f binrep.awk  
# TDD: echo "AUTOTEST" | awk -f binrep.awk

function binrep(n)
{
    binrep_ret = "";
    if(n == 0) binrep_ret = "0"
    while(n >= 1) {
        binrep_temp = binrep_ret;
        if(n!=0) binrep_ret =  (((n%2)!=0)?"1":"0") binrep_temp ;

        if(verbose) print "...." n;
        n = rshift(n, 1);
    }
    return binrep_ret;
}

function test_of_0_to_0 ()
{
    test_name = "test_of_0_to_0"
    $1 = 0;
    s_ref = "0"
    s = binrep($1);
    if(s == s_ref) {
        print test_name " " s " OK"
    }
    else
        print test_name " " s " FAILED"
}
function test_of_7_to_111 ()
{
    test_name = "test_of_7_to_111";
    $1 = 7;
    s_ref = "111"
    s = binrep($1);
    if(s == s_ref) {
        print test_name " " s " OK"
    }
    else
        print test_name " " s " FAILED"
}
function test_of_12()
{
    test_name = "test_of_12";
    $1 = 12;
    s_ref = "1100"
    s = binrep($1);
    if(s == s_ref) {
        print test_name " " s " OK"
    }
    else
        print test_name " " s " FAILED"

}
function test_of_52()
{
    test_name = "test_of_52";
    $1 = 52;
    s_ref = "110100"
    s = binrep($1);
    if(s == s_ref) {
        print test_name " " s " OK"
    }
    else
        print test_name " " s " FAILED"

}

function test_of_123()
{
    test_name = "test_of_123";
    $1 = 123;
    s_ref = "1111011"
    s = binrep($1);
    if(s == s_ref) {
        print test_name " " s " OK"
    }
    else
        print test_name " " s " FAILED"

}

function autotest()
{
    test_of_0_to_0();
    test_of_7_to_111();
    test_of_12();
    test_of_52();
    test_of_123();
}

BEGIN {
    verbose = 0;
}
{
    if($1 ~ "AUTOTEST") {
        autotest();
    }

    # in case I want to pad with zeros
    #printf("%08d\n",  binrep($1));
    print binrep($1);
}
