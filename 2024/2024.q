set'[`$"f",/:-2#'"0",/:string 1+til 25;{}];

f01:{[] 
	p1:sum abs(-). {x iasc x}each l:flip"J"$"   "vs/:read0`:data/input1.txt; / Part 1
	p2:sum l[0]*0^count'[group l 1]l 0; / Part 2
	(p1;p2)
	}

f02:{[]
	d:"J"$" "vs/:read0`:data/input2.txt; / Get data
	f:{(not 0b in'(abs 1_'deltas each x)within\:1 3)&(|/)not 0b in''(0>;0<)@\:1_'deltas each x}; / Safe report check
	p1:sum f d; / Part 1
	p2:sum 1b in'sums[0,count each d]_f raze d _/:'til each count each d; / Part 2
	(p1;p2)
	}

f03:{[]
	l:raze read0`:data/input3.txt; / Get data
	p:(,'[;")"]"mul(",/:-1_'{x cross x}("[0-9],";"[0-9][0-9],";"[0-9][0-9][0-9],")),d:("don't()";"do()"); / Regex patterns; mul([0-9],[0-9]), mul([0-9],[0-9][0-9]), etc.
	c:(6+sum each{x cross x}1 2 3),count each d; / Counts of strings at each match
	m:l i:asc raze i:{x+\:'til each y}.(w;c)@\:where 0<count each w:l ss/:p; / All matching strings extracted
	f:{sum(*).'"J"$","vs'4_'-1_'x}; / Helper function
	p1:f mm:m except d; / Extract numbers and calculate products
	p2:f raze'[{x[;1]where x[;0]}{z;$[z in x;("b"$x?z;$[z~last x;z;""]);(first y;z)]}[d]\[(1b;());m]]except d; / Iterate through matches starting with enabled state
	(p1;p2)
	}

f04:{[]
	l:read0`:data/input4.txt; / Get data
	x:raze til[count l],''where each l="X"; / Each 'X' location
	a:raze til[count l],''where each l="A"; / Each 'A' location
	j:((nr;0);(r;0);(0;nr);(0;r);(nr;r);(r;r);(r;nr);(nr;nr:neg r:til 4)); / Vertical/Horizontal/Diagonal paths from each 'X'
	b:-1+til 3; / Diagonals for X-MAS
	f:{(,'). x+\:'y}; / Creates lists of all possible directions originating at each 'X'
	p1:sum(l ./:/:raze f/:\:[x;j])like"XMAS"; / Match where the extracted word is XMAS
	p2:sum{[l;x;y] 1<sum(|/)like/:[l ./:/:(,').'((x+y 0;x+y 1);(reverse x+y 0;x+y 1));("MAS";"SAM")]}[l;b]each a; / Match where the extracted words spell MAS at least twice
	(p1;p2)
	}

f05:{[]
	r:{("J"$x[;3 4])group "J"$x[;0 1]}l til w:first where~\:[l:read0`:data/input5.txt;""]; / Rules
	ur:reverse each u:"J"$","vs/:(1+w)_l; / Updates
	uu:u w:where b:{x~'desc each x}c:count each'r[u]inter\:'u; / Updates in the correct order
	f:{sum x@'"j"$%[;2] -1+count each x}; / Helper function to sum middle numbers
	p1:f uu; / Part 1
	p2:f u[w]@'idesc each c[w:where not b]; / Part 2
	(p1;p2)
	}

// Testing
results:(
        1873376 18997088; 			/ Day 1
        479 531; 					/ Day 2
        157621318 79845780;			/ Day 3
        2530 1921; 					/ Day 4
        5639 5273;					/ Day 5
        0N 0N; 						/ Day 6
        0N 0N; 						/ Day 7
        0N 0N; 						/ Day 8
        0N 0N; 						/ Day 9
        0N 0N; 						/ Day 10
        0N 0N; 						/ Day 11
        0N 0N; 						/ Day 12
        0N 0N; 						/ Day 13
        0N 0N; 						/ Day 14
        0N 0N; 						/ Day 15
        0N 0N; 						/ Day 16
        0N 0N; 						/ Day 17
        0N 0N; 						/ Day 18
        0N 0N; 						/ Day 19
        0N 0N; 						/ Day 20
        0N 0N; 						/ Day 21
        0N 0N; 						/ Day 22
        0N 0N; 						/ Day 23
        0N 0N; 						/ Day 24
        0N 0N  						/ Day 25
        )

// Run tests
runTests:{[]
        ignore:`f06`f07`f08`f09`f10`f11`f12`f13`f14`f15`f16`f17`f18`f19`f20`f21`f22`f23`f24`f25; //~ Remove as we solve
        f@:where like[f:system"f";"f[0-9]*"];
		f@:iasc"J"$1_'string f;
        d:1+til count f;
        i:f?f except ignore;
        t:1!flip`day`ms`mem`resMatch`res!"JJJB*"$\:();
        t upsert/{[f;fn;r;i] enlist[1+i],f[fn i;r i],enlist r i}[fts;f;results]each i 
        }
fts:{[f;r].Q.gc[];ts:system ssr["ts .dbg.res:`long$f[]";"f";string f];res:r~.dbg.res;delete res from`.dbg;.Q.gc[];ts,enlist res}
system"c 40 175"
if[()~.z.x;show testRes:runTests[]]
