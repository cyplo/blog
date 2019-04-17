---
title: Fuzzers and how to run them.
date: 2019-04-17
tags: [fuzzing, rust]
---

I am fascinated by the concept of fuzzing. It fits well with my desire to test weird code paths by using more of computer's time and less that of a programmer.

## What is fuzzing ?

It's a type of automated testing, especially good with finding edge cases in your code. It runs totally outside of your code and knows nothing about it - it just throws random data at it. Modern fuzzers instrument your code to be able to tell if by changing input they change the code paths covered and by doing that they try to achieve maximum coverage. While this sounds like a very naive approach it can lead to finding incredibly interesting bugs. For that reason fuzzers are oftentimes used in the security community for finding vulnerabilities. Fuzzing is a type of a black box testing - but how you define that box is entirely up to you. It can be the whole program, it can be a single function. It just needs a clear entry point with ability to manipulate input data.

An example may be in order. We'll look into one provided by [Rust Fuzzing Authority](https://github.com/rust-fuzz) - people behind [cargo fuzz](https://fuzz.rs/book/cargo-fuzz.html) and [afl.rs](https://fuzz.rs/book/afl.html).
Imagine you're trying to see if you've handled all cases in your url parser. You can just do

```rust
fuzz_target!(|data: &[u8]| {
    if let Ok(s) = std::str::from_utf8(data) {
        let _ = url::Url::parse(s);
    }
});
```

And that's it ! You define a function that takes raw bytes, discards the ones that are outside of a UTF8 string space and then tries to invoke the function under test with the said string. We assume that if this function completes then the run is considered ok, if it panics then not.

I wanted to use this example because it is very typical of how a fuzzer would be used.

1. get random input from the engine
2. discard some of the input
3. drive the function under test
4. check some simple property of the run - the faster the property to check the better. For this reason - the 'did not crash' property is used often, however you can use any condition you want, as long as fuzzer has a way of distinguishing between successful and failed runs.

## How does it compare to property-based tests ?

When thinking about other types of tests that are driven by randomness and are generally black-box-ish - property-based tests come to mind. How does fuzzing compare ?

- Fuzzing is good with finding hidden properties of the existing code, it used after the code is written, while property-based tests can also be used in a TDD workflow
- In property-based tests you typically want to describe behaviour - they serve as good documentation. Fuzzing is not really as good with that. It can automatically collect the examples though, that then can be manually transformed into a property.
- As you want your program to always hold all properties true you run all property-based tests within your CI/CD pipeline. For this reason they tend to test only things that are relatively fast to check, excution-time wise. Fuzzers are typically ran over nights or weeks - finding those edge cases, providing more properties for you to know and care about.

## Want help with fuzzing your open source project ?

If you're not sure what fuzzing is, or you want help with adding fuzzer support to your open source project - just tell me ! Either by [email](fuzzing@cyplo.dev) or on [Twitter](https://twitter.com/cyplo). I'm happy to jump on a call, pair program or whatever you fancy ! I know the most about the Rust fuzzing space, but happy to help with other languages as well - this allows me to learn :)

I also run a fuzzing server where I can test your project overnight and see if we find anything.

With that in mind - happy fuzzing !
