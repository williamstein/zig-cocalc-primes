// This is a dynamic sieve to compute pi(n), where n is
// set at runtime and memory is dynamically allocated on the heap:

//     zig build-exe -O ReleaseFast sieve.zig
//     time ./sieve

// To build and run using Web Assembly. No --stack option is
// needed, because we are using the heap for memory.

//     zig build-exe -O ReleaseFast -target wasm32-wasi sieve.zig
//     time wasmer ./sieve.wasm

// To install wasmer do this:

//     curl https://get.wasmer.io -sSfL | sh

const std = @import("std");
const Gpa = std.heap.GeneralPurposeAllocator(.{});

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    var gpa = Gpa{};
    defer _ = gpa.deinit();
    var galloc = &gpa.allocator;

    const values = [_]u32{ 97, 1000, 1000000, 10000000 };
    for (values) |n| {
        try stdout.print("pi({}) = {}\n", .{ n, try pi(galloc, n) });
    }
}

fn pi(galloc: *std.mem.Allocator, n: usize) !u32 {
    var primes = try galloc.alloc(bool, n + 1);
    defer galloc.free(primes);
    primes[0] = false;
    primes[1] = false;
    var i: usize = 2;
    while (i <= n) : (i += 1) {
        primes[i] = true;
    }
    i = 2;
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
