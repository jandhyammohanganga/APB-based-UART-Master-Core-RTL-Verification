//UART TOP block

module uart_top;

	import uvm_pkg::*;
	import uart_pkg::*;

	logic clk0 = 0;
	logic clk1 = 0;

	wire txd,rxd;

	always
		#10 clk0 = ~clk0;
	always
		#5 clk1 = ~clk1; 

	uart_if u_if0(clk0);
	uart_if u_if1(clk1);

/*	 uart_16550 DUT1 (.PCLK(u_if0.clk),.PRESETn(u_if0.Presetn),.PADDR(u_if0.Paddr),.PWDATA(u_if0.Pwdata),.PRDATA(u_if0.Prdata),
  					  .PWRITE(u_if0.Pwrite),.PENABLE(u_if0.Penable),.PSEL(u_if0.Psel),.PREADY(u_if0.Pready),.PSLVERR(u_if0.Pslverr),
  			          .IRQ(u_if0.IRQ),.TXD(u_if0.TXD),.RXD(u_if1.RXD),.baud_o(u_if0.baud_o));
	
	uart_16550 DUT2 (.PCLK(u_if1.clk),.PRESETn(u_if1.Presetn),.PADDR(u_if1.Paddr),.PWDATA(u_if1.Pwdata),.PRDATA(u_if1.Prdata),
  					  .PWRITE(u_if1.Pwrite),.PENABLE(u_if1.Penable),.PSEL(u_if1.Psel),.PREADY(u_if1.Pready),.PSLVERR(u_if1.Pslverr),
  			          .IRQ(u_if1.IRQ),.TXD(u_if1.TXD),.RXD(u_if0.RXD),.baud_o(u_if1.baud_o));*/

	 uart_16550 DUT1 (clk0,u_if0.Presetn,u_if0.Paddr,u_if0.Pwdata,u_if0.Prdata,u_if0.Pwrite,u_if0.Penable,u_if0.Psel,u_if0.Pready,u_if0.Pslverr,
  			          u_if0.IRQ,txd,rxd,u_if0.baud_o);
	 uart_16550 DUT2 (clk1,u_if1.Presetn,u_if1.Paddr,u_if1.Pwdata,u_if1.Prdata,u_if1.Pwrite,u_if1.Penable,u_if1.Psel,u_if1.Pready,u_if1.Pslverr,
  			          u_if1.IRQ,rxd,txd,u_if1.baud_o);

	initial
		begin

			`ifdef VCS
         		$fsdbDumpvars(0,uart_top);
        		`endif

			uvm_config_db #(virtual uart_if) :: set(null,"*","u_if0",u_if0);	
			uvm_config_db #(virtual uart_if) :: set(null,"*","u_if1",u_if1);

			run_test();
		end

endmodule	
