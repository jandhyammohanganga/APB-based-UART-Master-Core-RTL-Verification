// transaction class

class uart_xtn extends uvm_sequence_item;
	`uvm_object_utils(uart_xtn)

	logic Presetn;
	rand logic [31:0]Paddr,Pwdata;
	rand logic Pwrite;
	logic Penable,Pslverr,Psel,Pready;
	logic [31:0] Prdata;
	logic data_in_thr,data_in_rbr,baud_o;
	

	logic [7:0] RBR[$],THR[$],IER,IIR,FCR,LCR,MCR,LSR,MSR,DIV1,DIV2,IRQ;

	function new (string name = "uart_xtn");
		super.new(name);
	endfunction

	virtual function void do_print(uvm_printer printer);
		printer.print_field("Presetn",this.Presetn,$bits(this.Presetn),UVM_BIN);
		printer.print_field("Paddr",this.Paddr,$bits(this.Paddr),UVM_DEC);
		printer.print_field("Pwdata",this.Pwdata,$bits(this.Pwdata),UVM_DEC);
		printer.print_field("Pwrite",this.Pwrite,$bits(this.Pwrite),UVM_DEC);
		printer.print_field("Penable",this.Penable,$bits(this.Penable),UVM_DEC);
		printer.print_field("Pslverr",this.Pslverr,$bits(this.Pslverr),UVM_DEC);
		printer.print_field("Prdata",this.Prdata,$bits(this.Prdata),UVM_DEC);
		printer.print_field("Pready",this.Pready,$bits(this.Pready),UVM_DEC);
		printer.print_field("data_in_thr",this.data_in_thr,$bits(this.data_in_thr),UVM_DEC);
		printer.print_field("data_in_rbr",this.data_in_rbr,$bits(this.data_in_rbr),UVM_DEC);
		printer.print_field("Psel",this.Psel,$bits(this.Psel),UVM_DEC);
		printer.print_field("baud_o",this.baud_o,$bits(this.baud_o),UVM_DEC);
		foreach(this.RBR[i])
			printer.print_field($sformatf("RBR[%0d]",i),this.RBR[i],$bits(this.RBR[i]),UVM_DEC);
		foreach(this.THR[i])
			printer.print_field($sformatf("THR[%0d]",i),this.THR[i],$bits(this.THR[i]),UVM_DEC);
		printer.print_field("IER",this.IER,$bits(this.IER),UVM_DEC);
		printer.print_field("IIR",this.IIR,$bits(this.IIR),UVM_DEC);
		printer.print_field("FCR",this.FCR,$bits(this.FCR),UVM_DEC);
		printer.print_field("LCR",this.LCR,$bits(this.LCR),UVM_DEC);
		printer.print_field("MCR",this.MCR,$bits(this.MCR),UVM_DEC);
		printer.print_field("LSR",this.LSR,$bits(this.LSR),UVM_DEC);
		printer.print_field("MSR",this.MSR,$bits(this.MSR),UVM_DEC);
		printer.print_field("DIV1",this.DIV1,$bits(this.DIV1),UVM_DEC);
		printer.print_field("DIV2",this.DIV2,$bits(this.DIV2),UVM_DEC);
		printer.print_field("IRQ",this.IRQ,$bits(this.IRQ),UVM_DEC);
	endfunction

endclass

