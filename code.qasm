OPENQASM 3.0;

include "stdgates.inc";
qreg q[7];
creg c[3];
h q[2];
ctrl @ p(pi / 4) q[0], q[2];
ctrl @ p(pi / 2) q[0], q[2];
h q[1];
ctrl @ p(pi / 2) q[0], q[1];
h q[0];
swap q[0],q[2];
cswap q[0], q[3], q[6];
cswap q[0], q[3], q[5];
cswap q[0], q[3], q[4];

// Step B: Bitwise NOT (multiply by -1)
cx q[0], q[3];
cx q[0], q[4];
cx q[0], q[5];
cx q[0], q[6];

// 3. Multiply by 4 mod 15 (Controlled by q[1])
// Step A: Left cyclic shift by 2
cswap q[1], q[3], q[5];
cswap q[1], q[4], q[6];

// 4. Multiply by 16 mod 15 (Controlled by q[2])
// 16 mod 15 = 1. No logic gates required
swap q[0], q[2];

// 2. Unwind the Most Significant Qubit (q[2])
h q[2];

// 3. Unwind the Middle Qubit (q[1])
cp(-pi/2) q[2], q[1];
h q[1];

// 4. Unwind the Least Significant Qubit (q[0])
cp(-pi/4) q[2], q[0];
cp(-pi/2) q[1], q[0];
h q[0];

// --- MEASUREMENT ---
// We only care about measuring the counting register to find the period
measure q[0];
measure q[1];
measure q[2];