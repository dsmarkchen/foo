% a little 16pt hskip for a line
\def\midline#1{\line{\hskip16pt\relax#1\hfil}}

@ This is the exercise on prime factors.

\bigskip Here code starts:

@c
@<includes@>@/
@<types@>@/
@<tests@>@/
@<set of tests@>@/
@<routines@>@/
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

@ @<incl...@>+=
#include <stdio.h>


@ I use google gtest for TDD.
@<incl...@>+=
#include<assert.h>

@ @<type...@>+=
typedef void test_t(void);
@ 
@d ASSERT_EQ(a,b) assert(a==b)
@<set...@>+=
static test_t* tests[ ] =
{
    test_is_it_prime_of_2,
    test_is_it_prime_of_3,
    test_is_it_prime_of_4,
    test_of_build_prime_numbers_under_23,
    test_of_build_prime_numbers_under_3,
    test_of_build_prime_numbers_under_2,
    test_of_build_prime_numbers_under_1,
    test_of_2,
    test_of_3,
    test_of_4,
    test_of_12,
    test_of_15,
    (test_t*)0,
};

@ @<type...@>+=
int prime_factory(int n, int out[], size_t out_size);

@ test suite.
@d NUMS_MAX 200
@<types@>+=
int nums[NUMS_MAX];

@ First Test case.
@<tests...@>+=

void test_of_2()
{
    ASSERT_EQ(1, get_prime_factors(2, nums, NUMS_MAX));
    ASSERT_EQ(2, nums[0]);
}
void  test_of_3()
{
    ASSERT_EQ(1, get_prime_factors(3, nums, NUMS_MAX));
    ASSERT_EQ(3, nums[0]);
}
void  test_of_4()
{
    ASSERT_EQ(2, get_prime_factors(4, nums, NUMS_MAX));
    ASSERT_EQ(2, nums[0]);
    ASSERT_EQ(2, nums[1]);
}
void  test_of_12()
{
    ASSERT_EQ(3, get_prime_factors(12, nums, NUMS_MAX));
    ASSERT_EQ(2, nums[0]);
    ASSERT_EQ(2, nums[1]);
    ASSERT_EQ(3, nums[2]);
}
void  test_of_15()
{
    ASSERT_EQ(2, get_prime_factors(15, nums, NUMS_MAX));
    ASSERT_EQ(3, nums[0]);
    ASSERT_EQ(5, nums[1]);
}
void  test_is_it_prime_of_2() {
    ASSERT_EQ(1, is_it_prime(2));
}
void  test_is_it_prime_of_3() {
    ASSERT_EQ(1, is_it_prime(2));
}
void  test_is_it_prime_of_4() {
    ASSERT_EQ(0, is_it_prime(4));
}
void  test_of_build_prime_numbers_under_23()
{
    int r;
    int myprimes[20];
    int nmax = 23;
    r = build_prime_numbers(nmax, myprimes, 20);
    ASSERT_EQ(5, r);
    ASSERT_EQ(2, myprimes[0]);
    ASSERT_EQ(3, myprimes[1]);
    ASSERT_EQ(5, myprimes[2]);
    ASSERT_EQ(7, myprimes[3]);
    ASSERT_EQ(11, myprimes[4]);
    
}
void  test_of_build_prime_numbers_under_2()
{
    int r;
    int myprimes[20];
    int nmax = 2;
    r = build_prime_numbers(nmax, myprimes, 20);
    ASSERT_EQ(1, r);
    ASSERT_EQ(2, myprimes[0]);
}
void  test_of_build_prime_numbers_under_3()
{
    int r;
    int myprimes[20];
    int nmax = 3;
    r = build_prime_numbers(nmax, myprimes, 20);
    ASSERT_EQ(2, r);
    ASSERT_EQ(2, myprimes[0]);
    ASSERT_EQ(3, myprimes[1]);
}

void  test_of_build_prime_numbers_under_1()
{
    int j, r;
    int myprimes[20];
    int jj = 0;
    int nmax = 1;
    r = build_prime_numbers(nmax, myprimes, 20);
    ASSERT_EQ(0, r);
}




@ 
@d verbose 0
@d PRIME_MAX 200
 
@<rout...@>+=
int primes[200];
int get_prime_factors(int n_in, int* num_out, unsigned int num_max)
{
    int i;
    size_t total;
    int j =0;
    printf("### %d\n", n_in);
    @<build prime numbers@>@;
    assert(total > 0);
gpf_start:
    j = 0;
    for(i=0;i<total;i++) {
        if(n_in%primes[i]== 0) break; 
    }
    if(i != total) {
        num_out[j++] = primes[i];
        n_in /= primes[i];
    }
    if(verbose) printf("... %d %d...\n", primes[i], n_in);
    if(n_in >= 2) goto gpf_start;
    return j;
}
int is_it_prime(int n)
{
    for(int i=2;i<=n/2;i++) {
        if((n%i)== 0) return 0;
    }
    return 1;
}
int build_prime_numbers(int nmax, int xprimes[], unsigned int xsize) 
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
    printf("%d of prime numbers:%d\n", nmax, jj);
    return jj;
}

@ @<type...@>+=
int get_prime_factors(int n_in, int* num_out, unsigned int num_max);
int is_it_prime(int n);
int build_prime_numbers(int nmax, int xprimes[], unsigned int xsize);

 @  @<build prime numbers@>=
{
    total = build_prime_numbers(n_in, primes, PRIME_MAX);
}
    
@ Index.
