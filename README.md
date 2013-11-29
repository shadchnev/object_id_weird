## Weird mutating object_ids

So the students seem to have discovered a bug in Ruby where object ids are changing at semi-random. The effect is difficult to test - as soon as you start trying to capture it (in a test, saving it to a variable), the effect disappears. The only way I've found to catch it is to just print out the object_ids.

The effect only seems to emerges at a recursion depth > 15. It also doesn't seem to be creating new object_ids but reusing old ids for previous instances of `guess_candidates`.

### Reproducing

I've been stripping out all the unneccessary code - but still a bunch is still there. The weirdness happens on lines 66 and 69.

To see the object_ids changing you can run `ruby test.rb`. To see just the lines which have changed, run:

~~~
ruby test.rb > output.txt && ruby filter.rb
~~~


## James's debugging
I thought it might just be jumping to a different solve call and added a few more prints, which helped me narrow it down.

It only happens with the candidates length is 0, which means the " v ..." must be from a different call, as the next each would be on an empty array.

### `[length, id difference]` pairs

    [0, 154040], [1, 0], [0, 159940], [2, 0], [1, 0], [0, 52600], [1, 0]

### `"c#{length} ... v ... each_with_index:#{index}"`

    c0- 70153413607620 v 70153413643480 @ with_index:1 @ iter 368 @ depth 69
    c0- 70153413519620 v 70153417385880 @ with_index:1 @ iter 369 @ depth 67
    c2- 70153413483920 v 70153413483920 @ with_index:0 @ iter 370 @ depth 68
    c2- 70153412926720 v 70153412926720 @ with_index:0 @ iter 371 @ depth 69

### Random call id
Giving each call to make_a_guess a random call id string highlights this.

`call = rand(36**10).to_s(36)` added:

    c0- call:7i2cp514kg 70129039937160 v 70129039826680 @ call:8d7mvum0dm
    c1- call:oppx5hwlob 70129039988220 v 70129039988220 @ call:oppx5hwlob
    c0- call:t92zvqbju8 70129040037680 v 70129056485880 @ call:plstx99fhc
    c2- call:j3she5prrk 70129043996940 v 70129043996940 @ call:j3she5prrk