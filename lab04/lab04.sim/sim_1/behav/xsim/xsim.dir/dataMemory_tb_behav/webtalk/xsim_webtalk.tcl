webtalk_init -webtalk_dir E:/archlabs/lab04/lab04.sim/sim_1/behav/xsim/xsim.dir/dataMemory_tb_behav/webtalk/
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Wed May 19 11:41:32 2021" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "XSIM v2018.3 (64-bit)" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "2405991" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "WIN64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "xsim_vivado" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "20b77d16-ec2a-4dfe-8b6e-8d7d3922cb6e" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "801344254ac5425e844cd8b42634fc13" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "5" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "Microsoft Windows 8 or later , 64-bit" -context "user_environment"
webtalk_add_data -client project -key os_release -value "major release  (build 9200)" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "Intel(R) Xeon(R) W-2123 CPU @ 3.60GHz" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "3600 MHz" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "1" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "16.000 GB" -context "user_environment"
webtalk_register_client -client xsim
webtalk_add_data -client xsim -key Command -value "xsim" -context "xsim\\command_line_options"
webtalk_add_data -client xsim -key trace_waveform -value "true" -context "xsim\\usage"
webtalk_add_data -client xsim -key runtime -value "1 us" -context "xsim\\usage"
webtalk_add_data -client xsim -key iteration -value "1" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Time -value "0.01_sec" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Memory -value "5888_KB" -context "xsim\\usage"
webtalk_transmit -clientid 1269066078 -regid "" -xml E:/archlabs/lab04/lab04.sim/sim_1/behav/xsim/xsim.dir/dataMemory_tb_behav/webtalk/usage_statistics_ext_xsim.xml -html E:/archlabs/lab04/lab04.sim/sim_1/behav/xsim/xsim.dir/dataMemory_tb_behav/webtalk/usage_statistics_ext_xsim.html -wdm E:/archlabs/lab04/lab04.sim/sim_1/behav/xsim/xsim.dir/dataMemory_tb_behav/webtalk/usage_statistics_ext_xsim.wdm -intro "<H3>XSIM Usage Report</H3><BR>"
webtalk_terminate
