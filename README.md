## Weird mutating object_ids

So the students seem to have discovered a bug in Ruby where object ids are changing at semi-random. The effect is difficult to test - as soon as you start trying to capture it (in a test, saving it to a variable), the effect disappears. The only way I've found to catch it is to just print out the object_ids.

The effect only seems to emerges at a recursion depth > 15. It also doesn't seem to be creating new object_ids but reusing old ids for previous instances of `guess_candidates`.

### Reproducing

I've been stripping out all the unneccessary code - but still a bunch is still there. The weirdness happens on lines 66 and 69.

To see the object_ids changing you can run `ruby test.rb`. To see just the lines which have changed, run:

~~~
ruby test.rb > output.txt && ruby filter.rb
~~~