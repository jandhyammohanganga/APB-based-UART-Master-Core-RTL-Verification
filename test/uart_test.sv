//uart test

class uart_test extends uvm_test;

	`uvm_component_utils(uart_test);

	uart_env u_env;
	uart_env_cfg e_cfg;

	uart_agt_cfg a_cfg[];

	bit has_agt = 1;
	bit has_sb = 1;

	int no_of_uart_agt = 2;
	

	function new (string name = "uart_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		e_cfg = uart_env_cfg :: type_id :: create("e_cfg");

		if(has_agt)
			begin
				a_cfg = new[no_of_uart_agt];
				e_cfg.a_cfg = new[no_of_uart_agt];
				foreach(a_cfg[i])
				  begin				
					a_cfg[i] = uart_agt_cfg :: type_id :: create($sformatf("a_cfg[%0d]",i));
				
					if(!(uvm_config_db #(virtual uart_if) :: get(this,"",$sformatf("u_if%0d",i),a_cfg[i].vif)))
						`uvm_fatal("TEST","set not configured")

				//	if(!(uvm_config_db #(virtual uart_if) :: get(this,"","u_if1",a_cfg.vif1)))
					//	`uvm_fatal("TEST","set not configured")

					e_cfg.a_cfg[i] = a_cfg[i];
				  end
				e_cfg.has_agt = has_agt;
				e_cfg.no_of_uart_agt = no_of_uart_agt;
			end

		e_cfg.has_sb = has_sb;
		uvm_config_db #(uart_env_cfg) :: set(this,"*","e_cfg",e_cfg);
		u_env = uart_env :: type_id :: create("u_env",this);

	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction

endclass

//--------------------------------test for fd_seq-----------------------------------//

