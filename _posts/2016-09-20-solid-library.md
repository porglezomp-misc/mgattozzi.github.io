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
  - Documentation
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
you've come to a dilema. 
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
