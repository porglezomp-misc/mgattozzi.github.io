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
newer compiler version optimized this for &str -> String making it the
faster and preferred way for simple cases like this.

### to_owned()

```rust
fn main() {
    let new_string = "Hello World!".to_owned();
}
```

Since the &str is an immutable reference to a String the to_owned()
machinery can be used to turn it into a String you own and can do things
with! Generally this is a clone (copy the data into a new structure you
own) going on behind the scenes. to_owned() has uses in other places in
rust. If you look at the docs
[here](https://doc.rust-lang.org/std/borrow/trait.ToOwned.html) you'll
see that if a data type uses this trait you can call to_owned() to get
a version that you have ownership of in your code. The main thing to
take away here is that to_owned() turns an &str into a String if you
call it.

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
