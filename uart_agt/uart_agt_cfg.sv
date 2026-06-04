//uart agt cfg

class uart_agt_cfg extends uvm_object;

	`uvm_object_utils(uart_agt_cfg)

	virtual uart_if vif;
//	virtual uart_if vif1;

	uvm_active_passive_enum is_active = UVM_ACTIVE;

	function new(string name ="uart_agt_cfg");
		super.new(name);
	endfunction
	
endclass

