f01:{[]
	l:read0`:input1.txt;
	nn:("one";"two";"three";"four";"five";"six";"seven";"eight";"nine"); / Names
	n:1_.Q.n; / Chars
	N:(`$nn:n,nn)!n,n; / Enumerate names/chars
	f:{[n;x]x@'i:(first;last)@\:/:where each x in\:n}n; / Find digits 
	g:{[N;n;x]N$[0h=type x;`$;`$']x:n first each(iasc min@';idesc max@')@\:x:ss/:[x;n]}[N;nn]; / Parse named numbers
	"j"$(sum"J"$f l;sum"J"$g each l) / Results 
	}
f02:{[]	
	l:read0`:input2.txt; / Input data
	gc:@[;0;"I"$5_']flip ": "vs/:l;i:gc 0;r:gc 1; / Set game ID and cubes
	c:("red";"green";"blue")!12 13 14; / Config
	cc:" "vs/:/:/:", "vs/:/:"; "vs/:r; / Count/Colour
	ccc:raze each cc; / Combined count/colour per game
	.f02.g:{"J"$x[;0]group x[;1]}; / Count by colour
	f:{[c;x]max c<sum each .f02.g x}c; / Whether a colour count exceeds limit
	"j"$(sum i where not max each f each'cc;sum(*/)each max each'.f02.g each ccc) / Results
	}
f03:{[]
	l:read0`:input3.txt; / Input data
	n:count l;m:count flip l; / Matrix dimensions
	i:(cross). til each(n;m); / All indices
	s:except[;.Q.n,"."]distinct raze l; / Distinct symbols ignoring "."
	I:(I0:cross[-1 0 1;-1 0 1])except enlist(0;0); / Windows including/excluding center
	w:(n;m)#max each s in/:l ./:/:i+/:\:I; / Where surrounding indices include symbol
	ln:l in\:.Q.n; / P1 Only consider where center is a number
	wn:where each 0<>deltas each ln; / Where numbers are
	i2n:{[i;x;y]"J"$(i!count[i]#enlist""),raze[raze y]!except\:[;"."]raze count'[raze y]#'enlist each raze x}[i]. -1_r:cut'[wn]each(l;m cut i;w&ln);
	f:{$[not"*"~y 4;0;2=count d:distinct x z where y in .Q.n;(*). d;0]}; / Find numbers from indices that surround "*", return product if exactly two
	r1:sum raze"J"$(@').@[r 0 2;1;where each max each']; / Match numbers that at least one indice is adjacent to a symbol
	r2:sum f[i2n]'[l ./:/:i+/:\:I0;i+/:\:I0]; / Find products and sum them
	"j"$(r1;r2) / Results
	}
f04:{[]
	l:read0`:input4.txt; / Input data
	f:{$[r:count where y in x;-1+r;0N]}; / Number of matching numbers in a card (-1 to account for 2 xexp)
	g:{$[y;@[x;1+z+til y;x[z]+];x]}; / Resolve copies
	r1:sum w:0^2 xexp n:f .'except''[;0N]"J"$" "vs/:/:" | "vs/:last each": "vs/:l; / Sum totals for each card
	j:til c:count n;i:c#1;w:0^1+n; / Arrays of index/cards/wins
	r2:sum g/[i;w;j]; / Iterate and process all copies/wins
	"j"$(r1;r2) / Results
	}
f05:{[]
	l:read0`:input5.txt; / Input data
	r:cut[0,where ""~/:l;l]; / Split input
	s:"J"$" "vs last ": "vs first r 0; / Seeds
	n:1_'1_r; / Raw maps
	nn:"J"$" "vs/:/:1_'n; / Lists in each map
	nn:nn@'iasc each i:.[nn;(::;::;1)]; / Sort each map based on source column
	nn:.[;(::;::;0 2 1 3)]nn[;;0 1],''-1+nn[;;0 1]+\:''nn[;;2]; / Add length to destination/source start
	sr:enlist each flip(first each cs;(+).'cs:2 cut s); / Seed ranges with counts per range (P2)
	f:{
			s:_[-1;distinct asc 0,x[;2],1+x[;3]],1+last last x; / All start bounds
			e:0W^-1+next s; / All end bounds
			n:@[count[s]#enlist 0N 0N;s?x[;2];:;x[;0 1]]; / Replace starting index where source range existed
			update s2:s1,e2:e1 from(`s2`e2`s1`e1!/:n,'s,'e)where null s2 / Return new map
			};
	nn:f each nn; / Fill maps with missing ranges
	g:{y[r;`s2]+x-y[r:bin[y[;`s1];x];`s1]}; / Binary search through maps to find range source is within
	r1:min g/[;nn]'[s]; / P1
	h:{
			{
					r:y[`s1]bin x; / Where range lies
					i:r[0]+til 1+abs (-). r; / Matched indices
					t:y[i;`s2`e2]; / Seed ranges of matches
					s:y[r 0;`s2]+x[0]-y[r 0;`s1]; / Find new start
					e:y[r 1;`e2]-y[r 1;`e1]-x 1; / Find new end
					t:.[t;(where i=first i;0);:;s]; / Adjust start
					t:.[t;(where i=last i;1);:;e]; / Adjust end
					t
					}[;y]each $[0=sum type each x;raze x;x]
			};
	r2:min min each(raze/)each h/[;nn]'[sr]; / P2
	"j"$(r1;r2) / Results
	}
f06:{[]
	l:read0`:input6.txt; / Input data
	n:except\:[;0N]"J"$l2:1_'" "vs/:l; / Numbers
	n2:"J"$raze each l2;
	r1:(*/)count each where each n[1]<{y*x-y}'[n 0;til each n 0]; / P1
	r2:count where n2[1]<{y*x-y}[n2 0;til n2 0]; / P2
	"j"$(r1;r2)
	}
f07:{[]
	l:read0`:input7.txt; / Input data
	d:reverse[s]!til count s:"AKQJT98765432"; / Enumerate cards
	b:"J"$6_'l; / Bids
	h:d 5#'l; / Enumerated hands
	d["J"]:-1; / Weaken Joker
	h2:d 5#'l; / Re-enumerate hands
	f:{[d;x;y]@[y;where d["J"]=y;:;$[count cx:enlist[d"J"]_count each x;max idesc where[cx=max cx]#cx;d"A"]]}d; / Replace Joker with highest ranked card of most occurance
	cg:count each g:group each h;g2:group each h2; / Group hands for ranking
	cg2:count each g3:group each h3:f'[g2;h2]; / Group joker hands for ranking
	n:5 4 3 2 1!1 2 4 6 7; / Map counts to rank (n[3] and n[2] are special cases)
	r:{[n;x;y]if[not (r:n[x])in 4 6;:r];b:r~4;r-not(4 3)[b]in count each y}n; / Compute rank
	r1:sum(b iasc r'[cg;g],'h)*1+til count h; / P1
	r2:sum(b iasc r'[cg2;g3],'h2)*1+til count h2; / P2 (tie break using original Joker values)
	"j"$(r1;r2) / Results
	}
f08:{[]
	l:read0`:input8.txt; / Input data
	s:first l;l:2_l;c:count s; / Sequence and node network
	d:{x[0]!flip 1_x}./:[l](::;)each 0 7 12+\:til 3; / Dictionary of nodes
	f:{[s;d;c;x]i:0;while[not "ZZZ"~x:d[x;"R"~s i mod c];i+:1];1+i}[s;d;c]; / While loop until we hit "ZZZ"
	g:{[s;d;c;x]i:0;0N!x;while[not min"Z"=last each x:.[d@/:x;(::;"R"~s i mod c)];0N!x;i+:1];0N!x;1+i}[s;d;c]; / While loop until all nodes end in "Z"
	dd:key[d]where "A"=last each key d;
	r1:f "AAA"; / P1
	r2:g dd; / P2
	"j"$(r1;r2) / Results
	}
f09:{[]
	l:read0`:input9.txt; / Input data
	l:enlist each "J"$" "vs'l; / Lists
	f:{while[max 0<>d:1_deltas last x;x:x,enlist d];x,enlist d}; / Build deltas
	r:f'[l]; / All deltas
	r1:sum('[last;sums])each('[reverse';last])each'r; / P1
	r2:sum['[('[last;{y-x}\]);reverse]each r[;;0]]; / P2
	"j"$(r1;r2) / Results
	}
f10:{[]
	l:read0`:example10.txt; / Input data
	n:count l;m:count l 0; / Dimensions
	n@:where 1=mod[;2]n:til n*m; / Possible paths from center
	s:first where"S"=r:raze l; / Starting position
	}
f11:{[]
	m:count first l:read0`:input11.txt; / Input data
	w:where each b:(min flip@;min)@\:"."=l; / rows/columns with no galaxies
	i:flip(div[;m];mod[;m])@\:g:where "#"=raze l; / (x;y) of all galaxies
	.f11.f:{z+?[-1=r;0;y*1+r:x bin'z]}[w]; / Shift indices
	p:distinct asc each raze[t,/:\:t]except 2#'t:til count g; / Pairs
	h:{(sum/)abs(-).'.f11.f[z]'[x]y}[i;p]; / Project
	"j"$(h 1;h 999999) / Results
	}
f12:{[]
	l:" "vs'read0`:example12.txt; / Input data
	s:first each l;
	g:"J"$","vs'last each l;
	}
f13:{[]
	l:" "vs'read0`:input13.txt; / Input data
	l:"#"=raze each l@where 1<>count each l:cut[0,raze 0 1+/:w:where enlist[""]~/:l;l]; / Mirrors (enumerated)
	l2:{count[x 0]cut'@[r;;not]each til count r:raze x}each l; / All possible smudges
	.f13.f:{
			n:count x;m:count x 0; / Dimensions
			nb:n mod 2;mb:m mod 2; / Optimize if even number of rows/columns
			nl:div[n;2]#2*1+til n;ml:div[m;2]#2*1+til m; / Even number of rows/columns to compare
			g:{$[y;div[r;2]+count[x]+neg@;div[;2]]r:z first where{(~).@[;1;reverse](2 0N)#x}each(::;neg)[y][z]#\:x}; / Find where perfect reflection
			raze 100 1*(g[x;;nl]'[01b];g[flip x;;ml]'[01b]) / Return
			};
	h:{sum distinct raze 0^res@'where each .f13.f[x]<>/:res:.f13.f each y}; / Compare result for each smudge with original, distinct due to more than one smudge producing the same result //! not sure why this works
	r1:sum sum each .f13.f each l; / P1
	r2:sum h'[l;l2]; / P2
	"j"$(r1;r2) / Results
	}
f14:{[]
	l:read0`:input14.txt; / Input data
	r:where each'flip each "O#"=\:l;i:r 0;i:r 1;
	.f14.f:{
			if[not count y;:x]; / No point to proceed
			s:?[-1=z bin y;y+til[count y]-y;y-0^-1+y-z[z bin y]+raze til'[count each group z z bin y]]; / Shift
			x:@[@[x;y;:;"."];s;:;"O"] / Move rocks to correct space
			};
	.f14.g:{flip .f14.f .'flip enlist[flip x],where each'flip each "O#"=\:x}; / Flip and shift rocks by column
	.f14.h:{sum reverse[1+til count x]*('[count;where])each"O"=x}; / Compute loads
	.f14.j:{.f14.g reverse each flip x}; / Rotate then shift
	.f14.k:{reverse each flip .f14.j .f14.j .f14.j .f14.g x}; / Full cycle of shifts
	.f14.R:(); / Init global to store results
	m:{.f14.R,:enlist r:(.f14.h x;x:.f14.k x 1);r}; / Cycle then compute load, store result and return for next iteration
	@[;(0;l)]('[;])over enlist[m]where enlist 125; / Minimum number of iterations to find cycle length
	n:{
			d:distinct each 1_'deltas each group x; / Distinct lengths between common nodes
			x .[{1+x+1000000000 mod y};(x?;first d@)@\:(first idesc where[1=count each d]#d)] / Find first node with most common loop length, skipping ahead to 100000000000th iteration
			};
	"j"$(.f14.h .f14.g l;n .f14.R[;0]) / Results
	}

// Testing
results:(
	55488 55614; 			/ Day 1
	2593 54699; 			/ Day 2
	527144 81463996; 		/ Day 3
	19135 5704953; 			/ Day 4
	240320250 28580589; 	/ Day 5
	2612736 29891250; 		/ Day 6
	256448566 254412181;	/ Day 7
	21251 0N; 				/ Day 8 //! Finish P2
	1806615041 1211; 		/ Day 9
	0N 0N; 					/ Day 10 //! Finish P1/P2
	9521776 553224415344; 	/ Day 11
	0N 0N; 					/ Day 12 //! Finish P1/P2
	37718 40995; 			/ Day 13
	105208 102943; 			/ Day 14
	0N 0N; 					/ Day 15
	0N 0N; 					/ Day 16
	0N 0N; 					/ Day 17
	0N 0N; 					/ Day 18
	0N 0N; 					/ Day 19
	0N 0N; 					/ Day 20
	0N 0N; 					/ Day 21
	0N 0N; 					/ Day 22
	0N 0N; 					/ Day 23
	0N 0N; 					/ Day 24
	0N 0N 					/ Day 25
	)
runTests:{[]
	ignore:`f08`f10`f12;
	f@:where like[f:system"f";"f[0-9][0-9]"];
	d:1+til count f;
	i:f?f except ignore;
	//~ runs functions twice to get result, time/space is measured on first run
	testRes:`day`ms`mem`resMatch!/:flip(d;-1;-1;0b);
	ts:system each"ts ",/:string[f:f i],\:"[]";
	.[testRes;(i;`ms`mem`resMatch);:;ts,'results[i]~'f@\:()]
	}

if[()~.z.x;show runTests[]]