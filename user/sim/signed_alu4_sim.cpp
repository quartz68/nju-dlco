#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vsigned_alu4.h"

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

static Vsigned_alu4* top;

void step_and_dump_wave(){
  top->eval();
  contextp->timeInc(1);
  tfp->dump(contextp->time());
}
void sim_init(){
  contextp = new VerilatedContext;
  tfp = new VerilatedVcdC;
  top = new Vsigned_alu4;
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

  int total_cnt, error_cnt = 0;
  // Adder
  top->ALUControl = 0x0;
  for (int A = 0x0; A <= 0xF; A++) {
    for (int B = 0x0; B <= 0xF; B++) {
      ++total_cnt;
      top->A = A;
      top->B = B;
      step_and_dump_wave();
      if ((top->Result != (A+B) && top->C == 0) || (top->Result != (A+B-16) && top->C == 1)) {
        printf("Error in adding: (A: %d , B: %d, Result: %d, Expected: %d), (C: %d)\n", A, B, top->Result, A+B, top->C);
        ++error_cnt;
      }
    }
  }
  // Subtractor
  top->ALUControl = 0x1;
  for (int A = 0x0; A <= 0xF; A++) {
    for (int B = 0x0; B <= 0xF; B++) {
      ++total_cnt;
      top->A = A;
      top->B = B;
      step_and_dump_wave();
      if ((top->Result != (A-B) && top->C == 0) || (top->Result != (A-B+16) && top->C == 1)) {
        printf("Error in subtracting: (A: %d , B: %d, Result: %d, Expected: %d), (C: %d)\n", A, B, top->Result, A-B, top->C);
        ++error_cnt;
      }
    }
  }
  // Inverter
  top->ALUControl = 0x2;
  for (int A = 0x0; A <= 0xF; A++) {
    for (int B = 0x0; B <= 0xF; B++) {
      ++total_cnt;
      top->A = A;
      top->B = B;
      step_and_dump_wave();
      if (top->Result != (15-A)) {
        printf("Error in inverting: (A: %d , B: %d, Result: %d, Expected: %d)\n", A, B, top->Result, 15-A);
        ++error_cnt;
      }
    }
  }
  
  printf("Total: %d , Error: %d\n", total_cnt, error_cnt);

  sim_exit();
}