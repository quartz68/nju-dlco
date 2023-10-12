#include "verilated.h"
#include "verilated_vcd_c.h"
#include "nvboard.h"
#include "Vencode_display.h"
#include <iostream>
#include <memory>
#include <stdlib.h>
#include <assert.h>

vluint64_t sim_time = 10;

void nvboard_bind_all_pins(Vencode_display* top);

int main(int argc, char** argv) {
	const std::unique_ptr<VerilatedContext> contextp { new VerilatedContext };
	contextp->commandArgs(argc, argv);

	// Verilated::traceEverOn(true);
	// const std::unique_ptr<VerilatedVcdC> tfp { new VerilatedVcdC };

	const std::unique_ptr<Vencode_display> top { new Vencode_display{contextp.get()} };
	
	// top->trace(tfp.get(), 99);
	// tfp->open("obj_dir/trace.vcd");

	// NVBoard
	nvboard_bind_all_pins(top.get());
	nvboard_init();
	
	// while (contextp->time() < sim_time && !contextp->gotFinish()) {
	while (1 && !contextp->gotFinish()) {
		contextp->timeInc(1);
		top->eval();
		// printf("code = %x\n", top->out);
		// tfp->dump(contextp->time());
		nvboard_update();
	}

	// tfp->close();
	nvboard_quit();

	return 0;
}