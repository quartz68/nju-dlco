#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vbcd7seg.h"

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

static Vbcd7seg* top;

void step_and_dump_wave(){
  top->eval();
  contextp->timeInc(1);
  tfp->dump(contextp->time());
}
void sim_init(){
  contextp = new VerilatedContext;
  tfp = new VerilatedVcdC;
  top = new Vbcd7seg;
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

  top->en=0; for (int b = 0x00; b <= 0x07; b++) {
    top->b = b;
    step_and_dump_wave();
  }
  top->en=1; for (int b = 0x00; b <= 0x07; b++) {
    top->b = b;
    step_and_dump_wave();
  }

  sim_exit();
}