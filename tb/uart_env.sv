//uart env

class uart_env extends uvm_env;

	`uvm_component_utils(uart_env);

	uart_agt_top agt_h;
	uart_sb u_sb;
	uart_env_cfg m_cfg;

	function new (string name = "uart_env", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!(uvm_config_db #(uart_env_cfg) :: get(this,"","e_cfg",m_cfg)))
			`uvm_fatal("ENV","set not configured")

		if(m_cfg.has_agt)
			agt_h = uart_agt_top :: type_id :: create("agt_h",this);

		if(m_cfg.has_sb)
			u_sb = uart_sb :: type_id :: create("u_sb",this);

	//	uvm_config_db #(uart_agt_cfg) :: set(this,"*","a_cfg",e_cfg.a_cfg);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		foreach(agt_h.u_agt[i])
			agt_h.u_agt[i].u_mon.mon_port.connect(u_sb.tlm_fifo[i].analysis_export);
	endfunction

endclass
