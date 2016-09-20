---
layout: post
title: How to Develop, Build, and Ship Rust Code Effectively
---

This article was written during the Stable 1.11 Release Cycle.

This article is inspired by killercup's fantastic article [Good Practices for Writing
Rust
Libraries](https://pascalhertleif.de/artikel/good-practices-for-writing-rust-libraries/).
While most of the information is still relevant some new things have
come to light or better support has come around to really test and make
a solid library for others to use. A lot has changed in the year since
that article and it would really help users of Rust to know what options
are available to them to help Develop, Build and Ship their code. I plan
to keep this article updated as the Rust ecosystem changes and evolves,
and better practices emerge.

Note this article is going to favor open source Rust projects in terms of CI options
and the like and a custom CI might be better suited for a production environment
depending on your needs. In that case working with your Dev Ops team is
probably the best thing to do in terms of shipping your code, though
a lot of the practices and things mentioned here are still relevant to
production teams.

This article is going to be long and you might only want to reference
certain things while building your library. Below is a table of contents
for you to jump around to what you really want.

## Table of Contents
- Develop
  - Learning Resources
  - Editor/IDE Support
  - Stable, Beta, or Nightly?
  - rustup.rs
  - Cargo
    - Cargo.toml 
    - Cargo subcommands
  - External Libraries
  - Lints
  - Formatting
  - Autocompletion
  - Editor Config
  - Github
  - Gitlab
  - What about Darcs/Hg?
  - Community Engagement
    - Gitter
    - Slack
    - Mattermost
    - Contact Information
  - Examples
  - Tests
  - Having a good README
  - Having a good commit log
  - Documentation
  - Pull Requests and enforcing standards
- Build
  - travis-ci
    - Linux
    - MacOSX
  - appveyor
    - Windows
  - circle-ci
  - Codecov
  - Dependency-CI
- Ship
  - Licensing
    - MIT
    - MIT/Apache-2.0 Dual License
  - crates.io
    - cargo publish
    - Building your own
    - Removing your dead projects
  - Just a repo

## Develop
Developing Rust code isn't as hard as it might seem! Sure there might
seem to be a lot going on but getting up and running is rather simple
with tools like cargo and rustup. We're going to cover those basics then
move on to all of the awesome tools available to you in order to build
your project as well as best practices to make it easier to use for
new users to your project. This includes pit falls like lack of examples
and documentation that I've seen hurt projects usability and the
willingness to use it.

### Learning Resources
If you haven't even touched Rust before and are considering building
code with it, then you're better off learning the language and
considering whether it's right for you! Here's some great resources to
get you started with learning Rust:

- [Official Rust Book - The holy grail of resources to learn the
  language]()
- [Too Many Linked Lists - my personal favorite and a great resource to
  use after having learned Rust from the book.]()
- [Rustonomicon - The dark arts of unsafe Rust code]()
- [Rustlings - Great little exercises to practice Rust!]()
- [Rust by Example - Sort of like the Rust book but you can edit examples
  and run them in the browser as well!]()
- [exercism.io - More exercises to practice Rust (as well as other
  languages)]()
- [Standard Library Documentation - All the docs on things you might use
  in the standard library]()

### Editor/IDE
If you feel comfortable with Rust then it's time to go to the next
important thing as a developer, which Editor or IDE do you use! 

#### IDEs
As of now Rust's IDE story has been rough and the only IDE with good support
available now is [IntelliJ Rust](). While there is an [RFC]() covering
IDEs and giving better support not much work has been done on that
front. If IDE's are an absolute must for you and IntelliJ isn't doing it
for you then you might want to hold off for a bit.

#### Editors
If all you need is a simple editor with some plugins then there's a lot of
support for those! Full disclosure I use Neovim for all of my work and while
I've done my best to look up and coalesce resources regarding editors I might
have missed something and I'm always open to Pull Requests for something
I might have missed.

#### Vim/Neovim
#### Emacs
#### Atom
#### Sublime Text

### Stable, Beta, or Nightly?
You've got your editor setup and now you want to get started but now
you've come to a dilemma, which version of Rust do you use? It depends
on what you're doing. Let's look at each one:

#### Stable
- If you can help it build on Stable. It makes companies less wary of
  your library if it's designed to build on stable.
- You won't face regressions (and if you do you really need to report
  this to the Rust compiler devs)
