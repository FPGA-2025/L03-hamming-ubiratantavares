// Hamming 15:11

module calcula_hamming (
	input [10:0] entrada, // e0..e10
	output [14:0] saida   // s0..s14: p0 p1 
);
	
	wire [3:0] paridade; // bits de paridade: paridade[0] = p1; paridade[1] = p2; paridade[2] = p4; paridade[3] = p8;

	// cálculo da paridade paridade[0] = p1
	assign paridade[0] = entrada[0] ^ entrada[1] ^ entrada[3] ^ entrada[4] ^ entrada[6] ^ entrada[8] ^ entrada[10];
	
	// cálculo da paridade paridade[1] = p2
	assign paridade[1] = entrada[0] ^ entrada[2] ^ entrada[3] ^ entrada[5] ^ entrada[6] ^ entrada[9] ^ entrada[10];
	
	// cálculo da paridade paridade[2] = p4
	assign paridade[2] = entrada[1] ^ entrada[2] ^ entrada[3] ^ entrada[7] ^ entrada[8] ^ entrada[9] ^ entrada[10];
	
	// cálculo da paridade paridade[3] = p8
	assign paridade[3] = entrada[4] ^ entrada[5] ^ entrada[6] ^ entrada[7] ^ entrada[8] ^ entrada[9] ^ entrada[10];

	// montagem do vetor de saída
	assign saida = {entrada[10], entrada[9], entrada[8], entrada[7], entrada[6], 
					entrada[5], entrada[4], paridade[3], entrada[3], entrada[2], 
					entrada[1], paridade[2], entrada[0], paridade[1], paridade[0]};
	
endmodule
