//uart agt
class uart_agt extends uvm_agent;

	`uvm_component_utils(uart_agt)

	uart_monitor u_mon;
	uart_sequencer u_seqr;
	uart_driver u_drv;

	uart_agt_cfg a_cfgh;

	function new (string name = "uart_agt",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		//$display(get_full_name);

		if(!(uvm_config_db #(uart_agt_cfg) :: get(this,"","uart_agt_cfg",a_cfgh)))
			`uvm_fatal("UART_AGT","set_not_configured")

		u_mon = uart_monitor :: type_id :: create("u_mon",this);
	  	if(a_cfgh.is_active)
			begin
				u_drv = uart_driver :: type_id :: create("u_drv",this);
				u_seqr = uart_sequencer :: type_id :: create("u_seqr",this);
			end
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		u_drv.seq_item_port.connect(u_seqr.seq_item_export);
	endfunction

endclass	
