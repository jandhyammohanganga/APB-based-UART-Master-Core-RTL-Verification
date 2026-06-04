// uart env cfg

class uart_env_cfg extends uvm_object;

	`uvm_object_utils(uart_env_cfg)

	uart_agt_cfg a_cfg[];

	bit has_agt;
	bit has_sb;

	int no_of_uart_agt;

	function new(string name = "uart_env_cfg");
		super.new(name);
	endfunction

endclass
