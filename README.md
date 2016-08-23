# cl-pcg
<b>Common Lisp Implementation of the PCG Random Number Generator</b>

cl-pcg is a common lisp implementation of the PCG random number generator as described at the <a href=http://www.pcg-random.org> PCG website</a>.  It is essentially a direct port of the <a href=http://www.pcg-random.org/download.html>minimal C implementation</a>.  It has been tested under SBCL and Lispworks.  cl-pcg allows you to specify your random state.  

To seed the random number generator with a specific state, simply execute <br><br>
  (pcg:gen-my-rand-seed <i>init-state</i> <i>init-seq</i>) <br><br>
where <i>init-state</i> and <i>init-seq</i> are 64-bit values. Otherwise, the random state may simply use the default seeding approach which is based upon system time.  To seed in this manner, execute<br><br>
  (pcg:init-pcg-seed)<br><br>
  
The random number generator may be used to generate a uniformly distributed unsigned 32-bit integer (0 <= x < 2<sup>32</sup>) by calling<br><br>
  (pcg:random-number-pcg)<br><br>
  
To generate a uniform distribution with a range of [0,1), execute<br><br>
  (pcg:pcg-rand)<br><br>
Note that the numbers generated are rounded down to the nearest multiple of 1/2<sup>32</sup>.
