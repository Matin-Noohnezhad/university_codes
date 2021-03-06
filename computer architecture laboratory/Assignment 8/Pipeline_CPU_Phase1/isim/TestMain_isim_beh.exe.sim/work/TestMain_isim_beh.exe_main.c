/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000002470639908_1733832700_init();
    work_m_00000000002018216396_0944788044_init();
    work_m_00000000004224710285_2138213552_init();
    work_m_00000000002032216797_1298333783_init();
    work_m_00000000002901948488_0085000054_init();
    work_m_00000000003443749042_3275311449_init();
    work_m_00000000001071165622_0967961054_init();
    work_m_00000000001709040297_2058220583_init();
    work_m_00000000001755306732_4132685690_init();
    work_m_00000000002901948488_2709143646_init();
    work_m_00000000001443921208_4231019343_init();
    work_m_00000000000402711628_1894514138_init();
    work_m_00000000004114290240_0886308060_init();
    work_m_00000000002672208579_2875975674_init();
    work_m_00000000003557310128_2461264495_init();
    work_m_00000000002618682163_3508751931_init();
    work_m_00000000003660376348_2866095323_init();
    work_m_00000000003963556487_4091235675_init();
    work_m_00000000003190535095_2973510161_init();
    work_m_00000000000846085540_1690108397_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000000846085540_1690108397");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
