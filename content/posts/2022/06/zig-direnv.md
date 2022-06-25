---
title: legdur - keep your legacy durable
date: 2022-06-25
tags: [cli, rust]
---

Hey, I wrote a thing. Thing being a piece of software.
I have a collection of photos & documents that I really care about.
I synch them between computers using syncthing and also run backups regularly.
What I didn't have was a way to quickly detect bitrot.

Enter [legdur](https://crates.io/crates/legdur)

`legdur` is a simple CLI program to compute hashes of large sets of files in large directory structures and compare them with a previous snapshot.
Think having your photo collection you acquired over time and worrying about bitrot.

## Installation

`cargo install legdur --force` should get you there on a system that has Rust installed already.

## Usage

`legdur path/to/a/directory/`

working:
```shell
legdur ~/documents
2022-06-25T06:45:51.000214Z  INFO legdur: scanning '/home/cyryl/documents'
2022-06-25T06:45:51.044471Z  INFO legdur: list of files acquired, calculating hashes...
█████████████████████████████████████████████████████████████░░░░░░░░░░░░░░░░ 2788/3190
```

finished:
```shell
2022-06-25T06:49:23.776229Z  INFO legdur: hash calculation complete
2022-06-25T06:49:23.784499Z  INFO legdur: /home/cyryl/documents/legdur.db saved
2022-06-25T06:49:23.792585Z  INFO legdur: comparing /home/cyryl/documents/legdur.db with /home/cyryl/documents/legdur.old
2022-06-25T06:49:23.826548Z  WARN legdur: /home/cyryl/documents/legdur.db: 395f65f5727f946c0208f79cfe1f3de1bd81e491bb7631ba6f41fc578d3db368 -> 7d1b9748ed291eb6874c91917b5619eb8e1410e7cbfd37a517c5bd4ddf8c7895
2022-06-25T06:49:23.826715Z  WARN legdur: /home/cyryl/documents/legdur.old: e56cf4f6b7fdc2daa3ca3430e8e64bf9d042f1c0e465dcd452986709cb25f7d8 -> 395f65f5727f946c0208f79cfe1f3de1bd81e491bb7631ba6f41fc578d3db368
```

## How it works

* it will compute a hash of each file present in the directory structure (it works recursively).
* if previously computed `legdur.db` exists it will compare the current state of the world to the one represented by `legdur.db` and output any differences. Only files that changed or got deleted get printed out, additions are not.
* it will move the current `legdur.db` to `legdur.old` and write the new state of the world to a new `legdur.db`


## Contact & contributions
* Let me know if you'd like to hack on this by contacting me on `legdur@cyplo.dev` or via `cyplo@todon.nl` on Mastodon.

