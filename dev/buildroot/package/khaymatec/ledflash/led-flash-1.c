#include <linux/module.h>
#include <linux/timer.h>
#include <linux/gpio.h>
#include <linux/fs.h>

/* Beaglebone P8.7 */
#define BBB_GPIO_OUT 66

static struct timer_list bbb_gpio_timer;

static void bbb_gpio_handler(unsigned long data)
{
	static int value = 1;

	value = 1 - value;

	gpio_set_value(BBB_GPIO_OUT, value);

	mode_timer(&bbb_gpio_timer, jiffies + (HZ >> 3));
}

static int __int bbb_gpio_init (void)
{
	int err;

	if ((err = gpio_request(BBB_GPIO_OUT, THIS_MODULE->name)) != 0)
		return err;

	if ((err = gpio_direction_output(BBB_GPIO_OUT,1)) != 0)
		gpio_free(BBB_GPIO_OUT);

	init_timer(&bbb_gpio_timer);
	bbb_gpio_timer.function = bbb_gpio_handler;
	bbb_gpio_timer.data = 0;
	bbb_gpio_timer.expires = jiffies + (HZ >> 3);
	add_timer(&bbb_gpio_timer);

	return 0;
}

static void __exit bbb_gpio_exit (void)
{
	del_timer(&bbb_gpio_timer);
	gpio_free(BBB_GPIO_OUT);
}

module_init(bbb_gpio_init);
module_exit(bbb_gpio_exit);
