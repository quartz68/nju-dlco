#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vlfsr8.h"

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

static Vlfsr8* top;

void step_and_dump_wave(){
  top->eval();
  contextp->timeInc(1);
  tfp->dump(contextp->time());
}
void sim_init(){
  contextp = new VerilatedContext;
  tfp = new VerilatedVcdC;
  top = new Vlfsr8;
  contextp->traceEverOn(true);
  top->trace(tfp, 0);
  tfp->open("../data/dump.vcd");
}

void sim_exit(){
  step_and_dump_wave();
  tfp->close();
}

int main() {
  sim_init();

  top->clk = 0x0;
  step_and_dump_wave();

  top->reset = 0x1;
  top->clk = 0x1;
  step_and_dump_wave();
  top->clk = 0x0;
  step_and_dump_wave();

  top->reset = 0x0; top->clear = 0x1;
  top->clk = 0x1;
  step_and_dump_wave();
  top->clk = 0x0;
  step_and_dump_wave();

  top->reset = 0x1; top->clear = 0x0;
  top->clk = 0x1;
  step_and_dump_wave();
  top->clk = 0x0;
  step_and_dump_wave();

  top->reset = 0x0;
  top->clk = 0x1;
  step_and_dump_wave();
  top->clk = 0x0;
  step_and_dump_wave();

  for (int i = 0x0; i <= 0xFF; i++) {
    top->clk = 0x1;
    step_and_dump_wave();
    top->clk = 0x0;
    step_and_dump_wave();
  }

  sim_exit();
}