\datethis
@* Intro. This is the {\tt dojo} of {\sl prime factors}. Below is the description:

{Factorize a positive integer number into its prime factors.}


@(prime_tests.c@>=
@<includes@>@/
@<test defines@>@/
@<test types@>@/
@<tests@>@/
@<test data@>@/
@<main@>@/


@ @<incl...@>+=
#include <stdio.h>
#include "prime.h"

@ @(prime.h@>+=
#ifndef PRIME_H
#define PRIME_H
#define verbose 0
#define PRIME_MAX 200
#define ASSERT_EQ(a,b) assert(a==b)
int get_prime_factors(unsigned int n_in, int* num_out, unsigned int num_max);
int is_it_prime(unsigned int n);
int build_prime_numbers(unsigned int nmax, int xprimes[], unsigned int xsize);
#endif

@ test suite.
@<test def...@>+=
#define NUMS_MAX 200

@ @<test types@>+=
int nums[NUMS_MAX];


@ @<incl...@>+=
#include<assert.h>

@ @<test type...@>+=
typedef void test_t(void);
@ 
@d ASSERT_EQ(a,b) assert(a==b)
@<test data...@>+=
static test_t* tests[ ] =
{ @/
    test_is_it_prime_of_2, @/
    test_is_it_prime_of_3, @/
    test_is_it_prime_of_4, @/
    test_of_build_prime_numbers_under_23, @/

    test_of_build_prime_numbers_under_3,@/
    test_of_build_prime_numbers_under_2,@/
    test_of_build_prime_numbers_under_1,@/
    test_of_2,@/
    test_of_3,@/
    test_of_4,@/
    test_of_12,@/
    test_of_15,@/
    (test_t*)0,@/
};


@ Print test case similar to gtest.
@<test defines@>+=
#define X_TEST_BEGIN(x) if(verbose){printf(x); printf(" [begin]");}
#define X_TEST_END(x) if(verbose){printf(x); printf(" [end]\n");}


@ @<main@>+=
int main(void)
{
    size_t at = 0;
    while (tests[at])
    {
        tests[at++]();
        putchar('.');
    }
    printf("\n%zd tests passed", at);
    return 0;
}

@ test cases.
@<tests...@>+=

void test_of_2()
{
    X_TEST_BEGIN("test_of_2");
    ASSERT_EQ(1, get_prime_factors(2, nums, NUMS_MAX));
    ASSERT_EQ(2, nums[0]);
    X_TEST_END("test_of_2");
}
void  test_of_3()
{
    X_TEST_BEGIN("test_of_3");
    ASSERT_EQ(1, get_prime_factors(3, nums, NUMS_MAX));
    ASSERT_EQ(3, nums[0]);
    X_TEST_END("test_of_3");
}
void  test_of_4()
{
    X_TEST_BEGIN("test_of_4");
    ASSERT_EQ(2, get_prime_factors(4, nums, NUMS_MAX));
    ASSERT_EQ(2, nums[0]);
    ASSERT_EQ(2, nums[1]);
    X_TEST_END("test_of_4");
}
void  test_of_12()
{
    X_TEST_BEGIN("test_of_12");
    ASSERT_EQ(3, get_prime_factors(12, nums, NUMS_MAX));
    ASSERT_EQ(2, nums[0]);
    ASSERT_EQ(2, nums[1]);
    ASSERT_EQ(3, nums[2]);
    X_TEST_END("test_of_12");
}
void  test_of_15()
{
    X_TEST_BEGIN("test_of_15");
    ASSERT_EQ(2, get_prime_factors(15, nums, NUMS_MAX));
    ASSERT_EQ(3, nums[0]);
    ASSERT_EQ(5, nums[1]);
    X_TEST_END("test_of_15");
}
void  test_is_it_prime_of_2() {
    X_TEST_BEGIN("test_is_it_prime_of_2");
    ASSERT_EQ(1, is_it_prime(2));
    X_TEST_END("test_is_it_prime_of_2");
}
void  test_is_it_prime_of_3() {
    X_TEST_BEGIN("test_is_it_prime_of_3");
    ASSERT_EQ(1, is_it_prime(2));
    X_TEST_END("test_is_it_prime_of_3");
}
void  test_is_it_prime_of_4() {
    X_TEST_BEGIN("test_is_it_prime_of_4");
    ASSERT_EQ(0, is_it_prime(4));
    X_TEST_END("test_is_it_prime_of_4");
}
void  test_of_build_prime_numbers_under_23()
{
    int r;
    int myprimes[20];
    int nmax = 23;
    X_TEST_BEGIN("test_of_build_prime_numbers_under_23");
    r = build_prime_numbers(nmax, myprimes, 20);
    ASSERT_EQ(5, r);
    ASSERT_EQ(2, myprimes[0]);
    ASSERT_EQ(3, myprimes[1]);
    ASSERT_EQ(5, myprimes[2]);
    ASSERT_EQ(7, myprimes[3]);
    ASSERT_EQ(11, myprimes[4]);
    
    X_TEST_END("test_of_build_prime_numbers_under_23");
}
void  test_of_build_prime_numbers_under_2()
{
    int r;
    int myprimes[20];
    int nmax = 2;
    X_TEST_BEGIN("test_of_build_prime_numbers_under_2");
    r = build_prime_numbers(nmax, myprimes, 20);
    ASSERT_EQ(1, r);
    ASSERT_EQ(2, myprimes[0]);
    X_TEST_END("test_of_build_prime_numbers_under_2");
}
void  test_of_build_prime_numbers_under_3()
{
    int r;
    int myprimes[20];
    int nmax = 3;
    X_TEST_BEGIN("test_of_build_prime_numbers_under_3");
    r = build_prime_numbers(nmax, myprimes, 20);
    ASSERT_EQ(2, r);
    ASSERT_EQ(2, myprimes[0]);
    ASSERT_EQ(3, myprimes[1]);
    X_TEST_END("test_of_build_prime_numbers_under_3");
}

void  test_of_build_prime_numbers_under_1()
{
    int r;
    int myprimes[20];
    int nmax = 1;
    X_TEST_BEGIN("test_of_build_prime_numbers_under_1");
    r = build_prime_numbers(nmax, myprimes, 20);
    ASSERT_EQ(0, r);
    X_TEST_END("test_of_build_prime_numbers_under_1");
}


@* Implementation. 
@c
@<includes@>@/
@<routines@>@/

@ 
@<rout...@>+=
int primes[200];
int get_prime_factors(unsigned int n_in, int* num_out, unsigned int num_max)
{
    int i;
    size_t total;
    int j =0;
    if(verbose) printf("### %d\n", n_in);
    @<build prime numbers@>@;
    assert(total > 0);
    j = 0;
gpf_start:
    for(i=0;i<total;i++) {
        if(n_in%primes[i]== 0) break; 
    }
    if(i != total) {
        num_out[j++] = primes[i];
        n_in /= primes[i];
    }
    if(verbose) printf("return: %d, (%d, %d)\n", j, primes[i], n_in);
    if(n_in >= 2) goto gpf_start;
    return j;
}
@ 
@<rout...@>+=
int is_it_prime(unsigned int n)
{
    int i;
    if(n==2 || n==3) return 1;
    for(i=2;i<(n/2+1);i++) {
        if((n%i)== 0) return 0;
    }
    return 1;
}
@ 
@<rout...@>+=
int build_prime_numbers(unsigned int nmax, int xprimes[], unsigned int xsize) 
{
    int j;
    int jj = 0;
    if(nmax < 2) return jj;
    xprimes[jj++] = 2;
    if(nmax == 2) return jj;
    xprimes[jj++] = 3;
    if(nmax == 3) return jj;
    for(j=4;j<(nmax/2+1);j++) {
        if(is_it_prime(j))
            xprimes[jj++] = j;
        
    }
    if(verbose) printf("%d of prime numbers:%d\n", nmax, jj);
    return jj;
}

@  @<build prime numbers@>=
{
    total = build_prime_numbers(n_in, primes, PRIME_MAX);
    if(verbose) {
        printf("build_prime_numbers: input %d total %d\n", n_in, (int)total);
    }
}
    
@* Index.
