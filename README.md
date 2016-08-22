# cl-pcg
<b>Common Lisp Implementation of the PCG Random Number Generator</b>

cl-pcg is a common lisp implementation of the PCG random number generator as described at the <a href=http://www.pcg-random.org> PCG website</a>.  It is essentially a direct port of the <a href=http://www.pcg-random.org/download.html>minimal C implementation</a>.  It has been tested under SBCL and Lispworks.  cl-pcg allows you to specify your random state.  

To seed the random number generator with a specific state, simply execute
  (gen-my-rand-seed <i>init-state</i> <i>init-seq</i>) 
where <i>init-state</i> and <i>init-seq</i> are 64-bit values. 