- Any features you use have been voted upon to be stable and aren't
  compiler features you have to turn on.

Stable is by and large the best thing to build on. You'll face less
breakage with your CI infrastructure and overall it's a more pleasant
experience. That being said you don't get any of the cool new feature
that are available in Nightly, but things won't break. Stable should be
your default choice unless you absolutely need a nightly feature in
order for things to work.

#### Beta
The often less talked about choice of the three Beta has it's benefits.
- This version will be the next compiler version 6 weeks after the last
  stable release
- Allows testing of your project before the next stable release,
  allowing you to let the compiler devs know if anything is breaking.
- More stable than nightly

Beta is best used to test that upcoming features aren't going to break
your build. You can have it be an optional check in a CI setup so that
you can be notified ahead of time if things will break without actually
having it stop your builds. Beta is your safeguard against a future broken
stable release. This is generally the only way it's used for in the Rust
ecosystem as far as I know.

#### Nightly
This is the compiler that really lets you do things with Rust that the
other two can't do at all. Things such as:
- Compiler plugins
- Custom derive (it's going to be in stable at some point)
- Testing unstable features and library extensions

Nightly really lets you unleash the power of Rust and some of the cool
things it can do currently but it comes at a cost:
- Nightly breaks often and easily
- You have to peg specific versions for CI builds to maintain some
  semblance of stability in your project
- Some companies won't use anything that doesn't compile on stable at
  all.

This last point is problematic and one where if we want Rust to succeed
avoiding using Nightly is best. However powerful libraries like Serde
and Diesel need nightly to work for now, though work is going on with
the compiler team so that these libraries can be stabilized in the
future.

#### Recap
Good easy Rust programs use Stable if possible, Beta is used to make
sure Stable builds don't break, and Nightly is best for features that
need it like compiler plugins.

### rustup.rs
Alright so you've chosen which compiler to use. What about if you need
to switch between them? How does one keep multiple versions of Rust on
their computer? What about a specific Nightly from a specific day? Fear
not, for we have a tool that answers all these questions. rustup.rs is
the answer. While not at 1.0 it's still quite usable and I've been using
it since it was announced. It's easily able to switch between versions,
set default compilers on a per project basis, and makes it easy to
upgrade when a new version comes out. rustup is an official project and
will become the default way to get it installed in the future. I would
really recommend it as it stands for your projects. You can find out how
to install it [here](). Now before every security person comes jumping
out of the wood works regarding the instructions for installation,
if you're worried download the script and read it yourself before execution. If
you're really just not happy about that solution either the source code
is [here]() and you can build it from source yourself by downloading the
compiler from either your distribution of choice or the official website
[here](). Just do what works best for your situation and priorities.
Better yet helping contribute to make it more secure would be even
better so that we don't have to worry about these kinds of things.
Getting PGP verification built in would be a huge boon.

Some common commands to use for rustup:

```bash
rustup show #Show installed toolchains and the current active one
rustup self update #Upgrade rustup to a new version
rustup update #Update installed tool chains
rustup <toolchain> install #Install a toolchain (stable, beta, or nightly)
                           #It can also do a triplet install e.g.
                           #stable-x86_64-unknown-linux-gnu
rustup default #Choose youre default toolchain for projects
rustup override set <toolchain> #Sets a specific toolchain for a directory
```

The above commands should be enough to get you started using rustup for
your projects.

### Cargo
Alright you have everything setup for your tooling now lets get working
on an actual project! We'll be using cargo the official Rust package
manager. Best part is it comes with rustc when you install toolchains
using rustup!

To get started go to a directory where you want to put your project
folder in and execute the following commands:

```bash
cargo new <your-library-name>
# or
cargo new <your-binary-name> --bin
```

By default cargo new creates a library project layout so if you want to
have an executable program as your project you need to pass it the --bin
flag. Well let's take a look inside!

You'll see that we have a file called Cargo.toml and a src directory
with a file called lib.rs or main.rs if it's a binary. Not only that but
it's also initialized as a git repository for you automatically! Plus it
includes a .gitignore file for things that Rust creates but shouldn't be
tracked by git namely the target directory where builds and examples are
put after being built.

That's it, your project is now good to go and you can begin coding.
Here are the basic commands you need to use cargo:

```bash
cargo build # build your project add --release for an optimized build
cargo run   # if your project is a binary run it after building it. 
            # --release will optimize the build
cargo test  # Run all tests available (doc, tests folder, and in file tests)
cargo doc   # Run rustdoc on the project to produce beautiful
            # documentation of your code
cargo bench # Run benchmarks you've created and output the results
```

Now lets take the time to understand Cargo.toml which is what allows you
to pull in dependencies and other things

#### Cargo.toml
This is your default configuration file and by default it looks
something like this:

```toml
[package]
name = "example"
version = "0.1.0"
authors = ["Michael Gattozzi <mgattozzi@gmail.com>"]

[dependencies]
```

However, there's a lot of missing information that can be useful as
metadata for crates.io and for users looking for information on your
project. Here's an example of one of mine after having filled it out:

```toml
[package]
name = "functils"
version = "0.0.2"
authors = ["Michael Gattozzi <mgattozzi@gmail.com>"]
description = "Functions to make Rust more functional"
license = "MIT OR Apache-2.0"
documentation = "https://docs.rs/functils"
homepage = "https://github.com/mgattozzi/functils"
repository = "https://github.com/mgattozzi/functils"
readme = "README.md"

[dependencies]
kinder = "0.1.1"
```

This lets users know a few more things about it, namely what my project
is about, what license this code uses, where one can find documentation
on it, what's the project's homepage if it exists, where the code
resides, and what file is used as the README for the project. These are
simple things to add but this provides a rich amount of information for
my project and prospective users based off this alone. I highly
recommend filling out the above fields for any project. There are more
options for choosing how Cargo acts based off certain feature flags or
certain options for building. There's a lot to digest there and
something you should look into if you need to customize things a bit
more. For most people the above shall suffice.

Also note I specified a package under dependencies. This will grab the
specific version from crates.io and automatically allow it to be
imported into my project and built if I decide to use it! No fiddling
with make files or things like that. Cargo does it for you. You can have
a custom build script if you want or specify a git repo for your
dependencies. All of the documentation for these features and this file
in general resides [here]() and is well worth the read for any Rustacean.
If you haven't read it before I'd recommend reading it before continuing
on.

#### Cargo subcommands
One of the neat things about Cargo is that people have been able to
build great subcommands that extend Cargo's functionality beyond just
the basics I showed above. I'm going to highlight some that I've found
useful to making my development of Rust code better.

##### cargo-clippy
##### cargo-check
##### cargo-watch
##### Subcommands List

## Build

## Ship

### Licensing
Not only have you developed an effective library or tool but it now is
fully automated for testing! Now the question is what should you license
it under? This isn't the most glamorous part of coding but it's to
protect you and your code. You don't want the code to get used and then
have someone else blame you if they misuse it and it ends up hurting
people somehow. A bit extreme of an example but it gets the point
across. Your code is publicly available now and can be used for god
knows what. You can't keep track of what's going to happen with it so
here are some of the most common examples you'll find in the Rust
Ecosystem and their pros and cons. I would highly recommend looking [here]()
for all the different options available to you and choosing a license
  that best suits your needs.

#### MIT
#### MIT/Apache-2.0 Dual License
