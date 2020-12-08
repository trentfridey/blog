size(0,100);
import patterns;
import graph;
path p = (-10,0)--(0,0)--(0,-0.5)--(-10,-0.5)--cycle;

add("hatch",hatch(3mm));

filldraw(p,pattern("hatch"));


xlimits(-10,10);
ylimits(-0.5,10);
label("$V$",(-5,0.5), NE);
label("$0$", (5,0.5),NE);
crop();
xaxis("$x$");
yaxis("$y$");