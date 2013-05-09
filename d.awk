# !/bin/awk
# markc Apr 2013
# Brief: append date based on time 
# Usage: awk -f d.awk INPUT_FILE
# 
# Take input lines as: 
#  11:59:52 PM	306	17	-5,131.1	124.9
#  11:59:55 PM	306	19	-5,131.1	124.9
#  11:59:57 PM	305	17	-5,131.1	124.9
#  12:00:01 AM	307	19	-5,131.1	124.9
#  12:00:04 AM	305	19	-5,131.1	124.9
#  12:00:07 AM	304	17	-5,131.1	124.9
# convert to:
#   23:59:52 17-Apr-2013	17	124.9
#   23:59:55 17-Apr-2013	19	124.9
#   23:59:57 17-Apr-2013	17	124.9
#   00:00:01 18-Apr-2013	19	124.9
#   00:00:04 18-Apr-2013	19	124.9
#   00:00:07 18-Apr-2013	17	124.9
# Note: we exclude two columns
#
# tdd:
#   echo "AUTOTEST" | awk -f d.awk

function main() {
    date_str = mon_str "-" day_str "-" year_str;
    time_string = $1 " " date_str "\n" ;

# use regex to replace month short name to numbers
    b= gensub(/Jan/, "01", "g", time_string);
    b= gensub(/Feb/, "02", "g", b);
    b= gensub(/Mar/, "03", "g", b);
    b= gensub(/Apr/, "04", "g", b);
    b= gensub(/May/, "05", "g", b);
    b= gensub(/Jun/, "06", "g", b);
    b= gensub(/Jul/, "07", "g", b);
    b= gensub(/Aug/, "08", "g", b);
    b= gensub(/Sep/, "09", "g", b);
    b= gensub(/Oct/, "10", "g", b);
    b= gensub(/Nov/, "11", "g", b);
    b= gensub(/Dec/, "12", "g", b);


# convert dd-mm-yyyy hh mm ss to yyyy mm dd hh mm ss
    hh = gensub(/([0-9]+):([0-9]+):([0-9]+) .*/, "\\1", "g", b);
    mm = gensub(/[0-9]+:([0-9]+):[0-9]+ .*/, "\\1", "g", b);
    ss = gensub(/[0-9]+:[0-9]+:([0-9]+) .*/, "\\1", "g", b);

    mon = gensub(/.* ([0-9]+)-[0-9]+-[0-9]+.*/, "\\1", "g", b);
    day = gensub(/.* [0-9]+-([0-9]+)-[0-9]+.*/, "\\1", "g", b);
    year = gensub(/.* [0-9]+-[0-9]+-([0-9]+).*/, "20\\1", "g", b);


# perfrom day add checking
    if (match($1, "PM")) {

        if (hh !=12) hh = hh + 12;
        if(day_change == 0) {
            day_change = 1;
        }
    }
    if (match($1, "AM")) {

        if(hh == 12) hh = 0;
        if(day_change == 1) {
            # add day by 1
            # later mktime and strftime will automatically shift the month or year for me     
            day += 1; 
            day_str+=1;
            day_change = 0;
        }
    }
    if (match($1, "AM")) {
        if(day_change_sta == 2) {
            day_change_sta = 0;
# update day
            day_str = day_str+1;
        }
    }


    s = year " " mon " " day " " hh " " mm " " ss;

# make time, reformat
    t = mktime(s); 
    s = strftime("%H:%M:%S %d-%b-%Y", t);

# build fields   
    ss = s "\t" $3 "\t" $5;
    return ss;
}
function tdd_reset() {
    mon_str = "Apr";
    day_str = 17;
    year_str = 13;
    day_change_sta = 0;
}
function autotest() {
    tdd_reset();
    test_1();
    tdd_reset();
    test_2();
    tdd_reset();
    test_3();
    tdd_reset();
    test_4();
    tdd_reset();
    test_5();
}
function test_1() {
    print "test_1 begins"
    $1 = "11:59:52 PM"
    $3 = 17;
    $5 = "13.3";
    ref_s0 = "23:59:52 17-Apr-2013\t17\t13.3"
    ss = main();
    if (ss ~ ref_s0) {
        print ss " OK"
    }
    else print ss " FAILED"

    $1 = "12:00:01 AM"; 
    $2=307;	$3="19";	$4="-5,131.1";	$5="124.9";
    ref_s1 = "00:00:01 18-Apr-2013\t19\t124.9"
    ss = main();
    if (ss ~ ref_s1) {
        print ss " OK"
    }
    else print ss " FAILED"

    print "test_1 ends"
}
function test_2() {
    print "test_2 begins"
    $1 = "12:00:01 AM"; 
    $2=307;	$3="19";	$4="-5,131.1";	$5="124.9";
    ref_s1 = "00:00:01 17-Apr-2013\t19\t124.9"
    ss = main();
    if (ss ~ ref_s1) {
        print ss " OK"
    }
    else print ss " FAILED"

    print "test_2 ends"
}
function test_3() {
    print "test_3 begins"
    mon_str = "Apr";
    day_str = 30;
    year_str = 13;
    $1 = "11:59:52 PM"
    $3 = 17;
    $5 = "13.3";
    ref_s0 = "23:59:52 30-Apr-2013\t17\t13.3"
    ss = main();
    if (ss ~ ref_s0) {
        print ss " OK"
    }
    else print ss " FAILED"

    $1 = "12:00:01 AM"; 
    $2=307;	$3="19";	$4="-5,131.1";	$5="124.9";
    ref_s1 = "00:00:01 01-May-2013\t19\t124.9"
    ss = main();
    if (ss ~ ref_s1) {
        print ss " OK"
    }
    else print ss " FAILED"


    print "test_3 ends"
}
function test_4() {
    print "test_4 begins"
    mon_str = "Feb";
    day_str = 29;
    year_str = 12;
    $1 = "11:59:52 PM"
    $3 = 17;
    $5 = "13.3";
    ref_s0 = "23:59:52 29-Feb-2012\t17\t13.3"
    ss = main();
    if (ss ~ ref_s0) {
        print ss " OK"
    }
    else print ss " FAILED"

    $1 = "12:00:01 AM"; 
    $2=307;	$3="19";	$4="-5,131.1";	$5="124.9";
    ref_s1 = "00:00:01 01-Mar-2012\t19\t124.9"
    ss = main();
    if (ss ~ ref_s1) {
        print ss " OK"
    }
    else print ss " FAILED"

    print "test_4 ends"
}

function test_5() {
    print "test_5 begins"
    mon_str = "Dec";
    day_str = 31;
    year_str = 12;
    $1 = "11:59:52 PM"
    $3 = 17;
    $5 = "13.3";
    ref_s0 = "23:59:52 31-Dec-2012\t17\t13.3"
    ss = main();
    if (ss ~ ref_s0) {
        print ss " OK"
    }
    else print ss " FAILED"

    $1 = "12:00:01 AM"; 
    $2=307;	$3="19";	$4="-5,131.1";	$5="124.9";
    ref_s1 = "00:00:01 01-Jan-2013\t19\t124.9"
    ss = main();
    if (ss ~ ref_s1) {
        print ss " OK"
    }
    else print ss " FAILED"

    print "test_5 ends"
}


BEGIN { # global variables

    FS="\t" 

    mon_str = "Apr"
    day_str = 17
    year_str = 13
}
{
    if($1 == "AUTOTEST") {
        autotest();
        exit 0;
    }
    ss = main();
    print ss;
}


