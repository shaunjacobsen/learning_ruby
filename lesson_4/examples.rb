Local Variables

1. The first line initializes the variable `str`, which is then modified once in the following `loop`. This illustrates local variable scope and how local variables are treated within a block. Were `str` not initialized first, there would be an error.

2. The `str` variable was not initialized outside of the block, so its scope is limited to the block.

3. No, I can't say for certain the code will run, beacuse I can't tell if `str` was initialized as a variable at the same scope, or if `str` is a method.

4. `str` was not passed into the method, so it can't be called from within the method.

5. `str` was not passed into the method, but if it were, it would still not modify the original `str`, because the `=` in the method would only reassign the value at its own scope. It is not destrucive (mutates the caller).

6. Once `a` is reassigned on line 3, it points to a different space in memory, while `b` is still pointing to the original space in memory. I can call `object_id` on the variable to confirm this.

7. At the end, there are just 2 unique objects, but 4 variables. `a`, `b`, and `c` will all point to the same object (or space in memory), while `d` is the only one that points to another object. This can be confirmed with `object_id`.

Mutating Method Arguments

1. The `change()` method did not mutate the caller, so calling `puts` on it just displays the string.

2. The `change()` method now mutates the caller, because `<<` is destructive.

3. Line 2 initializes a new variable `param` at the local scope (i.e. the scope of the method). Line 3 then mutates only the variable initialized on line 2. Because line 2 initalized a new local variable with `=`, the destructive `<<` on line 3 only affects the local scope. Regardless of the string is passed into the method, `change()` will always return "hi world".

4. `=+` on line 2 creates a new variable at the local scope, so even with two more destructive `<<` methods are only mutating the local `param` variable. The method doesn't mutate the caller, so `puts greeting` still displays the variable `greeting` assigned on line 8.

Working with Collections

1. Calling `map` on an array will perform the action defined in the subsequent block and return a new array with the results. It is not destructive, so it will not modify the original array.

2. Calling `select` on an array with return a new array with only the values that meet the criteria specified (i.e. evaluate to `true`) in the subsequent block. It is not destructive, so it does not modify the original array.

3. `reduce` takes the elements in the enumerator and performs the given function (passed in with parentheses) on the enumerator.

4. Both inline blocks use the local variable `n` to perform the specified function to increment `n` by 1. In the second example, `n` is explicitly reassigned. I prefer the first line, as it's easier to read and doesn't lead me to believe whoever wrote it is trying to reassign `n` somewhere else.

5. Using `map` will evaluate the given block on each item in the array. So, calling `n > 2` on each item in the array will evaluate to either `true` or `false`. Without running the code I can tell that it will return `[false, false, true]`.

6. `puts` is on the last line of the block, so it will display each number, then return an array of `nil` values. Calling `puts` displays what is called upon it, but it always returns `nil`. So this block iterated over each value in the array and returned `nil`.

7. `select` will return an array where the given condition evaluates to `true`. Since `n + 2` evaluates to `true` each time, the block returns an array with the same 3 values that were passed into the block, since each iteration evaluated to `true`.

8. `puts` returns `nil`, which is `false`. Therefore, each iteration evaluates to `false` and is not returned in a new array. That's why the returned array is empty.