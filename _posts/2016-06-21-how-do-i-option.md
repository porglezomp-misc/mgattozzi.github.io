---
layout: post
title: How do I use Option<T> in Rust?
---

It's been some time since the last post. I had my two week annual
training with the national guard and I've been spending some time
working on some Rust side projects. I also wanted to spend some more
time on this post to make sure it's quality was up to snuff. While the
2nd part of the macros post will be coming soon, I wanted to cover
something that's fairly important and common in Rust. Today we're
going to cover Option<T>, why you want to use it and how.

## Why Option<T>?
/// Find a way to super script that one
If you come from a language like Haskell, Option<T> will seem very
familiar to you (Spoiler: it acts like the Maybe Monad ^1). For many
others (including myself when I was learning Haskell and Rust at
around the same time) it's a bit different than what one is used too
when dealing with the absence or existence of values in code. We use
Option<T> to denote whether there exists Some value or None at all.
This is perfect for functions like pop() for the Vec<T> data structure.
If there is no value how can it pop something off the stack? How would
we catch that with code? In languages like Java we might use null
but now we have to check for it in our code and we don't always know if
a function returns a null value or not unless the docs say they do.
If we see Option<T> in the function signature in Rust then we know we
may or may not get a value back from the function. This forces us to write
code to handle the cases of a value existing or not.

Let's take a look at it's definition:

/// Check if this is correct and link to the doc page
```rust
pub enum Option<T> {
  None,
  Some(T),
}
```

Since it's defined as an enum it can be type checked by the compiler.
It has also been made generic so it can work with any type that we need.
There's no need to define a way to denote the possibility of the absence
of a value for every possible type this way! We can also get that value
inside the Some if it exists during the execution of our code to use (e.g.
a value popped off a Vec<T> that we would want to use). Most of the code
examples and disscussion in the rest of the article will be about
extracting that T value from Some. We will, however, cover dealing with
None as a value.

That's all fine and dandy but by this point you might be asking why
would I care for this? This seems kind of verbose. In a way it is, but
it forces you and the compiler to account for the possibility of non
existent values and what you would do in the case where one comes up
or what you would do if a value was returned. While it's a pain at first
for most users when learning Rust because it seems to get in the way of
being productive. I remember using unwrap() everywhere to avoid this
starting out. Prime example of this for me is [here](LINK RUSTY). Boy does
that code have a way at avoiding idiomatic Rust. You'll find it gets easier
to explicitly deal with Option<T> and it becomes a boon in many ways as you
end up writing robust and expressive code with it.

## Getting the T from Some(T)
unwrap()
unwrap_or()
unwrap_or_else()
unwrap_or_default()
match
if let Some(x)

## Handling None
## Useful Option functions that don't extract values
The functions below are useful when dealing with Option<T>. Some do
transformations without extracting the value, others allow you to do
logic with other Option<T>, and some change T to &T or &mut T. This
section is about those functions and how they work.
is_some()
is_none()
as_ref()
as_mut()
map() (It's like an applicative functor! ///double check)
map_or() (It's like an applicative functor! ///double check)
map_or_else() (It's like an applicative functor! ///double check)
ok_or()
and()
and_then()
or()
or_else()
take()
clone()

## Conclusion

If you have a burning question that you want answered but just can't
seem to find the answer you need, shoot me an email at
mgattozzi@gmail.com and I'll write a post to answer your question! No
question is stupid. Chances are if you're having trouble with it so is
someone else so ask away!

If you're a more experienced Rust user and want to help with the wording
or give suggestions send me a PR or reach out to me and I'll include
changes if they're good. You'll also get credit for your
contributions of course!

///Sub script these and double check
1. Since Rust doesn't have higher kinded types then we can't define
   Option<T> as a monad. Thus it acts like a specific one in Haskell but
   it isn't one. Monads are also not burritos.
