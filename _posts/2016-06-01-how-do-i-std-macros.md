---
layout: post
title: How do I use the Standard Library Macros in Rust? Part 1
---

This is the second post in a series of blog posts dedicated to answering
the simple question "How do I X in Rust?" After last week's post
[/u/PLACEHOLDER]()
asked about how to use the macros available in the Standard Library.
Since there are quite a few I'll breaking up the posts into at least two
parts. This first post will cover the most common macros used in the
language. The second post will cover ones that are available, but not
used as often.

## Why would we want to use Standard Library Macros?
Do you like being able to print out text to the console? If you do so
using println!() then you're using a Standard Library macro! Maybe
you've seen code that uses try!() in Rust? If you have it's using
a Standard Library macro! These macros available to us cover common
functionality that people need, but where a function will not suffice.
A macro takes inputs much like a function does, however, when it's being
compiled it's expanded out to actual code based off of the rules it
matches and what is given as input. This makes macros pretty powerful
and flexible. Even writing a macro could be it's own series of posts.
Today though we're going to focus on how to use the Standard Library's
macros and how you can use them effectively.

The ones we'll cover in this post are:

- assert!()
- assert_eq!()
- panic!()
- print!()
- println!()
- try!()
- unimplemented!()
- unreachable!()
- vec!()
- write!()
- writeln!()

The macros we'll cover in part two are:

- cfg!()
- column!()
- concat!()
- debug_assert!()
- debug_assert_eq!()
- env!()
- file!()
- format!()
- format_args!()
- include!()
- include_bytes!()
- include_str!()
- line!()
- module_path!()
- option_env!()
- stringify!()
- thread_local!()

You'll see the first group of macros more often then not. It should be
noted that you don't need to import any of these macros as they're
implicitly included in each .rs file you create unless you set that the
file should not have the standard library available.

Alright let's jump in and learn us some macros!

### assert!()

```rust
fn main() {
  //These will pass and the code will execute the next line
  assert!(true)
  assert!(!false)
  //This will not pass and cause the code to abort
  assert!(false)
}
```

