// gcc -O3 sieve.c -o sieve
// time ./sieve

#include <stdio.h>
#include <malloc.h>

int pi(int n) {
  int i, j;

  char* primes = (char*)malloc(sizeof(char) * (n + 1));

  for (i = 2; i <= n; i++) primes[i] = 1;

  i = 2;
  while ((i * i) <= n) {
    if (primes[i] != 0) {
      for (j = i * i; j <= n; j += i) {
        primes[j] = 0;
      }
    }
    i++;
  }

  int cnt = 0;
  for (i = 2; i <= n; i++) {
    if (primes[i]) {
      cnt += 1;
    }
  }

  free(primes);

  return cnt;
}

int main() {
  static const int v[] = {97, 1000, 1000000, 10000000};
  for (int i = 0; i < 4; i++) {
    printf("pi(%d) = %d\n", v[i], pi(v[i]));
  }
}