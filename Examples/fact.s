fact = map (i) [
	?[ i<0 -> ^ 0
	  | i==0 -> ^ 1
	  |  *-> ^ i * @ (i-1) ]
];
ifact = map (i) [
	res := 1;
	k := i;
	*[ k > 0 -> res := res*k;
		    k := k-1 ];
	return (res)
];
program = map () -> () [
	*[ read_bool() -> i := read_int ();
		write_int (i);
		write_char(10);
		write_int (ifact (i));
		write_char(32);
		write_int (fact (i));
		write_char(10)
	]
]
