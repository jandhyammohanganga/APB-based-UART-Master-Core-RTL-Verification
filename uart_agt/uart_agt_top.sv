// UART agent top

class uart_agt_top extends uvm_env;
	`uvm_component_utils(uart_agt_top)

	uart_agt u_agt[];
	uart_env_cfg m_cfg;
	uart_agt_cfg a_cfg[];



	function new(string name="uart_agt_top", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	//	$display(get_full_name);
		
		if(!(uvm_config_db #(uart_env_cfg) :: get(this,"","e_cfg",m_cfg)))
			`uvm_fatal("AGT_TOP","set no configured")

		u_agt = new[m_cfg.no_of_uart_agt];
		foreach(u_agt[i])
		begin
			uvm_config_db #(uart_agt_cfg) :: set(this,$sformatf("u_agt[%0d]*",i),"uart_agt_cfg",m_cfg.a_cfg[i]);
			u_agt[i] = uart_agt :: type_id :: create($sformatf("u_agt[%0d]",i),this);
		end
	endfunction

endclass