class fd_seq1_test extends uart_test;

	`uvm_component_utils(fd_seq1_test)

	fd_seq1 seq1_h;
	fd_seq2 seq2_h;

	function new(string name = "fd_seq1_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		seq1_h = fd_seq1 :: type_id :: create("seq1_h");
		seq2_h = fd_seq2 :: type_id :: create("seq2_h");
		phase.raise_objection(this);
		fork
			seq1_h.start(u_env.agt_h.u_agt[0].u_seqr);
			seq2_h.start(u_env.agt_h.u_agt[1].u_seqr);
		join
		#50;
		phase.drop_objection(this);
	endtask

endclass

//--------------------------------test for hd_seq-----------------------------------//

class hd_seq1_test extends uart_test;

	`uvm_component_utils(hd_seq1_test)

	hd_seq1 seq1_hd;
	hd_seq2 seq2_hd;

	function new(string name = "hd_seq1_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		seq1_hd = hd_seq1 :: type_id :: create("seq1_hd");
		seq2_hd = hd_seq2 :: type_id :: create("seq2_hd");
		phase.raise_objection(this);
		fork
			seq1_hd.start(u_env.agt_h.u_agt[0].u_seqr);
			seq2_hd.start(u_env.agt_h.u_agt[1].u_seqr);
		join
		#50;
		phase.drop_objection(this);
	endtask

endclass

//--------------------------------test for loopback_seq-----------------------------------//

class loopback_seq_test extends uart_test;

	`uvm_component_utils(loopback_seq_test)

	loopback_seq1 lb_seq1_h;
	loopback_seq2 lb_seq2_h;

	function new(string name = "loopback_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		lb_seq1_h = loopback_seq1 :: type_id :: create("lb_seq1_h");
		lb_seq2_h = loopback_seq2 :: type_id :: create("lb_seq2_h");
		phase.raise_objection(this);
		fork
			lb_seq1_h.start(u_env.agt_h.u_agt[0].u_seqr);
			lb_seq2_h.start(u_env.agt_h.u_agt[1].u_seqr);
		join
		#50;
		phase.drop_objection(this);
	endtask

endclass

//--------------------------------test for parity_seq-----------------------------------//

class parity_seq_test extends uart_test;

	`uvm_component_utils(parity_seq_test)

	parity_seq1 p_seq1_h;
	parity_seq2 p_seq2_h;

	function new(string name = "parity_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		p_seq1_h = parity_seq1 :: type_id :: create("p_seq1_h");
		p_seq2_h = parity_seq2 :: type_id :: create("p_seq2_h");
		phase.raise_objection(this);
		fork
			p_seq1_h.start(u_env.agt_h.u_agt[0].u_seqr);
			p_seq2_h.start(u_env.agt_h.u_agt[1].u_seqr);
		join
		#50;
		phase.drop_objection(this);
	endtask

endclass

//--------------------------------test for Break_error_seq-----------------------------------//

class break_error_seq_test extends uart_test;

	`uvm_component_utils(break_error_seq_test)

	break_error_seq1 be_seq1_h;
	break_error_seq2 be_seq2_h;

	function new(string name = "break_error_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		be_seq1_h = break_error_seq1 :: type_id :: create("be_seq1_h");
		be_seq2_h = break_error_seq2 :: type_id :: create("be_seq2_h");
		phase.raise_objection(this);
		fork
			be_seq1_h.start(u_env.agt_h.u_agt[0].u_seqr);
			be_seq2_h.start(u_env.agt_h.u_agt[1].u_seqr);
		join
		#50;
		phase.drop_objection(this);
	endtask

endclass

//--------------------------------test for overrun_seq-----------------------------------//

class overrun_seq_test extends uart_test;

	`uvm_component_utils(overrun_seq_test)

	overrun_seq1 ov_seq1_h;
	overrun_seq2 ov_seq2_h;

	function new(string name = "overrun_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		ov_seq1_h = overrun_seq1 :: type_id :: create("ov_seq1_h");
		ov_seq2_h = overrun_seq2 :: type_id :: create("ov_seq2_h");
		phase.raise_objection(this);
		fork
			ov_seq1_h.start(u_env.agt_h.u_agt[0].u_seqr);
			ov_seq2_h.start(u_env.agt_h.u_agt[1].u_seqr);
		join
		#50;
		phase.drop_objection(this);
	endtask

endclass

//--------------------------------test for framing_error_seq-----------------------------------//

class fe_seq_test extends uart_test;

	`uvm_component_utils(fe_seq_test)

	fe_seq1 fe_seq1_h;
	fe_seq2 fe_seq2_h;

	function new(string name = "fe_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		fe_seq1_h = fe_seq1 :: type_id :: create("fe_seq1_h");
		fe_seq2_h = fe_seq2 :: type_id :: create("fe_seq2_h");
		phase.raise_objection(this);
		fork
			fe_seq1_h.start(u_env.agt_h.u_agt[0].u_seqr);
			fe_seq2_h.start(u_env.agt_h.u_agt[1].u_seqr);
		join
		#50;
		phase.drop_objection(this);
	endtask

endclass

//--------------------------------test for thr_empty_seq-----------------------------------//

class thr_seq_test extends uart_test;

	`uvm_component_utils(thr_seq_test)

	thr_seq1 thr_seq1_h;
	thr_seq2 thr_seq2_h;

	function new(string name = "thr_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		thr_seq1_h = thr_seq1 :: type_id :: create("thr_seq1_h");
		thr_seq2_h = thr_seq2 :: type_id :: create("thr_seq2_h");
		phase.raise_objection(this);
		fork
			thr_seq1_h.start(u_env.agt_h.u_agt[0].u_seqr);
			thr_seq2_h.start(u_env.agt_h.u_agt[1].u_seqr);
		join
		#50;
		phase.drop_objection(this);
	endtask

endclass

//--------------------------------test for time_out_error_seq-----------------------------------//

class time_out_test extends uart_test;

	`uvm_component_utils(time_out_test)

	time_out_seq1 to_seq1_h;
	time_out_seq2 to_seq2_h;

	function new(string name = "time_out_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		to_seq1_h = time_out_seq1 :: type_id :: create("to_seq1_h");
		to_seq2_h = time_out_seq2 :: type_id :: create("to_seq2_h");
		phase.raise_objection(this);
		fork
			to_seq1_h.start(u_env.agt_h.u_agt[0].u_seqr);
			to_seq2_h.start(u_env.agt_h.u_agt[1].u_seqr);
		join
		#50;
		phase.drop_objection(this);
	endtask

endclass

