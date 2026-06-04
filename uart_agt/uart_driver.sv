//uart driver

class uart_driver extends uvm_driver#(uart_xtn);

	`uvm_component_utils(uart_driver)

	virtual uart_if.DRV_MP vif;
	uart_agt_cfg a_cfg;

	function new(string name ="uart_driver", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!(uvm_config_db #(uart_agt_cfg) :: get(this,"","uart_agt_cfg",a_cfg)))
			`uvm_fatal("UART_DRV","set_not_configured")
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif = a_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		@(vif.drv_cb);
		vif.drv_cb.Presetn <= 1'b0;
	        @(vif.drv_cb);
		vif.drv_cb.Presetn <= 1'b1;
		forever
		  begin
			seq_item_port.get_next_item(req);
			//req.print();
			send_to_dut(req);
			seq_item_port.item_done();
		  end
	endtask

	task send_to_dut(uart_xtn xtnh);
		@(vif.drv_cb);
		vif.drv_cb.Paddr <= xtnh.Paddr; 
		vif.drv_cb.Pwrite <= xtnh.Pwrite;
		vif.drv_cb.Pwdata <= xtnh.Pwdata;
		vif.drv_cb.Penable <= 1'b0;		
		vif.drv_cb.Psel <= 1'b1;
		@(vif.drv_cb);
		vif.drv_cb.Penable <= 1'b1;	
		
		while(vif.drv_cb.Pready !== 1)
		@(vif.drv_cb);
		if(xtnh.Paddr == 32'h08 && xtnh.Pwrite == 1'b0)
		begin
			while(vif.drv_cb.IRQ !== 1)
			@(vif.drv_cb);
			xtnh.IIR = vif.drv_cb.Prdata;
			seq_item_port.put_response(xtnh);
		end
		vif.drv_cb.Psel <= 1'b0;
	//	@(vif.drv_cb);			
		`uvm_info("DRV",$sformatf("data from DRV \n %s",xtnh.sprint()),UVM_MEDIUM)
	endtask
 
endclass
