---
layout: post
title: How do I convert a &str to a String in Rust?
---

This is the first in a whole series of blog posts to answer the simple
question "How do I $THING in Rust?" Many times as a user coming into the
Rust language there are growing pains and some things that seem
intuitive after using the language for a while aren't that much for
a new user. This is aimed at those new users.

With that in mind let's jump right in!

## Converting a &str to a String

Surprisingly there are quite a few ways to do this and depending on what
you're trying to do one of the methods layed out below will be more
appropriate.

### to_string()

```rust
fn main() {
    let new_string = "Hello World!".to_string();
}
```

to_string() turns an &str into a String. Back before [this pr in version
1.9](https://github.com/rust-lang/rust/pull/32586) of the compiler this
was actually slower than the next method I'll be showing you. It went
through crazy amounts of machinery to turn it into a String whereas the
newer compiler version optimized this for &str -> String making it
equivalent to the next method speed wise.

### to_owned()

```rust
fn main() {
    let new_string = "Hello World!".to_owned();
}
```

Since the &str is an immutable reference to a String using to_owned()
turns it into a String you own and can do things with! This is now the
same as to_string(), but was the preferred way prior to 1.9. to_owned()
is used for other data types to promote an immutable reference into a
data type you own.

### String::from()

```rust
fn main() {
    let new_string = String::from("Hello World!");
}
```

When you are using to_string() in any compiler after 1.9 you're actually
using this method. to_string() ends up being syntactic sugar for it.
You hand an &str into the from method and from there it constructs
a String type for you to use.

### String::new(); String::push_str();

```rust
fn main() {
    let mut new_string = String::new(); //Create an empty string
    new_string.push_str("Hello");
    new_string.push_str(" World!");
    println!("{}", new_string); //Prints Hello World!
}
```

Since a String is a growable data type you can add to it by pushing &str
into it. While this is a bit verbose for the example I gave above you
could use it to concatenate a variety of &str into one String that you
can then manipulate to do other things.

## Conclusion

Above are the various ways you can make a String from a &str and each
serves a different purpose:

- .to_string() if you want a simple conversion
- .to_owned() if you want a simple conversion
- String::from() a more explicit way to say what you're doing
- String::push_str() if you need to append to a String

If you have a burning question that you want answered but just can't
seem to find the answer you need shoot me an email at
mgattozzi@gmail.com and I'll write a post to answer your question! No
question is stupid. Chances are if you're having trouble with it so is
someone else so ask away!