assert!() takes an input that tests for some value that gives true or
false. If true it'll continue code execution and if false will abort the
code and let you know why. This macro is great for testing as well as
for making guarantees (sometimes known as [contract
  programming](https://en.wikipedia.org/wiki/Design_by_contract)) in your code and causing it to abort if something
does not go right.

### assert_eq!()

```rust
fn main() {
  //These will pass and the code will execute the next line
  assert_eq!(1,1);
  assert_eq!("Hello","Hello");
  assert_eq!("there","there");
  assert_eq!(true,true);
  assert_eq!(false,false);
  //This will not pass and cause the code to abort
  assert_eq!(true,false);
}
```

assert_eq!() takes two parameters and compares them for equality. If
they are equal it moves on with the execution of code, if not it aborts
the code and lets you know what happened. Notice how you can pass any
two types there? The macro is able to take a variety of different inputs
unlike a function in Rust which has to`be given a type signature. This
allows us to test for all kinds of different types of equalities using
one macro! Can you imagine having to test for equality with a whole
bunch of functions designed for specific types? It would be a real pain
to deal with and that's why this macro is real nice for asserting things
are equal. It's greatly used in testing or guaranteeing two things are
equal in your code as it executes.

### panic!()

```rust
fn main() {
  let test = String::from("Hello");

  // This is a trivial example but the code here will
  // always panic.
  if test.is_empty() {
    println!("String is empty");
  } else {
    panic!("Uh oh the String was not empty. Aborting");
  }
}
```

panic!() is a macro used to deallocate all resources gracefully and exit
your program. Usually you'll use panic!() if you want code to abort
execution in your program in a defined safe way. This is what is
called if you try to unwrap a None value or an Err value for instance.
You can pass it a string much like println!() meaning you can do
something like this:

```rust
// Where we define e as an Error earlier in the code
panic!("This is my error: {}", e);
```

e will be passed into the {} as part of the string. You can have any
number of {} or {:?} (the debug variant of {}). Just make sure you
supply enough arguments after to fill in those spots in the string.
The string passed to the macro shows up as a message after the code
aborts running.

### print!()

```rust
use std::io::{stdout,Write};

fn main() {
  let num = 5;
  let num2 = 9;
  print!("This is output to stdout without a newline char");
  print!("\nI told it to print a newline twice \n");
  print!("The variable num has a value of: {}", num);
  //Debug output version
  print!("\nThe variable num has a value of: {:?}", num);
  //Outputs The variable num has a value of: 5 Also num2: 9
  print!("\nThe variable num has a value of: {} Also num2: {}", num, num2);
  //Makes sure print!() items get flushed to stdout for the user to see
  stdout().flush();
}
```

print!() is a macro that outputs text to stdout without adding a new
line char at the end of the string that it prints out. It can take any
number of inputs, one for each {} or {:?}. One thing that should be
noted is that print!() doesn't flush output to stdout automatically like
println!() does for whatever reason. Since it doesn't if you want the
output there immediately you can add a call to flush it like in the
above example.



### println!()

```rust
fn main() {
  let num = 5;
  let num2 = 9;
  println!("This is output to stdout with a newline char");
  println!("The variable num has a value of: {}", num);
  //Debug output version
  println!("The variable num has a value of: {:?}", num);
  //Outputs The variable num has a value of: 5 Also num2: 9
  println!("The variable num has a value of: {} Also num2: {}", num, num2);
}
```

println!() is a macro that outputs text to stdout and adds a new line
char at the end of the string that it prints out. It can take any
number of inputs, one for each {} or {:?}. Unlike print!(), println!()
automatically flushes to stdout on calling it. Generally you'll see this
more than print being used for reasons like this.

### try!()

```rust
// This is a snippet of code I've been writing for one project and it has
// been simplified a bit.
fn main() {

}
```

I'll be honest, up until about two weeks ago I didn't know how this
worked, and I've been using Rust since 1.0 came out. That's why I'm
writing this, so you don't have to fumble around with it.

### unimplemented!()

```rust
fn main() {
  // What we care about with this made up function is that it returns an
  // Option<u32> no need to actually show an implementation
  let x = fib_seq(10);
  match x {
    Some(y) = println!("{}",y),
    None    = unimplemented!(),
  }

}
```

### unreachable!()

```rust
fn main() {

}
```

### vec!()

```rust
fn main() {

}
```

### write!()

```rust
fn main() {

}
```

### writeln!()

```rust
fn main() {

}
```

## Conclusion

Here's the quick rundown of all the macros we just covered:

- assert!() = Assert a boolean statement is true, abort if false
- assert_eq!() = Assert an equality is true, abort if false
- panic!() = Abort the code, release resources, and print out the string
  to the console that was passed to it.
- print!() = Print the string out to stdout without a newline character
- println!() = Print the string out to stdout with a newline character
- try!() = Attempt to unwrap a Result, returns an error if present.
  Requires the method to return a Result of some type if used.
- unimplemented!() = Useful for stub functions to let the code compile
  and pass the type checker. Will abort the code if used and it comes to
  that macro somehow.
- unreachable!() = Let's the compiler know that this branch of the code
  is impossible to reach to allow for optimizations. If it's reached
  somehow during execution the code will panic and abort.
- vec!() = Takes a slice of some type and turns it into a Vector of the
  type of the items in the slice.
- write!() = Write a line to a buffer without a newline character. This
  is usually used to write to a file of some sort.
- writeln!() = Write a line to a buffer with a newline character. This
  is usually a file of some sort.

These are the most common ones you'll see used in Rust code, but you
might see the other ones that I'll cover in the next post out in the
wild. This should give you a good grasp of what is available to you as
a user of the language and a taste of how powerful macros can be.

If you have a burning question that you want answered but just can't
seem to find the answer you need, shoot me an email at
mgattozzi@gmail.com and I'll write a post to answer your question! No
question is stupid. Chances are if you're having trouble with it so is
someone else so ask away!

If you're a more experienced Rust user and want to help with the wording
or give suggestions send me a PR or reach out to me and I'll include
changes if they're good. You'll also get credit for your
contributions of course!
