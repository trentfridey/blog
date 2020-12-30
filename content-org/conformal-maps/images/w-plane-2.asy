import graph;
size(300);

draw((0,1)..(-0.5,1), blue+dashed, Arrow);
draw((0,0)..(0,-0.5), blue+dashed, Arrow);
draw((1,0)..(1.5,0), blue+dashed, Arrow);

draw((0,0)..(0,1), gray+dashed);
draw((0,1)..(10,1), gray+dashed);

draw("$\pi/2$",arc((0,1),0.35,270,180),red,Arrow,
     EndPenMargin);

draw("$\pi/2$",arc((0,0),0.35,0,-90),red,Arrow,
     EndPenMargin);


dot("$(1)$",(1,0),NE,red);
//dot("$(\infty)$",(),SW,red);
dot("$(-1)$", (0,1), NE, red);
dot("$(0)$",(0,0), NE, red);
label("$w$", (2,2), SW, black);

layer();

scale(false);
xlimits(-1.5,2);
ylimits(-0.5,2);
crop();

xaxis("$r$",Arrow);
yaxis("$s$",Arrow);