size(300);

draw((-1,0)..(-0.5,0), blue+dashed, Arrow);
draw((0,0)..(0.5,0), blue+dashed, Arrow);
draw((1,0)..(1.5,0), blue+dashed, Arrow);

dot("$(1)$",(1,0),NE,red);
//dot("$(\infty)$",(),SW,red);
dot("$(-1)$", (-1,0), NE, red);
dot("$(0)$",(0,0), NE, red);
label("$w$", (2,2), SW, black);

import graph;

scale(false);
xlimits(-1.5,2);
ylimits(-0.5,2);
crop();

xaxis("$r$",Arrow);
yaxis("$s$",Arrow);