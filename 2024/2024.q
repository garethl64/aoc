set'[`$"f",/:string 1+til 25;{}]

f1:{[] 
	p1:sum abs(-). {x iasc x}each l:flip"J"$"   "vs/:read0`:data/input1.txt;
	p2:sum l[0]*0^count'[group l 1]l 0;
	(p1;p2)
	}

// Testing
results:(
        1873376 18997088; 			/ Day 1
        0N 0N; 						/ Day 2
        0N 0N; 						/ Day 3
        0N 0N; 						/ Day 4
        0N 0N; 						/ Day 5
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
        ignore:`f2`f3`f4`f5`f6`f7`f8`f9`f10`f11`f12`f13`f14`f15`f16`f17`f18`f19`f20`f21`f22`f23`f24`f25; //~ Remove as we solve
        f@:where like[f:system"f";"f[0-9]*"];
        d:1+til count f;
        i:f?f except ignore;
        t:1!flip`day`ms`mem`resMatch`res!"JJJB*"$\:();
        t upsert/{[f;fn;r;i] enlist[i],f[fn i;r i],enlist r i}[fts;f;results]each i 
        }
fts:{[f;r].Q.gc[];ts:system ssr["ts .dbg.res:f[]";"f";string f];res:r~.dbg.res;delete res from`.dbg;.Q.gc[];ts,enlist res}
system"c 40 175"
if[()~.z.x;show testRes:runTests[]]
