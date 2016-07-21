#include <linux/printk.h>

#include "pcb.h"

extern myPCB task[MAX_TASK_NUM], *my_current_task;
extern volatile int my_need_sched;
volatile int time_count = 0;

/*
 * Called by timer interrupt.
 * it runs in the name of current running process,
 * so it use kernel stack of current running process
 */
void my_timer_handler(void)
{
	if (time_count % 1000 == 0 && my_need_sched != 1)
		my_need_sched = 1;
	time_count++;
}
