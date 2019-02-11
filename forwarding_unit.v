//           ^       /\             /\   ~!~
//              ^   (())           (())
//       ^         /(())\         /(())\      ~!~
//                (((())))       (((())))
//                |^|^^|^|_______|^|^^|^|
//            /\   |^^^^|-_-_-_-_-|^^^^|   /\
//           (())  | "" |+_+_+_+_+| "" |  (())
//          ((())) |    |[X]_+_[X]|    | ((()))
//         (((())))|    |+_+_+_+_+|    |(((())))
//         |^|^^|^||____|-_-_-_-_-|____||^|^^|^|
//         |^^^^|_-_-_-_-_-_-_-_-_-_-_-_|^^^^|
//      ~^~~| "" |_-_-_-_-_-_-_-_-_-_-_-_| "" |~~
//      ~~  |    |_+_+_+_+_+_+_+_+_+_+_+_|    | ~^~
//       ~^^|    |_+[X]+_[X]_+_[X]_+[X]+_|    |~~^
//          |    |_+_+_+_+_+/l\+_+_+_+_+_|    |
//          |    |_-_-_-_-_|:::|_-_-_-_-_|    |
//          |____|_+_+_+_+_|:::|_+_+_+_+_|____|
//      @@@@@@@@@@@@@@@@@@@@"""@@@@@@@@@@@@@@@@@@@@


`include "defines.v"

module forwarding_unit (op_code, rs, rt,
						reg_write_MEM, dest_MEM,
						reg_write_WB, dest_WB,
						fwd_A, fwd_B, sel_store_val);

	input [5:0] op_code;
	input [4:0] rs, rt;
	input [4:0] dest_MEM, dest_WB;
	input reg_write_MEM, reg_write_WB;
	output [1:0] fwd_A, fwd_B, sel_store_val;

	assign fwd_A =
			(reg_write_MEM && dest_MEM && dest_MEM == rs) ? 1 :
            (reg_write_WB && dest_WB && dest_WB == rs) ? 2 : 0;
			// 2=WB_output,1=alu_res_MEM,0=alu_arg1
			
	assign fwd_B = 
			(op_code == `OP_ADD || op_code == `OP_SUB) ? // (case IMM)
			(reg_write_MEM == 1 && dest_MEM != 0 && dest_MEM == rt) ? 1 :
            (reg_write_WB == 1 && dest_WB != 0 && dest_WB == rt) ? 2 : 0 : 0 ;
			// 2=WB_output,1=alu_res_MEM,0=alu_arg2
			
	assign sel_store_val = 
			(op_code != `OP_SW) ? 0 :
			(reg_write_MEM && dest_MEM && dest_MEM == rt) ? 1 : 
			(reg_write_WB && dest_WB && dest_WB == rt) ? 2 : 0;
			// 2=WB_output,1=alu_res_MEM,0=store_val_in

endmodule // forwarding_unit

