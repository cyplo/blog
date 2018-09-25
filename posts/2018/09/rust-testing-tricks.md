.. title: Testing tricks in Rust
.. slug: rust-testing-tricks
.. date: 2018-09-25 00:00:00 UTC
.. tags: rust, programming, tdd, testing
.. category: 
.. link: 
.. type: text

# Write the test first

Not really a Rust trick, but hey.  
Try writing your test first, before production code. If you're building a feature of fixing a bug that will be affect external behaviour - start with an integration test at the crate level. Try thinking what would be the ideal code you would like to interact with, what would be the types, what would be th functions ? A broad-strokes scenario, not caring much about implementation details, not caring much about covering all edge cases. Write that code. It does not compile. But it looks nice, you're pleased. Read through again, add assertions. Add the types. For each missing feature or a bug that is present in this high level scenario - write a unit test. Satisfy that test with changes to production code. Maybe refactor a bit in between. Once the big test is green - you're done !  

There is no Rust-focused TDD book just yet for me to recommend, but here, have some for other languages:  

* Kent Beck - Test Driven Development: By Example
* Steve Freeman, Nat Pryce - Growing Object-Oriented Software, Guided by Tests

Rust allows for more cool tricks and generally writing less test code than mentioned in these books, so please use your judgment - and the next tricks from this article !  

# Use verbs as test module names

Who said that the test module needs to be named `test` ? Experiment with different module names, pay attention to how the test runner displays the results.

A structure that I like, an example:

`worker.rs:`
```
// some production code here

mod should {

    #[test]
    fn consume_message_from_queue() {
        // mock queue, create worker with that queue injected
        // start worker
        // check if queue's 'get_message' was invoked
    }

}
```

Cargo prints `worker::should::consume_message_from_queue` when running this test, which reads nicely and exposes the requirement.

# Interior mutability for controlling state of variables injected from the test

Use e.g. the `atomic` types family or `RefCell` itself to get an immutable handle to a internally mutable data.  
Useful when you don't want your production code to accept anything that can mutate but you still want to control that value from the test.  

See injecting the system clock example in [my previous blog post](https://blog.cyplo.net/posts/2018/07/rust-injection.html).

# Let's talk !

Have any questions ? Would like to pair on Rust ? Curious about TDD ? Ping me !
Email is good - [hello@cyplo.net](mailto:hello@cyplo.net) or try [Twitter](https://twitter.com/cyplo).  

thanks !