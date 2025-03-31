module injetor(
  input [14:0] entrada,
  input [3:0] n,
  input erro,
  output reg [14:0] saida
);

	always @(*)
	begin
	saida = entrada;
	if (erro)
		begin
			saida[n] = ~entrada[n]; // inverte bit na posicao especificada por n
		end
	end
endmodule
