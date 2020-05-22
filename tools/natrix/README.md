A C-like language compiler targeting CCPU.

Most important differences with C:
* Different integer types. Currently u8, u16, s8, s16 are supported.
* No implicit casts.
* No void.
* Assignments are not expressions.
* Function calls cannot be parts of expressions. They must appear on the right side of assignments or as standalone statements.
* Everything is static by default. To mark stuff global, use `export`. To import stuff, use `import`.
* Recursion is detected. For non-recursive calls stack is not used. The attribute `traitor` should be used to forced indicate a function that may cause recursion.
* There is no initialization of static variables. String and array literals (`{1,2,3}`) are allocated in a read-only section and can be assigned to pointer variables.
* Also, some features like `union`, `for`, `typedef`, and others are just not implemented.
