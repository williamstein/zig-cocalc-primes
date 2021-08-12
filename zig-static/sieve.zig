// This is a static sieve to compute pi(n), where n is
// set at compile time.  It allocates the memory
// on the stack.  To build and run:

//     zig build-exe sieve.zig
//     time ./sieve

// To build and run using Web Assembly.  We need a MUCH
// larger stack than normal for WASM hence the --stack option.

//     zig build-exe -target wasm32-wasi --stack 11000000 sieve.zig
//     time wasmer ./sieve.wasm

// Or twice as fast:
//     zig build-exe -O ReleaseFast -target wasm32-wasi --stack 11000000 sieve.zig

// To install wasmer do this:

//     curl https://get.wasmer.io -sSfL | sh

const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    comptime const v = [_]u32{ 97, 1000, 1000000, 10000000 };
    try stdout.print("pi({}) = {}\n", .{ v[0], pi(v[0]) });
    try stdout.print("pi({}) = {}\n", .{ v[1], pi(v[1]) });
    try stdout.print("pi({}) = {}\n", .{ v[2], pi(v[2]) });
    try stdout.print("pi({}) = {}\n", .{ v[3], pi(v[3]) });
}

// using a comptime n ensures that there's no need for dynamic memory.
fn pi(comptime n: usize) u32 {
    var primes = [_]bool{true} ** (n + 1);
    primes[0] = false;
    primes[1] = false;
    var i: usize = 2;
    while (i * i <= n) : (i += 1) {
        if (primes[i]) {
            var j = i * i;
            while (j <= n) : (j += i)
                primes[j] = false;
        }
    }
    var c: u32 = 0;
    for (primes) |isprime|
        if (isprime) {
            c += 1;
        };
    return c;
}
