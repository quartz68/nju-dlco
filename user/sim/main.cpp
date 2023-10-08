#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vmux42.h"

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

static Vmux42* top;

void step_and_dump_wave(){
  top->eval();
  contextp->timeInc(1);
  tfp->dump(contextp->time());
}
void sim_init(){
  contextp = new VerilatedContext;
  tfp = new VerilatedVcdC;
  top = new Vmux42;
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

  top->y=0x00; top->x=0x00;  step_and_dump_wave();
            top->x=0x01;  step_and_dump_wave();
            top->x=0x02;  step_and_dump_wave();
            top->x=0x03;  step_and_dump_wave();
			top->x=0x04;  step_and_dump_wave();
			top->x=0x08;  step_and_dump_wave();
			top->x=0x0C;  step_and_dump_wave();
  top->y=0x01; top->x=0x00;  step_and_dump_wave();
            top->x=0x01;  step_and_dump_wave();
            top->x=0x02;  step_and_dump_wave();
            top->x=0x03;  step_and_dump_wave();
			top->x=0x04;  step_and_dump_wave();
			top->x=0x08;  step_and_dump_wave();
			top->x=0x0C;  step_and_dump_wave();

  sim_exit();
}