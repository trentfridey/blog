size(300);
pair z0=(0,0); // image of 1
pair z1=(1,0); // image of infty
pair z2=(1,1); // image of -1
pair z3=(0,1); // image of 0

path g=z0--z1--z2--z3--cycle;
fill(g, palegrey);

draw(z0..z1,gray+dashed);
draw(z0..(0,-0.5),blue+dashed, Arrow);
draw(z1..z2,gray+dashed);
draw(z3..(-0.5,1), blue+dashed, Arrow);
draw(z2..z3, gray+dashed);
draw(z2..(1,1.5), blue+dashed, Arrow);
draw(z3..z0, blue+dashed);

draw("$\pi/2$",arc(z0,0.3,0,-90),red,Arrow,
     EndPenMargin);

draw("$\pi/2$",arc(z2,0.3,180,90),red,Arrow,
     EndPenMargin);

draw("$\pi/2$",arc(z3,0.3,270,180),red,Arrow,
     EndPenMargin);

dot("$(1)$",z0,NE,red);
dot("$(\infty)$",z1,SW,red);
dot("$(-1)$", z2, SW, red);
dot("$(0)$",z3, NE, red);
label("$w$", (2,2), SW, black);

import graph;

scale(false);
xlimits(-1,2);
ylimits(-0.5,2);
crop();

xaxis("$r$",Arrow);
yaxis("$s$",Arrow);