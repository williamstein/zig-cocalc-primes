# time python3 ./sieve.py

def pi(n):
    primes = [True]*(n + 1)

    primes[0] = primes[1] = False
    i = 2
    while i * i <= n:
        if primes[i]:
            for j in range(i*i, n+1, i):
                primes[j] = False
        i += 1

    cnt = 0
    for x in primes:
        if x:
            cnt += 1
    return cnt

def main():
    v = [97, 1000, 1000000, 10000000]
    for n in v:
        print(f"pi({n}) = {pi(n)}")

main()
