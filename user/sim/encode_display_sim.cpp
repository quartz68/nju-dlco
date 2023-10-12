#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vencode_display.h"

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

static Vencode_display* top;

void step_and_dump_wave(){
  top->eval();
  contextp->timeInc(1);
  tfp->dump(contextp->time());
}
void sim_init(){
  contextp = new VerilatedContext;
  tfp = new VerilatedVcdC;
  top = new Vencode_display;
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

  top->en=0; for (int x = 0x00; x <= 0xFF; x++) {
    top->x = x;
    step_and_dump_wave();
  }
  top->en=1; for (int x = 0x00; x <= 0xFF; x++) {
    top->x = x;
    step_and_dump_wave();
  }

  sim_exit();
}