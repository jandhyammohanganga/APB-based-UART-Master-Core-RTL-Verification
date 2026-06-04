// UART SB

class uart_sb extends uvm_scoreboard;
	`uvm_component_utils(uart_sb)
	
	uvm_tlm_analysis_fifo#(uart_xtn) tlm_fifo[2];
	uart_xtn sb_xtn[2];
	
	covergroup UART_0;
		PRESETN : coverpoint sb_xtn[0].Presetn {bins Presetn = {[0:1]};}
		PAADR   : coverpoint sb_xtn[0].Paddr {bins Paddr = {[0:$]};}
		PSEL    : coverpoint sb_xtn[0].Psel {bins Psel = {[0:1]};}
		PENABLE : coverpoint sb_xtn[0].Penable {bins Penable = {[0:1]};}
		PWDATA  : coverpoint sb_xtn[0].Pwdata {bins Pwdata = {[0:$]};}
		PWRITE  : coverpoint sb_xtn[0].Pwrite {bins Pwrite = {[0:1]};}
		PRDATA  : coverpoint sb_xtn[0].Prdata {bins Prdata = {[0:$]};}
		PREADY  : coverpoint sb_xtn[0].Pready {bins Pready = {[0:1]};}
		PSLVERR : coverpoint sb_xtn[0].Pslverr {bins slverr = {[0:1]};}
		IRQ     : coverpoint sb_xtn[0].IRQ {bins IRQ = {[0:1]};}
		BAUD_O  : coverpoint sb_xtn[0].baud_o {bins baud_o = {[0:1]};}
	endgroup


	covergroup UART_1;
		PRESETN : coverpoint sb_xtn[1].Presetn {bins Presetn = {[0:1]};}
		PAADR   : coverpoint sb_xtn[1].Paddr {bins Paddr = {[0:$]};}
		PSEL    : coverpoint sb_xtn[1].Psel {bins Psel = {[0:1]};}
		PENABLE : coverpoint sb_xtn[1].Penable {bins Penable = {[0:1]};}
		PWDATA  : coverpoint sb_xtn[1].Pwdata {bins Pwdata = {[0:$]};}
		PWRITE  : coverpoint sb_xtn[1].Pwrite {bins Pwrite = {[0:1]};}
		PRDATA  : coverpoint sb_xtn[1].Prdata {bins Prdata = {[0:$]};}
		PREADY  : coverpoint sb_xtn[1].Pready {bins Pready = {[0:1]};}
		PSLVERR : coverpoint sb_xtn[1].Pslverr {bins slverr = {[0:1]};}
		IRQ     : coverpoint sb_xtn[1].IRQ {bins IRQ = {[0:1]};}
		BAUD_O  : coverpoint sb_xtn[1].baud_o {bins baud_o = {[0:1]};}
	endgroup

	covergroup UART0_REGISTER;
		DIV1_MSB : coverpoint sb_xtn[0].DIV1 {bins DIV1[] = {32'h0};}
		DIV2_LSB : coverpoint sb_xtn[0].DIV2 {bins DIV2[] = {27};}
		LCR      : coverpoint sb_xtn[0].LCR  {bins LCR[] = {8'b00000011,8'b00001011,8'b01000011};}
		FCR      : coverpoint sb_xtn[0].FCR  {bins FCR[]  = {8'b00000110,8'b10000110};}
		IER      : coverpoint sb_xtn[0].IER  {bins IER[]  = {8'b00000101,8'b00000100,8'b00000010,8'b00000000};}
		THR      : coverpoint sb_xtn[0].THR[$] {bins THR  = {[1:255]};}
		IIR      : coverpoint sb_xtn[0].IIR[3:0]  {bins IIR[]  = {4'h4,4'h6};}
		MCR      : coverpoint sb_xtn[0].MCR  {bins MCR  = {8'b00010000};}
	endgroup

		covergroup UART1_REGISTER;
		DIV1_MSB : coverpoint sb_xtn[1].DIV1 {bins DIV1[] = {32'h0};}
		DIV2_LSB : coverpoint sb_xtn[1].DIV2 {bins DIV2[] = {54};}
		LCR      : coverpoint sb_xtn[1].LCR  {bins LCR[]  = {8'b00000011,8'b00011011,8'b01000011,8'b00000000};}
		FCR      : coverpoint sb_xtn[1].FCR  {bins FCR[]  = {8'b00000110,8'b11000110};}
		IER      : coverpoint sb_xtn[1].IER  {bins IER[]  = {8'b00000101,8'b00000100,8'b00000010,8'b00000000};}
		THR      : coverpoint sb_xtn[1].THR[$]  {bins THR  = {[1:255]};}
		IIR      : coverpoint sb_xtn[1].IIR[3:0]  {bins IIR[]  = {4'h4,4'h6};}
		MCR      : coverpoint sb_xtn[1].MCR  {bins MCR  = {8'b00010000};}
	endgroup

	
	function new(string name = "uart_sb", uvm_component parent);
		super.new(name, parent);
		foreach(tlm_fifo[i])
		tlm_fifo[i] = new($sformatf("tlm_fifo[%0d]",i));
		UART_0 = new;
		UART_1 = new;
		UART0_REGISTER = new;
		UART1_REGISTER = new;
	endfunction


	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		foreach(sb_xtn[i])
		sb_xtn[i]=uart_xtn::type_id::create($sformatf("sb_xtn[%0d]",i));
	endfunction
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
		forever
			begin
				fork
					begin	
						tlm_fifo[0].get(sb_xtn[0]);
						sb_xtn[0].print;
					end
				
					begin
						tlm_fifo[1].get(sb_xtn[1]);
						sb_xtn[1].print;
					end
					
				join
			end
	endtask
	
	function void check_phase(uvm_phase phase);
		super.check_phase(phase);
		
		// For sb_xtn[0]
		foreach(sb_xtn[0].RBR[i])
		$display($sformatf("Printing in RBR[%0d]",i),sb_xtn[0].RBR[i]);
		foreach(sb_xtn[0].THR[i])
		$display($sformatf("Printing in THR[%0d]",i),sb_xtn[0].THR[i]);
		$display("Printing in sb_xtn[0] IER[%0d]",sb_xtn[0].IER);
		$display("Printing in IIR[%0d]",sb_xtn[0].IIR);
		$display("Printing in FCR[%0d]",sb_xtn[0].FCR);
		$display("Printing in LCR[%0d]",sb_xtn[0].LCR);
	//	$display("Printing in FCR[%0d]",sb_xtn[0].FCR);
		$display("Printing in MCR[%0d]",sb_xtn[0].MCR);
		$display("Printing in LSR[%0d]",sb_xtn[0].LSR);
		$display("Printing in MSR[%0d]",sb_xtn[0].MSR);
		$display("Printing in DIV1[%0d]",sb_xtn[0].DIV1);
		$display("Printing in DIV2[%0d]",sb_xtn[0].DIV2);
		
		$display("-----------------------------------------------------");
		//For sb_xtn[1]
		foreach(sb_xtn[1].RBR[i])
		$display($sformatf("Printing in RBR[%0d]",i),sb_xtn[1].RBR[i]);
		foreach(sb_xtn[1].THR[i])
		$display($sformatf("Printing in THR[%0d]",i),sb_xtn[1].THR[i]);
		$display("Printing in sb_xtn[1] IER[%0d]",sb_xtn[1].IER);
		$display("Printing in IIR[%0d]",sb_xtn[1].IIR);
		$display("Printing in FCR[%0d]",sb_xtn[1].FCR);
		$display("Printing in LCR[%0d]",sb_xtn[1].LCR);
	//	$display("Printing in FCR[%0d]",sb_xtn[1].FCR);
		$display("Printing in MCR[%0d]",sb_xtn[1].MCR);
		$display("Printing in LSR[%0d]",sb_xtn[1].LSR);
		$display("Printing in MSR[%0d]",sb_xtn[1].MSR);
		$display("Printing in DIV1[%0d]",sb_xtn[1].DIV1);
		$display("Printing in DIV2[%0d]",sb_xtn[1].DIV2);
		
		if((sb_xtn[0].THR==sb_xtn[1].RBR) && (sb_xtn[0].RBR==sb_xtn[1].THR))
		`uvm_info(get_type_name(),"\n SB Full Duplex",UVM_MEDIUM)
		if((sb_xtn[0].THR==sb_xtn[1].RBR) || (sb_xtn[0].RBR==sb_xtn[1].THR))
		`uvm_info(get_type_name(),"\n SB Half Duplex",UVM_MEDIUM)
		if((sb_xtn[0].THR==sb_xtn[0].RBR) || (sb_xtn[1].RBR==sb_xtn[1].THR))
		`uvm_info(get_type_name(),"\n SB in Loopback",UVM_MEDIUM)
		
		if((sb_xtn[0].IIR[3:1]==3) || (sb_xtn[1].IIR[3:1]==3))
			begin
				$display("inside if of iir");
				if((sb_xtn[0].LSR[1] == 1) || (sb_xtn[1].LSR[1] == 1))
				`uvm_info(get_type_name(),"\n SB Overrun error",UVM_MEDIUM)
				if((sb_xtn[0].LSR[2] == 1) || (sb_xtn[1].LSR[2] == 1))
				`uvm_info(get_type_name(),"\n SB Parity error",UVM_MEDIUM)
				if((sb_xtn[0].LSR[3] == 1) || (sb_xtn[1].LSR[3] == 1))
				`uvm_info(get_type_name(),"\n SB Framing error",UVM_MEDIUM)
				if((sb_xtn[0].LSR[4]==1) || (sb_xtn[1].LSR[4]==1))
				`uvm_info(get_type_name(),"\n SB Break Interuupt error",UVM_MEDIUM)		
			end
			
	//	else
	//	$display("Failed");
		
		if((sb_xtn[0].IIR[3:1]==3'b110) || (sb_xtn[1].IIR[3:1]==3'b110))
		`uvm_info(get_type_name(),"\n SB Time_Out error",UVM_MEDIUM)	
		if((sb_xtn[0].IIR[3:1]==3'b001) || (sb_xtn[1].IIR[3:1]==3'b001))
		`uvm_info(get_type_name(),"\n SB Empty error",UVM_MEDIUM)	
		

		UART_0.sample;
		UART_1.sample;
		UART0_REGISTER.sample;
		UART1_REGISTER.sample;
	endfunction
	
endclass
