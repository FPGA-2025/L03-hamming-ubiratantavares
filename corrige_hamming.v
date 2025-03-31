module corrige_hamming (
	input [14:0] entrada, // a paridade é o bit mais significativo (dado[8])
	output reg [10:0] saida
);

	wire [3:0] paridade; // [p8, p4,  p2, p1]
	wire [3:0] sindrome; 

    reg [14:0] entrada_corrigida;
	reg erro_detectado;  // indica se houve erro
	
	// calculando os bits de paridade
	assign paridade[0] = entrada[0] ^ entrada[2] ^ entrada[4] ^ entrada[6] ^ entrada[8] ^ entrada[10] ^ entrada[12] ^ entrada[14];
	assign paridade[1] = entrada[1] ^ entrada[2] ^ entrada[5] ^ entrada[6] ^ entrada[9] ^ entrada[10] ^ entrada[13] ^ entrada[14];
	assign paridade[2] = entrada[3] ^ entrada[4] ^ entrada[5] ^ entrada[6] ^ entrada[11] ^ entrada[12] ^ entrada[13] ^ entrada[14];
	assign paridade[3] = entrada[7] ^ entrada[8] ^ entrada[9] ^ entrada[10] ^ entrada[11] ^ entrada[12] ^ entrada[13] ^ entrada[14];
	
  	// gerando a síndrome (indica a posição do bit errado)
  	assign sindrome = paridade;
	
  	always @(*) 
  	begin
    	entrada_corrigida = entrada; // presumindo que não há erro inicialmente
    	erro_detectado = (sindrome != 4'b0000);  // se sindrome é diferente de 0000, houve erro	
    	if (erro_detectado) 
			entrada_corrigida[sindrome - 1] = ~entrada[sindrome - 1]; // corrige o erro

  		// montando a saída através da extração dos bits de dados da entrada_corrigida
    	saida = {entrada_corrigida[14], entrada_corrigida[13], entrada_corrigida[12], entrada_corrigida[11], entrada_corrigida[10], 
        	     entrada_corrigida[9], entrada_corrigida[8], entrada_corrigida[6], entrada_corrigida[5], entrada_corrigida[4], entrada_corrigida[2]};
  	end
endmodule
