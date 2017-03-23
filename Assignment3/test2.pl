% test nodes for Q5:

/* test 1:
node(a).
node(b).
node(c).
node(d).
node(e).

edge(a,b).
edge(b,c).
edge(c,a).
edge(d,a).
edge(a,e).
*/

/* test 2:
node(a).
node(b).
node(c).
node(d).
node(e).
node(f).

edge(a,b).
edge(b,c).
edge(a,c).
edge(c,d).
edge(b,d).
edge(e,b).
edge(e,a).
edge(a,f).
edge(f,c).
*/

/* test 3:
node(a).
node(b).
node(c).
node(d).
node(e).
node(f).
node(g).

edge(a,b).
edge(b,c).
edge(a,c).
edge(c,d).
edge(a,d).
edge(b,e).
edge(e,d).
edge(e,f).
edge(d,f).
edge(f,g).
edge(e,g).
edge(d,g).
*/