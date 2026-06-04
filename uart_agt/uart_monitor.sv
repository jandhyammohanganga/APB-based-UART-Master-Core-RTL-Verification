//uart monitor

class uart_monitor extends uvm_monitor;

	`uvm_component_utils(uart_monitor)

	virtual uart_if.MON_MP vif;
	uvm_analysis_port#(uart_xtn) mon_port;
	uart_agt_cfg a_cfg;
	uart_xtn u_xtnh;

	function new(string name ="uart_monitor", uvm_component parent);
		super.new(name,parent);
		mon_port = new("mon_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!(uvm_config_db #(uart_agt_cfg) :: get(this,"","uart_agt_cfg",a_cfg)))
			`uvm_fatal("UART_MON","set_not_configured")

		u_xtnh = uart_xtn :: type_id :: create("u_xtnh");
		
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif = a_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		//repeat(2)
		   @(vif.mon_cb);
		forever
		 begin
			collect_to_dut();
			mon_port.write(u_xtnh);
		 end
	endtask

	task collect_to_dut();
		@(vif.mon_cb);

		while(vif.mon_cb.Psel!==1)
		@(vif.mon_cb);
		begin
		while(vif.mon_cb.Pready !== 1)
		@(vif.mon_cb);
		u_xtnh.Presetn = vif.mon_cb.Presetn;
		u_xtnh.Paddr = vif.mon_cb.Paddr; 
		u_xtnh.Pwrite = vif.mon_cb.Pwrite;
		u_xtnh.Pwdata = vif.mon_cb.Pwdata;
		u_xtnh.Prdata = vif.mon_cb.Prdata;
		u_xtnh.Pslverr = vif.mon_cb.Pslverr;
		u_xtnh.Psel = vif.mon_cb.Psel;
		u_xtnh.Penable = vif.mon_cb.Penable;
		u_xtnh.Pready = vif.mon_cb.Pready;
		u_xtnh.IRQ = vif.mon_cb.IRQ;
		u_xtnh.baud_o = vif.mon_cb.IRQ;		
		@(vif.mon_cb);
		
		//updating LCR
		if(u_xtnh.Paddr == 32'h0c && u_xtnh.Pwrite == 1'b1)
			u_xtnh.LCR = u_xtnh.Pwdata;
		
		//updating IER
		if(u_xtnh.Paddr == 32'h04 && u_xtnh.Pwrite == 1'b1)
			u_xtnh.IER = u_xtnh.Pwdata;

		//updating FCR
		if(u_xtnh.Paddr == 32'h08 && u_xtnh.Pwrite == 1'b1)
			u_xtnh.FCR = u_xtnh.Pwdata;
		
		//updating IIR
		if(u_xtnh.Paddr == 32'h08 && u_xtnh.Pwrite == 1'b0)
			begin
				while(vif.mon_cb.IRQ !== 1)
				@(vif.mon_cb);
				u_xtnh.IRQ = vif.mon_cb.IRQ;
				u_xtnh.Prdata = vif.mon_cb.Prdata;
				u_xtnh.IIR = u_xtnh.Prdata;	
				@(vif.mon_cb);
		    end 

		//updating MCR
		if(u_xtnh.Paddr == 32'h10 && u_xtnh.Pwrite == 1'b1)
			u_xtnh.MCR = u_xtnh.Pwdata;
		
		//updating LSR
		if(u_xtnh.Paddr == 32'h14 && u_xtnh.Pwrite == 1'b0)
			u_xtnh.LSR = u_xtnh.Prdata;

		//updating DIV1 MSB
		if(u_xtnh.Paddr == 32'h20 && u_xtnh.Pwrite == 1'b1)
			u_xtnh.DIV1 = u_xtnh.Pwdata;
	
		//updating DIV2 LSB
		if(u_xtnh.Paddr == 32'h1c && u_xtnh.Pwrite == 1'b1)
			u_xtnh.DIV2 = u_xtnh.Pwdata;

		//updating THR
		if(u_xtnh.Paddr == 32'h0 && u_xtnh.Pwrite == 1'b1)
			begin
				u_xtnh.data_in_thr = 1'b1;
				u_xtnh.THR.push_back(u_xtnh.Pwdata);
			end

		//updating RBR
		if(u_xtnh.Paddr == 32'h0 && u_xtnh.Pwrite == 1'b0)
			begin
				u_xtnh.data_in_rbr = 1'b1;
				u_xtnh.RBR.push_back(u_xtnh.Prdata);
			end

		`uvm_info("MON",$sformatf("data from MON \n %s",u_xtnh.sprint()),UVM_MEDIUM)
		end
	endtask

endclass
