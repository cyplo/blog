---
title: Don't let failures spread over your suite with process-based tests isolation
date: 2020-12-28
series: rust-testing-tricks
tags: [rust, testing]
---

Being able to precisely control what failures in underlying systems occur and at what time can be really useful in achieving a fast and stable test suite. While I am a big proponent of dependency inversion and being able to control dependencies via the explicit injection points in your API, sometimes it's impractical to do so. This is where [`fail`](https://crates.io/crates/fail) can help us immensely, providing an escape hatch for situations like those as it allows to inject failures into previously defined failure points.

It comes at a price though. If you would mix your other unit tests and tests activating fail points you will notice some unexpected failures in the test suite. As `cargo test` runs tests in parallel by default, the tests activating a fail point can interfere with another test that did not want that fail point active at all that is ran at the same time. The crate authors [recommend](https://docs.rs/fail/#usage-in-tests) running all of the tests using fail points in a separate executable and using `FailScenario` to serialise test execution.

There is another way, that I found simpler for the way I write tests, if you allow for yet another helper crate. We can run each test in a separate process, effectively isolating it from the rest, stopping failures from spreading.

Let's take a look at an example from [`bakare`](https://git.sr.ht/~cyplo/bakare) - my experiment in writing a backup system.

`cargo.toml`

```toml
[dependencies]
fail = "0.4"

[dev-dependencies]
two-rusty-forks = "0.4.0"

[features]
failpoints = [ "fail/failpoints" ]
```

`lock.rs`

```rust
/// this function is called from `Lock::lock()`
fn create_lock_file(lock_id: Uuid, index_directory: &VfsPath) -> Result<()> {
    ...
    fail_point!("create-lock-file", |e: Option<String>| Err(anyhow!(e.unwrap())));
    let mut file = lock_file_path.create_file()?;
    ...
}

mod must {
    use super::Lock;
    use anyhow::Result;

    /// only import the macro when `failpoints` feature is enabled
    #[cfg(feature = "failpoints")]
    use two_rusty_forks::rusty_fork_test;
    use vfs::{MemoryFS, VfsPath};

    #[test]
    /// this is a normal unit test
    /// we don't want for it to be affected by the fail points being active
    fn be_released_when_dropped() -> Result<()> {
        let temp_dir: VfsPath = MemoryFS::new().into();
        {
            let _lock = Lock::lock(&temp_dir);
        }
        let entries = temp_dir.read_dir()?.count();

        assert_eq!(entries, 0);
        Ok(())
    }

    #[cfg(feature = "failpoints")]
    rusty_fork_test! { /// use the macro to create a separate process for this test
        #[test]
        fn be_able_to_lock_when_creating_lock_file_fails_sometimes() {
            /// activate the fail point
            fail::cfg("create-lock-file", "90%10*return(some lock file creation error)->off")
                .unwrap();
            let path = MemoryFS::new().into();

            let lock = Lock::lock(&path).unwrap();
            lock.release().unwrap();
        }
    }

    ...
}

```
