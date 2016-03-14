# solution of fast growing recursive function ackerman(mc,nc)
mC : int = 3;
nC : int = 8;
acker = map (m, n) [
    ?[ m==0 -> ^ n+1
      | n==0 -> ^ @(m-1, 1)
      |  *-> ^ @(m-1, @(m, n-1))
	]
];
program = map () -> () [
    print_int (acker (mC, nC));
    print_char (10)
]
