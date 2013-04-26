# !/bin/awk
# markc Apr 2013
# Brief: shift time 
# Usage: awk -f s.awk INPUT_FILE
# 
# Take input lines as: ## 17-Apr-2013 11:28:00 ## ## ...
# shift time to:
#   ## 17-Apr-2013 11:38:00 ## ## ...
# if we want to shift 10 minutes


BEGIN { # global variables

    FS=" " 

    sec_add = 50
    min_add = 9
}
{
    date_str = mon_str "-" day_str "-" year_str;
    time_string = $2 " " $3 ;

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
    hh = gensub(/.* ([0-9]+):([0-9]+):([0-9]+)/, "\\1", "g", b);
    mm = gensub(/.* [0-9]+:([0-9]+):[0-9]+/, "\\1", "g", b);
    ss = gensub(/.* [0-9]+:[0-9]+:([0-9]+)/, "\\1", "g", b);

    day = gensub(/([0-9]+)-[0-9]+-[0-9]+.*/, "\\1", "g", b);
    mon = gensub(/[0-9]+-([0-9]+)-[0-9]+.*/, "\\1", "g", b);
    year = gensub(/[0-9]+-[0-9]+-([0-9]+).*/, "\\1", "g", b);

    s = year " " mon " " day " " hh " " mm " " ss;

# make time, shift and revert back
    t = mktime(s) + sec_add + min_add*60;
    s = strftime("%d-%b-%Y %H:%M:%S", t);
 
# build fields   
    ss = $1 " " s;
    for (i=4;i<=29;i++)
        ss = ss " " $i
    print ss;

}


