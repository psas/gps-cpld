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
    work_m_16189553552419484637_3390259167_init();
    work_m_10149053969866533868_3562040449_init();
    work_m_09127006452055800929_1170103221_init();
    work_m_10466742041877081243_1742810883_init();
    work_m_12109198101923164886_2925926812_init();
    work_m_01574474005988110559_0249777441_init();
    work_m_13461737499422621189_0367899785_init();
    work_m_16541823861846354283_2073120511_init();


    xsi_register_tops("work_m_13461737499422621189_0367899785");
    xsi_register_tops("work_m_16541823861846354283_2073120511");


    return xsi_run_simulation(argc, argv);

}
