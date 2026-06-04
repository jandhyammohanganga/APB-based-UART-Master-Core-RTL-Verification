//sequence  for UART
class uart_seq extends uvm_sequence#(uart_xtn);

	`uvm_object_utils(uart_seq)

	function new(string name = "uart_seq");
		super.new(name);
	endfunction

endclass
//-------------------------------------------fd_seq1---------------------------------------------//
class fd_seq1 extends uart_seq;
	`uvm_object_utils(fd_seq1)

	function new(string name = "fd_seq1");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd27;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000101;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata inside {[1:255]};});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		end

	endtask	

endclass

//-------------------------------------------fd_seq2---------------------------------------------//
class fd_seq2 extends uart_seq;
	`uvm_object_utils(fd_seq2)

	function new(string name = "fd_seq2");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);


		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd54;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000101;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata inside {[1:255]};});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		end

	endtask	

endclass

//-------------------------------------------hd_seq1---------------------------------------------//
class hd_seq1 extends uart_seq;
	`uvm_object_utils(hd_seq1)

	function new(string name = "hd_seq1");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd27;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000101;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata inside {[1:255]};});
		finish_item(req);

	/*	//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		end*/

	endtask	
endclass

//-------------------------------------------hd_seq2---------------------------------------------//
class hd_seq2 extends uart_seq;
	`uvm_object_utils(hd_seq2)

	function new(string name = "hd_seq2");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd54;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000101;});
		finish_item(req);

	/*	//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata inside {[1:255]};});
		finish_item(req);*/

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		end

		if(req.IIR[3:0] == 6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		end

	endtask	
endclass

//-------------------------------------------loopback_seq1---------------------------------------------//
class loopback_seq1 extends uart_seq;
	`uvm_object_utils(loopback_seq1)

	function new(string name = "loopback_seq1");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd27;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000101;});
		finish_item(req);

		//MCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h10; Pwrite == 1'h1; Pwdata == 8'b00010000;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata inside {[1:255]};});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
	//		get_response(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
	//		get_response(req);
		end

	endtask	
endclass

//-------------------------------------------loopback_seq2---------------------------------------------//
class loopback_seq2 extends uart_seq;
	`uvm_object_utils(loopback_seq2)

	function new(string name = "loopback_seq2");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd54;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000101;});
		finish_item(req);

		//MCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h10; Pwrite == 1'h1; Pwdata == 8'b00010000;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata inside {[1:255]};});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
			//get_response(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
			//get_response(req);
		end

	endtask	
endclass

//-------------------------------------------parity_seq1---------------------------------------------//
class parity_seq1 extends uart_seq;
	`uvm_object_utils(parity_seq1)

	function new(string name = "parity_seq1");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd27;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00001011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000101;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata inside {[1:255]};});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

	endtask	
endclass

//-------------------------------------------parity_seq2---------------------------------------------//
class parity_seq2 extends uart_seq;
	`uvm_object_utils(parity_seq2)

	function new(string name = "parity_seq2");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd54;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00011011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000101;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata inside {[1:255]};});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

	endtask	
endclass

//-------------------------------------------Break_error_seq1---------------------------------------------//
class break_error_seq1 extends uart_seq;
	`uvm_object_utils(break_error_seq1)

	function new(string name = "break_error_seq1");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd27;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b01000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 32'h6;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000101;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata inside {[1:255]};});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

	endtask	
endclass

//-------------------------------------------Break_error_seq2---------------------------------------------//
class break_error_seq2 extends uart_seq;
	`uvm_object_utils(break_error_seq2)

	function new(string name = "break_error_seq2");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd54;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b01000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 32'h6;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000101;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata inside {[1:255]};});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

	endtask	
endclass

//-------------------------------------------overrun_seq1---------------------------------------------//
class overrun_seq1 extends uart_seq;
	`uvm_object_utils(overrun_seq1)

	function new(string name = "overrun_seq1");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd27;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b11000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000100;});
		finish_item(req);

		//THR
		repeat(17)
		begin
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1;});
		finish_item(req);
		end

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

	endtask	
endclass

//-------------------------------------------overrun_seq2---------------------------------------------//
class overrun_seq2 extends uart_seq;
	`uvm_object_utils(overrun_seq2)

	function new(string name = "overrun_seq2");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd54;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b11000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000100;});
		finish_item(req);

		//THR
		repeat(17)
		begin
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1;});
		finish_item(req);
		end

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

	endtask	
endclass

//-------------------------------------------framing_error_seq1---------------------------------------------//
class fe_seq1 extends uart_seq;
	`uvm_object_utils(fe_seq1)

	function new(string name = "fe_seq1");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 27;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000101;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata == 5;});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

		if(req.IIR[3:0] == 6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

	endtask	
endclass

//-------------------------------------------framing_error_seq2---------------------------------------------//
class fe_seq2 extends uart_seq;
	`uvm_object_utils(fe_seq2)

	function new(string name = "fe_seq2");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 54;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00000000;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000101;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata == 10;});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

		if(req.IIR[3:0] == 6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

	endtask	
endclass

//-------------------------------------------thr_empty_seq1---------------------------------------------//
class thr_seq1 extends uart_seq;
	`uvm_object_utils(thr_seq1)

	function new(string name = "thr_seq1");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd27;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b11000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000010;});
		finish_item(req);

	/*	//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata == 5;});
		finish_item(req);*/

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

	endtask	
endclass

//-------------------------------------------thr_empty_seq2---------------------------------------------//
class thr_seq2 extends uart_seq;
	`uvm_object_utils(thr_seq2)

	function new(string name = "thr_seq2");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd54;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00000011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b11000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000010;});
		finish_item(req);

	/*	//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1; Pwdata == 5;});
		finish_item(req);*/

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

	endtask	
endclass

//-------------------------------------------time_out_error_seq1---------------------------------------------//
class time_out_seq1 extends uart_seq;
	`uvm_object_utils(time_out_seq1)

	function new(string name = "time_out_seq1");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd27;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00001011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b10000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000000;});
		finish_item(req);

		//THR
		repeat(17)
		begin
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1;});
		finish_item(req);
		end

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

	endtask	
endclass

//-------------------------------------------time_out_error_seq2---------------------------------------------//
class time_out_seq2 extends uart_seq;
	`uvm_object_utils(time_out_seq2)

	function new(string name = "time_out_seq2");
		super.new(name);
	endfunction

	task body();
		req = uart_xtn :: type_id :: create("req");

		//DIV1(MSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1'h1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV1(LSB)
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1'h1; Pwdata == 32'd54;});
		finish_item(req);

		//Normal mode LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1'h1; Pwdata == 8'b00001011;});
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h1; Pwdata == 8'b11000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1'h1; Pwdata == 8'b00000000;});
		finish_item(req);

		//THR
		repeat(17)
		begin
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h1;});
		finish_item(req);
		end

		//IIR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1'h0;});
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0] == 4'h4)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h00; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

		if(req.IIR[3:0] == 4'h6)
		begin
			start_item(req);
			assert(req.randomize with {Paddr == 32'h14; Pwrite == 1'h0;});
			finish_item(req);
		//	get_response(req);
		end

	endtask	
endclass
		
