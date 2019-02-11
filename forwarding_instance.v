//                                   _   _
//         _______________          |*\_/*|________
//        |  ___________  |        ||_/-\_|______  |
//        | |           | |        | |           | |
//        | |   0   0   | |        | |   0   0   | |
//        | |     -     | |        | |     -     | |
//        | |   \___/   | |        | |   \___/   | |
//        | |___     ___| |        | |___________| |
//        |_____|\_/|_____|        |_______________|
//          _|__|/ \|_|_.............._|________|_
//         / ********** \            / ********** \
//       /  ************  \        /  ************  \
//      --------------------      --------------------

	
	// TODO: Implement the forwarding_unit module
	// Write your code (forwarding_unit instantiation, not the module) here
	// assign {sel_alu1, sel_alu2, sel_store_val} = 0;
	
	forwarding_unit forwarding_unit (
		// INPUTS 
		.op_code(op_code_EXE),		// OP-CODE
		.rs(rs_EXE), 					// ID/EX.RegisterRs
		.rt(rt_EXE), 					// ID/EX.RegisterRt
		// INPUTS FOR EX HAZARD
		.reg_write_MEM(reg_write_MEM), 	// EX/MEM.RegWrite
		.dest_MEM(dest_MEM), 			// EX/MEM.RegisterRd
		// INPUTS FOR MEM HAZARD
		.reg_write_WB(reg_write_WB), 	// MEM/WB.RegWrite
		.dest_WB(dest_WB), 				// MEM/WB.RegisterRd
		// INPUTS FOR STORE VAL
		//.reg_write_ID(reg_write_ID),
		
		// OUTPUTS
		.fwd_A(sel_alu1), 				// Forward A
		.fwd_B(sel_alu2), 				// Forward B
		.sel_store_val(sel_store_val)	// The register that needs to be written to at the end
	);

	// end TODO
