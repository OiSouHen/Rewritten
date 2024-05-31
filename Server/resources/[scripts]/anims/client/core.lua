-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local Anims = {
	["garcom"] = { dict = "anim@move_f@waitress", anim = "idle", prop = "vw_prop_vw_tray_01a", flag = 49, mao = 28422, pos1 = 0.0, pos2 = 0.0, pos3 = 0.015, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0 },
	["garcom2"] = { dict = "anim@move_f@waitress", anim = "idle", prop = "prop_food_tray_01", flag = 49, mao = 28422, pos1 = 0.0, pos2 = 0.0, pos3 = 0.01, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0 },
	["garcom3"] = { dict = "anim@move_f@waitress", anim = "idle", prop = "prop_food_tray_02", flag = 49, mao = 28422, pos1 = 0.0, pos2 = 0.0, pos3 = 0.01, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0 },
	["garcom4"] = { dict = "anim@move_f@waitress", anim = "idle", prop = "prop_food_tray_03", flag = 49, mao = 28422, pos1 = 0.0, pos2 = 0.0, pos3 = 0.01, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0 },
	["garcom5"] = { dict = "anim@move_f@waitress", anim = "idle", prop = "h4_prop_h4_champ_tray_01b", flag = 49, mao = 28422, pos1 = 0.0, pos2 = 0.0, pos3 = 0.01, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0 },
	["garcom6"] = { dict = "anim@move_f@waitress", anim = "idle", prop = "h4_prop_h4_champ_tray_01c", flag = 49, mao = 28422, pos1 = 0.0, pos2 = 0.0, pos3 = 0.01, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0 },
	["esquentar"] = { dict = "amb@world_human_stand_fire@male@base", anim = "base", walk = false, loop = true },
	["churrasco2"] = { dict = "amb@prop_human_bbq@male@idle_a", anim = "idle_c", walk = false, loop = true },
	["spray"] = { dict = "switch@franklin@lamar_tagging_wall", anim = "lamar_tagging_exit_loop_lamar", prop =
	"prop_cs_spray_can", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.0, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["spray2"] = { dict = "switch@franklin@lamar_tagging_wall", anim = "lamar_tagging_wall_loop_lamar", prop =
	"prop_cs_spray_can", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.0, pos3 = 0.0, pos4 = 0.0, pos5 = 130.0 },
	["tablet2"] = { dict = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", anim = "idle_a", prop =
	"prop_cs_tablet", flag = 49, mao = 28422, altura = -0.05, pos1 = 0.0, pos2 = 0.0, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["agitar"] = { dict = "random@street_race", anim = "_streetracer_accepted", walk = false, loop = false },
	["agitar2"] = { dict = "random@street_race", anim = "grid_girl_a", walk = false, loop = false },
	["agitar3"] = { dict = "random@street_race", anim = "grid_girl_b", walk = false, loop = false },
	["parado12"] = { dict = "amb@world_human_drug_dealer_hard@male@idle_b", anim = "idle_d", walk = false, loop = true },
	["caixa"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "hei_prop_heist_box", flag = 50, mao = 60309, altura = 0.025, pos1 = 0.08, pos2 = 0.255, pos3 = -50.0, pos4 = 290.0, pos5 = 0.0 },
	["mapa"] = { dict = "amb@world_human_tourist_map@male@base", anim = "base", prop = "prop_tourist_map_01", flag = 49, mao = 28422 },
	["prancheta"] = { dict = "missfam4", anim = "base", prop = "p_amb_clipboard_01", flag = 49, mao = 36029, altura = 0.16, pos1 = 0.08, pos2 = 0.1, pos3 = -130.0, pos4 = -50.0, pos5 = 0.0 },
	["cigar"] = { prop = "prop_cigar_02", flag = 49, mao = 47419, altura = 0.01, pos1 = 0.01, pos2 = 0.005, pos3 = 50.0, pos4 = 0.0, pos5 = -80.0 },
	["buque"] = { dict = "impexp_int-0", anim = "mp_m_waremech_01_dual-0", prop = "prop_snow_flower_02", flag = 49, mao = 24817, altura = -0.29, pos1 = 0.40, pos2 = -0.02, pos3 = -90.0, pos4 = -90.0, pos5 = 0.0 },
	["jornal"] = { dict = "missfam4", anim = "base", prop = "prop_cliff_paper", flag = 49, mao = 36029, altura = 0.13, pos1 = 0.05, pos2 = 0.20, pos3 = -20.0, pos4 = -70.0, pos5 = 0.0 },
	["wtf"] = { dict = "anim@mp_player_intcelebrationfemale@face_palm", anim = "face_palm", walk = true, loop = false },
	["wtf2"] = { dict = "random@car_thief@agitated@idle_a", anim = "agitated_idle_a", walk = true, loop = false },
	["wtf3"] = { dict = "missminuteman_1ig_2", anim = "tasered_2", walk = true, loop = false },
	["wtf4"] = { dict = "anim@mp_player_intupperface_palm", anim = "idle_a", walk = true, loop = false },
	["cortaessa"] = { dict = "gestures@m@standing@casual", anim = "gesture_no_way", walk = false, loop = false },
	["joia"] = { dict = "anim@mp_player_intincarthumbs_uplow@ds@", anim = "enter", walk = false, loop = false },
	["joia2"] = { dict = "anim@mp_player_intselfiethumbs_up", anim = "idle_a", walk = false, loop = false },
	["carona"] = { dict = "random@hitch_lift", anim = "idle_f", walk = false, loop = false },
	["escorregar"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "slide_a_player_a", walk = false, loop = false },
	["escorregar2"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "slide_c_player_a", walk = false, loop = false },
	["passa"] = { dict = "mini@strip_club@lap_dance@ld_girl_a_approach", anim = "ld_girl_a_approach_f", walk = false, loop = false },
	["cachorro"] = { dict = "random@peyote@dog", anim = "wakeup", walk = false, loop = false },
	["karate"] = { dict = "anim@mp_player_intcelebrationfemale@karate_chops", anim = "karate_chops", walk = false, loop = false },
	["karate2"] = { dict = "anim@mp_player_intcelebrationmale@karate_chops", anim = "karate_chops", walk = false, loop = false },
	["alongar3"] = { dict = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_d", walk = false, loop = false },
	["alongar4"] = { dict = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_c", walk = false, loop = false },
	["alongar5"] = { dict = "mini@triathlon", anim = "idle_f", walk = false, loop = true },
	["alongar6"] = { dict = "mini@triathlon", anim = "idle_d", walk = false, loop = true },
	["alongar7"] = { dict = "rcmfanatic1maryann_stretchidle_b", anim = "idle_e", walk = false, loop = true },
	["alongar8"] = { dict = "timetable@reunited@ig_2", anim = "jimmy_getknocked", walk = false, loop = true },
	["casalm"] = { dict = "timetable@trevor@ig_1", anim = "ig_1_thedontknowwhy_trevor", walk = false, loop = true },
	["casalf"] = { dict = "timetable@trevor@ig_1", anim = "ig_1_thedontknowwhy_patricia", walk = false, loop = true },
	["casalm2"] = { dict = "timetable@trevor@ig_1", anim = "ig_1_thedesertissobeautiful_trevor", walk = false, loop = true },
	["casalf2"] = { dict = "timetable@trevor@ig_1", anim = "ig_1_thedesertissobeautiful_patricia", walk = false, loop = true },
	["dormir4"] = { dict = "mp_sleep", anim = "sleep_loop", walk = false, loop = true },
	["dormir5"] = { dict = "missarmenian2", anim = "drunk_loop", walk = false, loop = true },
	["deitar6"] = { dict = "switch@trevor@annoys_sunbathers", anim = "trev_annoys_sunbathers_loop_girl", walk = false, loop = true },
	["deitar7"] = { dict = "switch@trevor@annoys_sunbathers", anim = "trev_annoys_sunbathers_loop_guy", walk = false, loop = true },
	["palmas5"] = { dict = "anim@mp_player_intupperslow_clap", anim = "idle_a", walk = false, loop = true },
	["celebrar"] = { dict = "rcmfanatic1celebrate", anim = "celebrate", walk = false, loop = false },
	["rebolar"] = { dict = "switch@trevor@mocks_lapdance", anim = "001443_01_trvs_28_idle_stripper", walk = false, loop = true },
	["bong"] = { dict = "anim@safehouse@bong", anim = "bong_stage1", prop = "prop_bong_01", flag = 49, mao = 18905, altura = 0.10, pos1 = -0.25, pos2 = 0.0, pos3 = 95.0, pos4 = 190.0, pos5 = 180.0 },
	["mic"] = { dict = "missfra1", anim = "mcs2_crew_idle_m_boom", prop = "prop_v_bmike_01", flag = 50, mao = 28422, altura = -0.08, pos1 = 0.0, pos2 = 0.0, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["mic2"] = { dict = "missmic4premiere", anim = "interview_short_lazlow", prop = "p_ing_microphonel_01", flag = 50, mao = 28422 },
	["mic3"] = { dict = "anim@random@shop_clothes@watches", anim = "base", prop = "p_ing_microphonel_01", flag = 49, mao = 60309, altura = 0.10, pos1 = 0.04, pos2 = 0.012, pos3 = -60.0, pos4 = 60.0, pos5 = -30.0 },
	["megaphone"] = { dict = "anim@random@shop_clothes@watches", anim = "base", prop = "prop_megaphone_01", flag = 49, mao = 60309, altura = 0.10, pos1 = 0.04, pos2 = 0.012, pos3 = -60.0, pos4 = 100.0, pos5 = -30.0 },
	["livro"] = { dict = "cellphone@", anim = "cellphone_text_read_base", prop = "prop_novel_01", flag = 49, mao = 6286, altura = 0.15, pos1 = 0.03, pos2 = -0.065, pos3 = 0.0, pos4 = 180.0, pos5 = 90.0 },
	["radio2"] = { prop = "prop_boombox_01", flag = 50, mao = 57005, altura = 0.30, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa"] = { prop = "prop_ld_case_01", flag = 50, mao = 57005, altura = 0.16, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa2"] = { prop = "prop_ld_case_01_s", flag = 50, mao = 57005, altura = 0.16, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa3"] = { prop = "prop_security_case_01", flag = 50, mao = 57005, altura = 0.16, pos1 = 0, pos2 = -0.01, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa4"] = { prop = "w_am_case", flag = 50, mao = 57005, altura = 0.08, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa5"] = { prop = "xm_prop_x17_bag_med_01a", flag = 50, mao = 57005, altura = 0.425, pos1 = 0, pos2 = 0.025, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["caixa2"] = { prop = "prop_tool_box_04", flag = 50, mao = 57005, altura = 0.45, pos1 = 0, pos2 = 0.05, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["lixo"] = { prop = "prop_cs_rub_binbag_01", flag = 50, mao = 57005, altura = 0.11, pos1 = 0, pos2 = 0.0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["prebeber"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "p_amb_coffeecup_01", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["prebeber2"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop =
	"prop_ld_flow_bottle", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["prebeber3"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "prop_cs_bs_cup", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.10, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["prebeber4"] = { dict = "anim@heists@humane_labs@finale@keycards", anim = "ped_a_enter_loop", prop =
	"prop_drink_champ", flag = 49, mao = 18905, altura = 0.10, pos1 = -0.05, pos2 = 0.03, pos3 = -100.0, pos4 = 0.0, pos5 = -10.0 },
	["verificar"] = { dict = "amb@medic@standing@tendtodead@idle_a", anim = "idle_a", walk = false, loop = true },
	["mexer"] = { dict = "amb@prop_human_parking_meter@female@idle_a", anim = "idle_a_female", walk = true, loop = true },
	["cuidar"] = { dict = "mini@cpr@char_a@cpr_str", anim = "cpr_pumpchest", walk = true, loop = true },
	["cuidar2"] = { dict = "mini@cpr@char_a@cpr_str", anim = "cpr_kol", walk = true, loop = true },
	["cuidar3"] = { dict = "mini@cpr@char_a@cpr_str", anim = "cpr_kol_idle", walk = true, loop = true },
	["cansado"] = { dict = "rcmbarry", anim = "idle_d", walk = false, loop = true },
	["alongar2"] = { dict = "mini@triathlon", anim = "idle_e", walk = false, loop = true },
	["poledance"] = { dict = "mini@strip_club@pole_dance@pole_dance1", anim = "pd_dance_01", walk = false, loop = true },
	["poledance2"] = { dict = "mini@strip_club@pole_dance@pole_dance2", anim = "pd_dance_02", walk = false, loop = true },
	["poledance3"] = { dict = "mini@strip_club@pole_dance@pole_dance3", anim = "pd_dance_03", walk = false, loop = true },
	["meleca"] = { dict = "anim@mp_player_intuppernose_pick", anim = "idle_a", walk = true, loop = true },
	["bora"] = { dict = "missfam4", anim = "say_hurry_up_a_trevor", walk = true, loop = false },
	["limpar"] = { dict = "missfbi3_camcrew", anim = "final_loop_guy", walk = true, loop = false },
	["galinha"] = { dict = "random@peyote@chicken", anim = "wakeup", walk = true, loop = true },
	["amem"] = { dict = "rcmepsilonism8", anim = "worship_base", walk = true, loop = true },
	["nervoso"] = { dict = "rcmme_tracey1", anim = "nervous_loop", walk = true, loop = true },
	["ajoelhar"] = { dict = "amb@medic@standing@kneel@idle_a", anim = "idle_a", walk = false, loop = true },
	["sinalizar"] = { dict = "amb@world_human_car_park_attendant@male@base", anim = "base", prop = "prop_parking_wand_01", flag = 49, mao = 28422 },
	["placa"] = { dict = "amb@world_human_bum_freeway@male@base", anim = "base", prop = "prop_beggers_sign_01", flag = 49, mao = 28422 },
	["placa2"] = { dict = "amb@world_human_bum_freeway@male@base", anim = "base", prop = "prop_beggers_sign_03", flag = 49, mao = 28422 },
	["placa3"] = { dict = "amb@world_human_bum_freeway@male@base", anim = "base", prop = "prop_beggers_sign_04", flag = 49, mao = 28422 },
	["abanar"] = { dict = "timetable@amanda@facemask@base", anim = "base", walk = true, loop = true },
	["cocada"] = { dict = "mp_player_int_upperarse_pick", anim = "mp_player_int_arse_pick", walk = true, loop = true },
	["cocada2"] = { dict = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch", walk = true, loop = true },
	["lero"] = { dict = "anim@mp_player_intselfiejazz_hands", anim = "idle_a", walk = true, loop = false },
	["dj2"] = { dict = "anim@mp_player_intupperair_synth", anim = "idle_a_fp", walk = false, loop = true },
	["beijo"] = { dict = "anim@mp_player_intselfieblow_kiss", anim = "exit", walk = true, loop = false },
	["malicia"] = { dict = "anim@mp_player_intupperdock", anim = "idle_a", walk = true, loop = false },
	["ligar"] = { dict = "cellphone@", anim = "cellphone_call_in", prop = "prop_npc_phone_02", flag = 50, mao = 28422 },
	["radio"] = { dict = "cellphone@", anim = "cellphone_call_in", prop = "prop_cs_hand_radio", flag = 50, mao = 28422 },
	["cafe"] = { dict = "amb@world_human_aa_coffee@base", anim = "base", prop = "p_amb_coffeecup_01", flag = 50, mao = 28422 },
	["cafe2"] = { dict = "amb@world_human_aa_coffee@idle_a", anim = "idle_a", prop = "p_amb_coffeecup_01", flag = 49, mao = 28422 },
	["cafe3"] = { dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", prop = "p_amb_coffeecup_01", flag = 49, mao = 28422 },
	["chuva"] = { dict = "amb@world_human_drinking@coffee@male@base", anim = "base", prop = "p_amb_brolly_01", flag = 50, mao = 28422 },
	["chuva2"] = { dict = "amb@world_human_drinking@coffee@male@base", anim = "base", prop = "p_amb_brolly_01_s", flag = 50, mao = 28422 },
	["comer"] = { dict = "amb@code_human_wander_eating_donut@male@idle_a", anim = "idle_c", prop = "prop_cs_burger_01", flag = 49, mao = 28422 },
	["comer2"] = { dict = "amb@code_human_wander_eating_donut@male@idle_a", anim = "idle_c", prop = "prop_cs_hotdog_01", flag = 49, mao = 28422 },
	["comer3"] = { dict = "amb@code_human_wander_eating_donut@male@idle_a", anim = "idle_c", prop = "prop_amb_donut", flag = 49, mao = 28422 },
	["comer4"] = { dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", prop = "prop_choc_ego", flag = 49, mao = 60309 },
	["comer5"] = { dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", prop = "prop_sandwich_01", flag = 49, mao = 18905, altura = 0.13, pos1 = 0.05, pos2 = 0.02, pos3 = -50.0, pos4 = 16.0, pos5 = 60.0 },
	["comer6"] = { dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", prop = "prop_taco_01", flag = 49, mao = 18905, altura = 0.16, pos1 = 0.06, pos2 = 0.02, pos3 = -50.0, pos4 = 220.0, pos5 = 60.0 },
	["comer7"] = { dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", prop = "prop_food_bs_chips", flag = 49, mao = 18905, altura = 0.10, pos1 = 0.0, pos2 = 0.08, pos3 = 150.0, pos4 = 320.0, pos5 = 160.0 },
	["beber"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "p_cs_bottle_01", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber2"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_energy_drink", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber3"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_amb_beer_bottle", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber4"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "p_whiskey_notop", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber5"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_beer_logopen", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.10, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber6"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_beer_blr", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.10, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber7"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_ld_flow_bottle", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber8"] = { dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", prop = "prop_plastic_cup_02", flag = 49, mao = 28422 },
	["beber9"] = { dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", prop = "prop_food_bs_juice03", flag = 49, mao = 28422, altura = 0.0, pos1 = -0.01, pos2 = -0.15, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber10"] = { dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", prop = "ng_proc_sodacan_01b", flag = 49, mao = 28422, altura = 0.0, pos1 = -0.01, pos2 = -0.08, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["digitar"] = { dict = "anim@heists@prison_heistig1_p1_guard_checks_bus", anim = "loop", walk = false, loop = true },
	["continencia"] = { dict = "mp_player_int_uppersalute", anim = "mp_player_int_salute", walk = true, loop = true },
	["atm"] = { dict = "amb@prop_human_atm@male@idle_a", anim = "idle_a", walk = false, loop = false },
	["no"] = { dict = "mp_player_int_upper_nod", anim = "mp_player_int_nod_no", walk = true, loop = true },
	["palmas"] = { dict = "anim@mp_player_intcelebrationfemale@slow_clap", anim = "slow_clap", walk = true, loop = false },
	["palmas2"] = { dict = "amb@world_human_cheering@male_b", anim = "base", walk = true, loop = true },
	["palmas3"] = { dict = "amb@world_human_cheering@male_d", anim = "base", walk = true, loop = true },
	["palmas4"] = { dict = "amb@world_human_cheering@male_e", anim = "base", walk = true, loop = true },
	["postura"] = { dict = "anim@heists@prison_heiststation@cop_reactions", anim = "cop_a_idle", walk = true, loop = true },
	["postura2"] = { dict = "amb@world_human_cop_idles@female@base", anim = "base", walk = true, loop = true },
	["varrer"] = { dict = "amb@world_human_janitor@male@idle_a", anim = "idle_a", prop = "prop_tool_broom", flag = 49, mao = 28422 },
	["musica"] = { dict = "amb@world_human_musician@guitar@male@base", anim = "base", prop = "prop_el_guitar_01", flag = 49, mao = 60309 },
	["musica2"] = { dict = "amb@world_human_musician@guitar@male@base", anim = "base", prop = "prop_el_guitar_02", flag = 49, mao = 60309 },
	["musica3"] = { dict = "amb@world_human_musician@guitar@male@base", anim = "base", prop = "prop_el_guitar_03", flag = 49, mao = 60309 },
	["musica4"] = { dict = "amb@world_human_musician@guitar@male@base", anim = "base", prop = "prop_acc_guitar_01", flag = 49, mao = 60309 },
	["musica5"] = { dict = "switch@trevor@guitar_beatdown", anim = "001370_02_trvs_8_guitar_beatdown_idle_busker", prop =
	"prop_acc_guitar_01", flag = 49, mao = 24818, altura = -0.05, pos1 = 0.31, pos2 = 0.1, pos3 = 0.0, pos4 = 20.0, pos5 = 150.0 },
	["camera"] = { dict = "missfinale_c2mcs_1", anim = "fin_c2_mcs_1_camman", prop = "prop_v_cam_01", flag = 49, mao = 28422 },
	["anotar"] = { dict = "amb@medic@standing@timeofdeath@base", anim = "base", prop = "prop_notepad_01", flag = 49, mao = 60309 },
	["peace"] = { dict = "mp_player_int_upperpeace_sign", anim = "mp_player_int_peace_sign", walk = true, loop = true },
	["deitar"] = { dict = "anim@gangops@morgue@table@", anim = "body_search", walk = false, loop = true },
	["deitar2"] = { dict = "amb@world_human_sunbathe@female@front@idle_a", anim = "idle_a", walk = false, loop = true },
	["deitar3"] = { dict = "amb@world_human_sunbathe@male@back@idle_a", anim = "idle_a", walk = false, loop = true },
	["deitar4"] = { dict = "amb@world_human_sunbathe@male@front@idle_a", anim = "idle_a", walk = false, loop = true },
	["deitar5"] = { dict = "amb@world_human_sunbathe@female@back@idle_a", anim = "idle_a", walk = false, loop = true },
	["debrucar"] = { dict = "amb@prop_human_bum_shopping_cart@male@base", anim = "base", walk = false, loop = true },
	["debrucar2"] = { dict = "anim@amb@clubhouse@bar@drink@idle_a", anim = "idle_a_bartender", walk = true, loop = true },
	["dancar"] = { dict = "rcmnigel1bnmt_1b", anim = "dance_loop_tyler", walk = false, loop = true },
	["dancar2"] = { dict = "mp_safehouse", anim = "lap_dance_girl", walk = false, loop = true },
	["dancar3"] = { dict = "misschinese2_crystalmazemcs1_cs", anim = "dance_loop_tao", walk = false, loop = true },
	["dancar4"] = { dict = "mini@strip_club@private_dance@part1", anim = "priv_dance_p1", walk = false, loop = true },
	["dancar5"] = { dict = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2", walk = false, loop = true },
	["dancar6"] = { dict = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3", walk = false, loop = true },
	["dancar7"] = { dict = "special_ped@mountain_dancer@monologue_2@monologue_2a", anim = "mnt_dnc_angel", walk = false, loop = true },
	["dancar8"] = { dict = "special_ped@mountain_dancer@monologue_3@monologue_3a", anim = "mnt_dnc_buttwag", walk = false, loop = true },
	["dancar9"] = { dict = "missfbi3_sniping", anim = "dance_m_default", walk = false, loop = true },
	["dancar10"] = { dict = "anim@amb@nightclub@dancers@black_madonna_entourage@", anim = "hi_dance_facedj_09_v2_male^5", walk = false, loop = true },
	["dancar11"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v1_female^1", walk = false, loop = true },
	["dancar12"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v1_female^2", walk = false, loop = true },
	["dancar13"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v1_female^3", walk = false, loop = true },
	["dancar14"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v1_female^4", walk = false, loop = true },
	["dancar15"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v1_female^5", walk = false, loop = true },
	["dancar16"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v1_female^6", walk = false, loop = true },
	["dancar17"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v1_male^1", walk = false, loop = true },
	["dancar18"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v1_male^2", walk = false, loop = true },
	["dancar19"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v1_male^3", walk = false, loop = true },
	["dancar20"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v1_male^4", walk = false, loop = true },
	["dancar21"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v1_male^5", walk = false, loop = true },
	["dancar22"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v1_male^6", walk = false, loop = true },
	["dancar23"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v2_female^1", walk = false, loop = true },
	["dancar24"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v2_female^2", walk = false, loop = true },
	["dancar25"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v2_female^3", walk = false, loop = true },
	["dancar26"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v2_female^4", walk = false, loop = true },
	["dancar27"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v2_female^5", walk = false, loop = true },
	["dancar28"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v2_female^6", walk = false, loop = true },
	["dancar29"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v2_male^1", walk = false, loop = true },
	["dancar30"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v2_male^2", walk = false, loop = true },
	["dancar31"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v2_male^3", walk = false, loop = true },
	["dancar32"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v2_male^4", walk = false, loop = true },
	["dancar33"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v2_male^5", walk = false, loop = true },
	["dancar34"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_09_v2_male^6", walk = false, loop = true },
	["dancar35"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v1_female^1", walk = false, loop = true },
	["dancar36"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v1_female^2", walk = false, loop = true },
	["dancar37"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v1_female^3", walk = false, loop = true },
	["dancar38"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v1_female^4", walk = false, loop = true },
	["dancar39"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v1_female^5", walk = false, loop = true },
	["dancar40"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v1_female^6", walk = false, loop = true },
	["dancar41"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v1_male^1", walk = false, loop = true },
	["dancar42"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v1_male^2", walk = false, loop = true },
	["dancar43"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v1_male^3", walk = false, loop = true },
	["dancar44"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v1_male^4", walk = false, loop = true },
	["dancar45"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v1_male^5", walk = false, loop = true },
	["dancar46"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v1_male^6", walk = false, loop = true },
	["dancar47"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v2_female^1", walk = false, loop = true },
	["dancar48"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v2_female^2", walk = false, loop = true },
	["dancar49"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v2_female^3", walk = false, loop = true },
	["dancar50"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v2_female^4", walk = false, loop = true },
	["dancar51"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v2_female^5", walk = false, loop = true },
	["dancar52"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v2_female^6", walk = false, loop = true },
	["dancar53"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v2_male^1", walk = false, loop = true },
	["dancar54"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v2_male^2", walk = false, loop = true },
	["dancar55"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v2_male^3", walk = false, loop = true },
	["dancar56"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v2_male^4", walk = false, loop = true },
	["dancar57"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v2_male^5", walk = false, loop = true },
	["dancar58"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_11_v2_male^6", walk = false, loop = true },
	["dancar59"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v1_female^1", walk = false, loop = true },
	["dancar60"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v1_female^2", walk = false, loop = true },
	["dancar61"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v1_female^3", walk = false, loop = true },
	["dancar62"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v1_female^4", walk = false, loop = true },
	["dancar63"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v1_female^5", walk = false, loop = true },
	["dancar64"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v1_female^6", walk = false, loop = true },
	["dancar65"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v1_male^1", walk = false, loop = true },
	["dancar66"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v1_male^2", walk = false, loop = true },
	["dancar67"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v1_male^3", walk = false, loop = true },
	["dancar68"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v1_male^4", walk = false, loop = true },
	["dancar69"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v1_male^5", walk = false, loop = true },
	["dancar70"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v1_male^6", walk = false, loop = true },
	["dancar71"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v2_female^1", walk = false, loop = true },
	["dancar72"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v2_female^2", walk = false, loop = true },
	["dancar73"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v2_female^3", walk = false, loop = true },
	["dancar74"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v2_female^4", walk = false, loop = true },
	["dancar75"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v2_female^5", walk = false, loop = true },
	["dancar76"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v2_female^6", walk = false, loop = true },
	["dancar77"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v2_male^1", walk = false, loop = true },
	["dancar78"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v2_male^2", walk = false, loop = true },
	["dancar79"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v2_male^3", walk = false, loop = true },
	["dancar80"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v2_male^4", walk = false, loop = true },
	["dancar81"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v2_male^5", walk = false, loop = true },
	["dancar82"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_13_v2_male^6", walk = false, loop = true },
	["dancar83"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v1_female^1", walk = false, loop = true },
	["dancar84"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v1_female^2", walk = false, loop = true },
	["dancar85"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v1_female^3", walk = false, loop = true },
	["dancar86"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v1_female^4", walk = false, loop = true },
	["dancar87"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v1_female^5", walk = false, loop = true },
	["dancar88"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v1_female^6", walk = false, loop = true },
	["dancar89"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v1_male^1", walk = false, loop = true },
	["dancar90"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v1_male^2", walk = false, loop = true },
	["dancar91"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v1_male^3", walk = false, loop = true },
	["dancar92"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v1_male^4", walk = false, loop = true },
	["dancar93"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v1_male^5", walk = false, loop = true },
	["dancar94"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v1_male^6", walk = false, loop = true },
	["dancar95"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v2_female^1", walk = false, loop = true },
	["dancar96"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v2_female^2", walk = false, loop = true },
	["dancar97"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v2_female^3", walk = false, loop = true },
	["dancar98"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v2_female^4", walk = false, loop = true },
	["dancar99"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v2_female^5", walk = false, loop = true },
	["dancar100"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v2_female^6", walk = false, loop = true },
	["dancar101"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v2_male^1", walk = false, loop = true },
	["dancar102"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v2_male^2", walk = false, loop = true },
	["dancar103"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v2_male^3", walk = false, loop = true },
	["dancar104"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v2_male^4", walk = false, loop = true },
	["dancar105"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v2_male^5", walk = false, loop = true },
	["dancar106"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_15_v2_male^6", walk = false, loop = true },
	["dancar107"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v1_female^1", walk = false, loop = true },
	["dancar108"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v1_female^2", walk = false, loop = true },
	["dancar109"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v1_female^3", walk = false, loop = true },
	["dancar110"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v1_female^4", walk = false, loop = true },
	["dancar111"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v1_female^5", walk = false, loop = true },
	["dancar112"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v1_female^6", walk = false, loop = true },
	["dancar113"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v1_male^1", walk = false, loop = true },
	["dancar114"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v1_male^2", walk = false, loop = true },
	["dancar115"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v1_male^3", walk = false, loop = true },
	["dancar116"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v1_male^4", walk = false, loop = true },
	["dancar117"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v1_male^5", walk = false, loop = true },
	["dancar118"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v1_male^6", walk = false, loop = true },
	["dancar119"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v2_female^1", walk = false, loop = true },
	["dancar120"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v2_female^2", walk = false, loop = true },
	["dancar121"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v2_female^3", walk = false, loop = true },
	["dancar122"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v2_female^4", walk = false, loop = true },
	["dancar123"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v2_female^5", walk = false, loop = true },
	["dancar124"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v2_female^6", walk = false, loop = true },
	["dancar125"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v2_male^1", walk = false, loop = true },
	["dancar126"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v2_male^2", walk = false, loop = true },
	["dancar127"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v2_male^3", walk = false, loop = true },
	["dancar128"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v2_male^4", walk = false, loop = true },
	["dancar129"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v2_male^5", walk = false, loop = true },
	["dancar130"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim =
	"hi_dance_facedj_17_v2_male^6", walk = false, loop = true },
	["dancar131"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v1_female^1", walk = false, loop = true },
	["dancar132"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v1_female^2", walk = false, loop = true },
	["dancar133"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v1_female^3", walk = false, loop = true },
	["dancar134"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v1_female^4", walk = false, loop = true },
	["dancar135"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v1_female^5", walk = false, loop = true },
	["dancar136"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v1_female^6", walk = false, loop = true },
	["dancar137"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v1_male^1", walk = false, loop = true },
	["dancar138"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v1_male^2", walk = false, loop = true },
	["dancar139"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v1_male^3", walk = false, loop = true },
	["dancar140"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v1_male^4", walk = false, loop = true },
	["dancar141"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v1_male^5", walk = false, loop = true },
	["dancar142"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v1_male^6", walk = false, loop = true },
	["dancar143"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v2_female^1", walk = false, loop = true },
	["dancar144"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v2_female^2", walk = false, loop = true },
	["dancar145"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v2_female^3", walk = false, loop = true },
	["dancar146"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v2_female^4", walk = false, loop = true },
	["dancar147"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v2_female^5", walk = false, loop = true },
	["dancar148"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v2_female^6", walk = false, loop = true },
	["dancar149"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v2_male^1", walk = false, loop = true },
	["dancar150"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v2_male^2", walk = false, loop = true },
	["dancar151"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v2_male^3", walk = false, loop = true },
	["dancar152"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v2_male^4", walk = false, loop = true },
	["dancar153"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v2_male^5", walk = false, loop = true },
	["dancar154"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_09_v2_male^6", walk = false, loop = true },
	["dancar155"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_11_v1_female^1", walk = false, loop = true },
	["dancar156"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_11_v1_female^2", walk = false, loop = true },
	["dancar157"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_11_v1_female^3", walk = false, loop = true },
	["dancar158"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_11_v1_female^4", walk = false, loop = true },
	["dancar159"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_11_v1_female^5", walk = false, loop = true },
	["dancar160"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_11_v1_female^6", walk = false, loop = true },
	["dancar161"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_11_v1_male^1", walk = false, loop = true },
	["dancar162"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_11_v1_male^2", walk = false, loop = true },
	["dancar163"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_11_v1_male^3", walk = false, loop = true },
	["dancar164"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_11_v1_male^4", walk = false, loop = true },
	["dancar165"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_11_v1_male^5", walk = false, loop = true },
	["dancar166"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_11_v1_male^6", walk = false, loop = true },
	["dancar167"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_13_v2_female^1", walk = false, loop = true },
	["dancar168"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_13_v2_female^2", walk = false, loop = true },
	["dancar169"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_13_v2_female^3", walk = false, loop = true },
	["dancar170"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_13_v2_female^4", walk = false, loop = true },
	["dancar171"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_13_v2_female^5", walk = false, loop = true },
	["dancar172"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_13_v2_female^6", walk = false, loop = true },
	["dancar173"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_13_v2_male^1", walk = false, loop = true },
	["dancar174"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_13_v2_male^2", walk = false, loop = true },
	["dancar175"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_13_v2_male^3", walk = false, loop = true },
	["dancar176"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_13_v2_male^4", walk = false, loop = true },
	["dancar177"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_13_v2_male^5", walk = false, loop = true },
	["dancar178"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_13_v2_male^6", walk = false, loop = true },
	["dancar179"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v1_female^1", walk = false, loop = true },
	["dancar180"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v1_female^2", walk = false, loop = true },
	["dancar181"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v1_female^3", walk = false, loop = true },
	["dancar182"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v1_female^4", walk = false, loop = true },
	["dancar183"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v1_female^5", walk = false, loop = true },
	["dancar184"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v1_female^6", walk = false, loop = true },
	["dancar185"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v1_male^1", walk = false, loop = true },
	["dancar186"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v1_male^2", walk = false, loop = true },
	["dancar187"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v1_male^3", walk = false, loop = true },
	["dancar188"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v1_male^4", walk = false, loop = true },
	["dancar189"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v1_male^5", walk = false, loop = true },
	["dancar190"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v1_male^6", walk = false, loop = true },
	["dancar191"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v2_female^1", walk = false, loop = true },
	["dancar192"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v2_female^2", walk = false, loop = true },
	["dancar193"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v2_female^3", walk = false, loop = true },
	["dancar194"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v2_female^4", walk = false, loop = true },
	["dancar195"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v2_female^5", walk = false, loop = true },
	["dancar196"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v2_female^6", walk = false, loop = true },
	["dancar197"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v2_male^1", walk = false, loop = true },
	["dancar198"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v2_male^2", walk = false, loop = true },
	["dancar199"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v2_male^3", walk = false, loop = true },
	["dancar200"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v2_male^4", walk = false, loop = true },
	["dancar201"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v2_male^5", walk = false, loop = true },
	["dancar202"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_15_v2_male^6", walk = false, loop = true },
	["dancar203"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v1_female^1", walk = false, loop = true },
	["dancar204"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v1_female^2", walk = false, loop = true },
	["dancar205"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v1_female^3", walk = false, loop = true },
	["dancar206"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v1_female^4", walk = false, loop = true },
	["dancar207"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v1_female^5", walk = false, loop = true },
	["dancar208"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v1_female^6", walk = false, loop = true },
	["dancar209"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v1_male^1", walk = false, loop = true },
	["dancar210"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v1_male^2", walk = false, loop = true },
	["dancar211"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v1_male^3", walk = false, loop = true },
	["dancar212"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v1_male^4", walk = false, loop = true },
	["dancar213"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v1_male^5", walk = false, loop = true },
	["dancar214"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v1_male^6", walk = false, loop = true },
	["dancar215"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v2_female^1", walk = false, loop = true },
	["dancar216"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v2_female^2", walk = false, loop = true },
	["dancar217"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v2_female^3", walk = false, loop = true },
	["dancar218"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v2_female^4", walk = false, loop = true },
	["dancar219"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v2_female^5", walk = false, loop = true },
	["dancar220"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v2_female^6", walk = false, loop = true },
	["dancar221"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v2_male^1", walk = false, loop = true },
	["dancar222"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v2_male^2", walk = false, loop = true },
	["dancar223"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v2_male^3", walk = false, loop = true },
	["dancar224"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v2_male^4", walk = false, loop = true },
	["dancar225"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v2_male^5", walk = false, loop = true },
	["dancar226"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim =
	"hi_dance_crowd_17_v2_male^6", walk = false, loop = true },
	["dancar227"] = { dict = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_11_buttwiggle_b_laz", walk = false, loop = true },
	["dancar228"] = { dict = "timetable@tracy@ig_5@idle_a", anim = "idle_a", walk = false, loop = true },
	["dancar229"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_down", walk = false, loop = true },
	["dancar230"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_center_up", walk = false, loop = true },
	["dancar231"] = { dict = "anim@mp_player_intupperfind_the_fish", anim = "idle_a", walk = true, loop = true },
	["dancar232"] = { dict = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_11_buttwiggle_b_laz", walk = false, loop = true },
	["dancar233"] = { dict = "move_clown@p_m_two_idles@", anim = "fidget_short_dance", walk = false, loop = true },
	["dancar234"] = { dict = "move_clown@p_m_zero_idles@", anim = "fidget_short_dance", walk = false, loop = true },
	["dancar235"] = { dict = "misschinese2_crystalmazemcs1_ig", anim = "dance_loop_tao", walk = false, loop = true },
	["dancar236"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center", walk = false, loop = true },
	["dancar237"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_center_down", walk = false, loop = true },
	["dancar238"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_center", walk = false, loop = true },
	["dancar239"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center_up", walk = false, loop = true },
	["dancar240"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center", walk = true, loop = true },
	["dancar241"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_up", walk = false, loop = true },
	["dancar242"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center", walk = false, loop = true },
	["dancar243"] = { dict = "anim@amb@nightclub@dancers@podium_dancers@", anim = "hi_dance_facedj_17_v2_male^5", walk = false, loop = true },
	["dancar244"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_center", walk = false, loop = true },
	["dancar245"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center_down", walk = false, loop = true },
	["dancar246"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center", walk = false, loop = true },
	["dancar247"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center_up", walk = false, loop = true },
	["dancar248"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center", walk = false, loop = true },
	["dancar249"] = { dict = "anim@amb@nightclub@dancers@solomun_entourage@", anim = "mi_dance_facedj_17_v1_female^1", walk = false, loop = true },
	["dancar250"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_center_up", walk = false, loop = true },
	["dancar251"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_center", walk = false, loop = true },
	["dancar252"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_center", walk = false, loop = true },
	["dancar253"] = { dict = "mini@strip_club@private_dance@idle", anim = "priv_dance_idle", walk = false, loop = true },
	["dancar254"] = { dict = "mini@strip_club@lap_dance_2g@ld_2g_p1", anim = "ld_2g_p1_s2", walk = false, loop = true },
	["dancar255"] = { dict = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f", walk = false, loop = true },
	["dancar256"] = { dict = "anim@amb@nightclub@lazlow@hi_dancefloor@", anim = "dancecrowd_li_11_hu_shimmy_laz", walk = false, loop = true },
	["dancar257"] = { dict = "anim@amb@nightclub@lazlow@hi_dancefloor@", anim = "crowddance_hi_11_handup_laz", walk = false, loop = true },
	["dancar258"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_left_down", walk = false, loop = true },
	["dancar259"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_left_up", walk = false, loop = true },
	["dancar260"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_right", walk = false, loop = true },
	["dancar261"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_right_down", walk = false, loop = true },
	["dancar262"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_right_up", walk = false, loop = true },
	["dancar263"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_center", walk = false, loop = true },
	["dancar264"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_center_down", walk = false, loop = true },
	["dancar265"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_center_up", walk = false, loop = true },
	["dancar266"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_left", walk = false, loop = true },
	["dancar267"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_left_down", walk = false, loop = true },
	["dancar268"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_left_up", walk = false, loop = true },
	["dancar269"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_right", walk = false, loop = true },
	["dancar270"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_right_down", walk = false, loop = true },
	["dancar271"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_left", walk = false, loop = true },
	["dancar272"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_left_down", walk = false, loop = true },
	["dancar273"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_left_up", walk = false, loop = true },
	["dancar274"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_right", walk = false, loop = true },
	["dancar275"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_right_down", walk = false, loop = true },
	["dancar276"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_right_up", walk = false, loop = true },
	["dancar277"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_center", walk = false, loop = true },
	["dancar278"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_center_down", walk = false, loop = true },
	["dancar279"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_center_up", walk = false, loop = true },
	["dancar280"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_left", walk = false, loop = true },
	["dancar281"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_left_down", walk = false, loop = true },
	["dancar282"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_left_up", walk = false, loop = true },
	["dancar283"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_right", walk = false, loop = true },
	["dancar284"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_right_down", walk = false, loop = true },
	["dancar285"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_right_up", walk = false, loop = true },
	["dancar286"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center", walk = false, loop = true },
	["dancar287"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center_down", walk = false, loop = true },
	["dancar288"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center_up", walk = false, loop = true },
	["dancar289"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_left", walk = false, loop = true },
	["dancar290"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_left_down", walk = false, loop = true },
	["dancar291"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_left_up", walk = false, loop = true },
	["dancar292"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_right", walk = false, loop = true },
	["dancar293"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_right_down", walk = false, loop = true },
	["dancar294"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_right_up", walk = false, loop = true },
	["dancar295"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_right_up", walk = false, loop = true },
	["dancar296"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_center_down", walk = false, loop = true },
	["dancar297"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_center_up", walk = false, loop = true },
	["dancar298"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_left", walk = false, loop = true },
	["dancar299"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_left_down", walk = false, loop = true },
	["dancar300"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_left_up", walk = false, loop = true },
	["dancar301"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_right", walk = false, loop = true },
	["dancar302"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_right_down", walk = false, loop = true },
	["dancar303"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_right_up", walk = false, loop = true },
	["dancar304"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_center", walk = false, loop = true },
	["dancar305"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_center_down", walk = false, loop = true },
	["dancar306"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_center_up", walk = false, loop = true },
	["dancar307"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_left", walk = false, loop = true },
	["dancar308"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_left_down", walk = false, loop = true },
	["dancar309"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_left_up", walk = false, loop = true },
	["dancar310"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_right", walk = false, loop = true },
	["dancar311"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_right_down", walk = false, loop = true },
	["dancar312"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_right_up", walk = false, loop = true },
	["dancar313"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center", walk = false, loop = true },
	["dancar314"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_down", walk = false, loop = true },
	["dancar315"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_up", walk = false, loop = true },
	["dancar316"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_left", walk = false, loop = true },
	["dancar317"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_left_down", walk = false, loop = true },
	["dancar318"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_left_up", walk = false, loop = true },
	["dancar319"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_right", walk = false, loop = true },
	["dancar320"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_right_down", walk = false, loop = true },
	["dancar321"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_right_up", walk = false, loop = true },
	["dancar322"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center", walk = false, loop = true },
	["dancar323"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center_down", walk = false, loop = true },
	["dancar324"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center_up", walk = false, loop = true },
	["dancar325"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_left", walk = false, loop = true },
	["dancar326"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_left_down", walk = false, loop = true },
	["dancar327"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_left_up", walk = false, loop = true },
	["dancar328"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_right", walk = false, loop = true },
	["dancar329"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_right_down", walk = false, loop = true },
	["dancar330"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_right_up", walk = false, loop = true },
	["dancar331"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_center", walk = false, loop = true },
	["dancar332"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_center_down", walk = false, loop = true },
	["dancar333"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_center_up", walk = false, loop = true },
	["dancar334"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_left", walk = false, loop = true },
	["dancar335"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_left_down", walk = false, loop = true },
	["dancar336"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_left_up", walk = false, loop = true },
	["dancar337"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_right", walk = false, loop = true },
	["dancar338"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_right_down", walk = false, loop = true },
	["dancar339"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_right_up", walk = false, loop = true },
	["dancar340"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_center", walk = false, loop = true },
	["dancar341"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_center_down", walk = false, loop = true },
	["dancar342"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_center_up", walk = false, loop = true },
	["dancar343"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_left", walk = false, loop = true },
	["dancar344"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_left_down", walk = false, loop = true },
	["dancar345"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_left_up", walk = false, loop = true },
	["dancar346"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_right", walk = false, loop = true },
	["dancar347"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_right_down", walk = false, loop = true },
	["dancar348"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_right_up", walk = false, loop = true },
	["dancar349"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_center", walk = false, loop = true },
	["dancar350"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_center_down", walk = false, loop = true },
	["dancar351"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_center_up", walk = false, loop = true },
	["dancar352"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_left", walk = false, loop = true },
	["dancar353"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_left_down", walk = false, loop = true },
	["dancar354"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_left_up", walk = false, loop = true },
	["dancar355"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_right", walk = false, loop = true },
	["dancar356"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_right_down", walk = false, loop = true },
	["dancar357"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_right_up", walk = false, loop = true },
	["dancar358"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_center_up", walk = false, loop = true },
	["dancar359"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_center_down", walk = false, loop = true },
	["dancar360"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_center_up", walk = false, loop = true },
	["dancar361"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_left", walk = false, loop = true },
	["dancar362"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_left_down", walk = false, loop = true },
	["dancar363"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_left_up", walk = false, loop = true },
	["dancar364"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_right", walk = false, loop = true },
	["dancar365"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_right_down", walk = false, loop = true },
	["dancar366"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_right_up", walk = false, loop = true },
	["dancar367"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_left", walk = false, loop = true },
	["dancar368"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_center_down", walk = false, loop = true },
	["dancar369"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_center_up", walk = false, loop = true },
	["dancar370"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_left", walk = false, loop = true },
	["dancar371"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_left_down", walk = false, loop = true },
	["dancar372"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_left_up", walk = false, loop = true },
	["dancar373"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_right", walk = false, loop = true },
	["dancar374"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_right_down", walk = false, loop = true },
	["dancar375"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_right_up", walk = false, loop = true },
	["dancar376"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_center", walk = false, loop = true },
	["dancar377"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_center_down", walk = false, loop = true },
	["dancar378"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_left_up", walk = false, loop = true },
	["dancar379"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_f@", anim = "ped_a_dance_idle", walk = false, loop = true },
	["dancar380"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_f@", anim = "ped_b_dance_idle", walk = false, loop = true },
	["dancar381"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_mi_11_v1_male^1", walk = false, loop = true },
	["dancar382"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_h@", anim = "ped_b_dance_idle", walk = false, loop = true },
	["dancar383"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_j@", anim = "ped_a_dance_idle", walk = false, loop = true },
	["dancar384"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_m@", anim = "ped_a_dance_idle", walk = false, loop = true },
	["dancar385"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_f02", walk = false, loop = true },
	["dancar386"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_b_f02", walk = false, loop = true },
	["dancar387"] = { dict = "anim@mp_player_intcelebrationfemale@crowd_invitation", anim = "crowd_invitation", walk = false, loop = true },
	["dancar388"] = { dict = "anim@mp_player_intcelebrationfemale@driver", anim = "driver", walk = false, loop = true },
	["dancar389"] = { dict = "anim@mp_player_intcelebrationfemale@shooting", anim = "shooting", walk = false, loop = true },
	["dancar390"] = { dict = "anim@mp_player_intcelebrationmale@shooting", anim = "shooting", walk = false, loop = true },
	["dancar391"] = { dict = "anim@mp_player_intcelebrationmale@suck_it", anim = "suck_it", walk = false, loop = true },
	["dancar392"] = { dict = "anim@mp_player_intuppercrowd_invitation", anim = "idle_a", walk = false, loop = true },
	["dancar393"] = { dict = "anim@mp_player_intuppershooting", anim = "idle_a", walk = false, loop = true },
	["dancar394"] = { dict = "anim@mp_player_intuppersuck_it", anim = "idle_a", walk = false, loop = true },
	["dancar395"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_m01", walk = false, loop = true },
	["dancar396"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_m02", walk = false, loop = true },
	["dancar397"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_f01", walk = false, loop = true },
	["dancar398"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_f02", walk = false, loop = true },
	["dancar399"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_f03", walk = false, loop = true },
	["dancar400"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_m01", walk = false, loop = true },
	["dancar401"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_m02", walk = false, loop = true },
	["dancar402"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_f01", walk = false, loop = true },
	["dancar403"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_f02", walk = false, loop = true },
	["dancar404"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_f03", walk = false, loop = true },
	["dancar405"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_m01", walk = false, loop = true },
	["dancar406"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_f02", walk = false, loop = true },
	["dancar407"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_m02", walk = false, loop = true },
	["dancar408"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_e_f02", walk = false, loop = true },
	["dancar409"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_f_f02", walk = false, loop = true },
	["dancar410"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_f01", walk = false, loop = true },
	["dancar411"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_f02", walk = false, loop = true },
	["dancar412"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_f03", walk = false, loop = true },
	["dancar413"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_m01", walk = false, loop = true },
	["dancar414"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim =
	"mi_dance_facedj_17_v2_male^4", walk = false, loop = true },
	["dancar415"] = { dict = "anim@mp_player_intuppersalsa_roll", anim = "idle_a", walk = false, loop = true },
	["dancar416"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_center", walk = false, loop = true },
	["dancar417"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_center_down", walk = false, loop = true },
	["dancar418"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "med_center_down", walk = false, loop = true },
	["dancar419"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "med_right_down", walk = false, loop = true },
	["dancar420"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_d@", anim = "ped_a_dance_idle", walk = false, loop = true },
	["dancar421"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_b@", anim = "ped_a_dance_idle", walk = false, loop = true },
	["dancar422"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_a@", anim = "ped_a_dance_idle", walk = false, loop = true },
	["dancar423"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_17_v1_female^6", walk = false, loop = true },
	["dancar424"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_17_v1_female^5", walk = false, loop = true },
	["dancar425"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_17_v1_female^4", walk = false, loop = true },
	["dancar426"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_09_v1_female^2", walk = false, loop = true },
	["dancar427"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_09_v1_female^1", walk = false, loop = true },
	["dancar428"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_09_v1_male^6", walk = false, loop = true },
	["dancar429"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_09_v1_male^5", walk = false, loop = true },
	["dancar430"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_09_v1_male^4", walk = false, loop = true },
	["dancar431"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_09_v1_male^3", walk = false, loop = true },
	["dancar432"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_09_v1_male^2", walk = false, loop = true },
	["dancar433"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_09_v1_male^1", walk = false, loop = true },
	["dancar434"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_17_v1_male^3", walk = false, loop = true },
	["dancar435"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_17_v1_male^2", walk = false, loop = true },
	["dancar436"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_17_v1_male^1", walk = false, loop = true },
	["dancar437"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_17_v1_male^6", walk = false, loop = true },
	["dancar438"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_17_v1_male^5", walk = false, loop = true },
	["dancar439"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_17_v1_male^4", walk = false, loop = true },
	["dancar440"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_09_v1_female^6", walk = false, loop = true },
	["dancar441"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_09_v1_female^5", walk = false, loop = true },
	["dancar442"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_09_v1_female^4", walk = false, loop = true },
	["dancar443"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_09_v1_female^3", walk = false, loop = true },
	["dancar444"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v2_male^2", walk = false, loop = true },
	["dancar445"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v2_male^1", walk = false, loop = true },
	["dancar446"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v2_male^6", walk = false, loop = true },
	["dancar447"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v2_male^5", walk = false, loop = true },
	["dancar448"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v2_male^4", walk = false, loop = true },
	["dancar449"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_15_v1_female^6", walk = false, loop = true },
	["dancar450"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_15_v1_female^5", walk = false, loop = true },
	["dancar451"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_15_v1_female^4", walk = false, loop = true },
	["dancar452"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_15_v1_female^3", walk = false, loop = true },
	["dancar453"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_15_v1_female^2", walk = false, loop = true },
	["dancar454"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v2_male^3", walk = false, loop = true },
	["dancar455"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v1_female^5", walk = false, loop = true },
	["dancar456"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v1_female^4", walk = false, loop = true },
	["dancar457"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v1_female^3", walk = false, loop = true },
	["dancar458"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v1_female^2", walk = false, loop = true },
	["dancar459"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v1_female^5", walk = false, loop = true },
	["dancar460"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v1_female^4", walk = false, loop = true },
	["dancar461"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v1_female^3", walk = false, loop = true },
	["dancar462"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v1_female^2", walk = false, loop = true },
	["dancar463"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v1_female^1", walk = false, loop = true },
	["dancar464"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v1_female^6", walk = false, loop = true },
	["dancar465"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v1_female^1", walk = false, loop = true },
	["dancar466"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_09_v1_male^6", walk = false, loop = true },
	["dancar367"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_09_v1_male^5", walk = false, loop = true },
	["dancar468"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_09_v1_male^4", walk = false, loop = true },
	["dancar469"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_09_v1_male^3", walk = false, loop = true },
	["dancar470"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_09_v1_male^2", walk = false, loop = true },
	["dancar471"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_09_v1_male^1", walk = false, loop = true },
	["dancar472"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_17_v1_female^6", walk = false, loop = true },
	["dancar473"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_17_v1_female^5", walk = false, loop = true },
	["dancar474"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_17_v1_female^4", walk = false, loop = true },
	["dancar475"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_17_v1_female^3", walk = false, loop = true },
	["dancar476"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_17_v1_female^2", walk = false, loop = true },
	["dancar477"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_17_v1_female^1", walk = false, loop = true },
	["dancar478"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v1_female^6", walk = false, loop = true },
	["dancar479"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_11_v1_male^6", walk = false, loop = true },
	["dancar480"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_11_v1_male^5", walk = false, loop = true },
	["dancar481"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_11_v1_male^1", walk = false, loop = true },
	["dancar482"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_11_v1_male^4", walk = false, loop = true },
	["dancar483"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_11_v1_male^3", walk = false, loop = true },
	["dancar484"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_11_v1_male^2", walk = false, loop = true },
	["dancar485"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v2_male^5", walk = false, loop = true },
	["dancar486"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_11_v1_female^1", walk = false, loop = true },
	["dancar487"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v2_male^6", walk = false, loop = true },
	["dancar488"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_11_v1_female^6", walk = false, loop = true },
	["dancar489"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_11_v1_female^3", walk = false, loop = true },
	["dancar490"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_11_v1_female^2", walk = false, loop = true },
	["dancar491"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_13_v2_female^4", walk = false, loop = true },
	["dancar492"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_13_v2_female^3", walk = false, loop = true },
	["dancar493"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_13_v2_female^2", walk = false, loop = true },
	["dancar494"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_13_v2_female^1", walk = false, loop = true },
	["dancar495"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v2_male^4", walk = false, loop = true },
	["dancar496"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v2_male^3", walk = false, loop = true },
	["dancar497"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v2_male^2", walk = false, loop = true },
	["dancar498"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v2_male^1", walk = false, loop = true },
	["dancar499"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_15_v1_female^1", walk = false, loop = true },
	["dancar500"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_11_v1_female^5", walk = false, loop = true },
	["dancar501"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_11_v1_female^4", walk = false, loop = true },
	["dancar502"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v1_male^6", walk = false, loop = true },
	["dancar503"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v1_male^5", walk = false, loop = true },
	["dancar504"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v1_male^4", walk = false, loop = true },
	["dancar505"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v1_male^3", walk = false, loop = true },
	["dancar506"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v1_male^2", walk = false, loop = true },
	["dancar507"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v1_male^1", walk = false, loop = true },
	["dancar508"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_13_v2_female^6", walk = false, loop = true },
	["dancar509"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_13_v2_female^5", walk = false, loop = true },
	["dancar510"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_15_v1_male^5", walk = false, loop = true },
	["dancar511"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_15_v1_male^3", walk = false, loop = true },
	["dancar512"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_15_v1_male^2", walk = false, loop = true },
	["dancar513"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_15_v1_male^1", walk = false, loop = true },
	["dancar514"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_17_v1_female^3", walk = false, loop = true },
	["dancar515"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_15_v1_male^4", walk = false, loop = true },
	["dancar516"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_17_v1_female^6", walk = false, loop = true },
	["dancar517"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_17_v1_female^5", walk = false, loop = true },
	["dancar518"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_17_v1_female^4", walk = false, loop = true },
	["dancar519"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_17_v1_female^2", walk = false, loop = true },
	["dancar520"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_17_v1_female^1", walk = false, loop = true },
	["dancar521"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_15_v1_male^6", walk = false, loop = true },
	["dancar522"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_09_v1_female^5", walk = false, loop = true },
	["dancar523"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_09_v1_female^4", walk = false, loop = true },
	["dancar524"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_09_v1_female^3", walk = false, loop = true },
	["dancar525"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_09_v1_female^2", walk = false, loop = true },
	["dancar526"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_17_v1_male^3", walk = false, loop = true },
	["dancar527"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_17_v1_male^2", walk = false, loop = true },
	["dancar528"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_17_v1_male^1", walk = false, loop = true },
	["dancar529"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_09_v1_female^6", walk = false, loop = true },
	["dancar530"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_09_v1_female^1", walk = false, loop = true },
	["dancar531"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v2_female^6", walk = false, loop = true },
	["dancar532"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_17_v1_male^6", walk = false, loop = true },
	["dancar533"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_17_v1_male^5", walk = false, loop = true },
	["dancar534"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_17_v1_male^4", walk = false, loop = true },
	["dancar535"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_15_v1_female^4", walk = false, loop = true },
	["dancar536"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_15_v1_female^3", walk = false, loop = true },
	["dancar537"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_15_v1_female^2", walk = false, loop = true },
	["dancar538"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_15_v1_female^1", walk = false, loop = true },
	["dancar539"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_15_v1_female^6", walk = false, loop = true },
	["dancar540"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_15_v1_female^5", walk = false, loop = true },
	["dancar541"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v1_male^6", walk = false, loop = true },
	["dancar542"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v1_male^5", walk = false, loop = true },
	["dancar543"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v1_male^4", walk = false, loop = true },
	["dancar544"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v1_male^2", walk = false, loop = true },
	["dancar545"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v1_male^1", walk = false, loop = true },
	["dancar546"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v1_male^3", walk = false, loop = true },
	["dancar547"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v2_female^4", walk = false, loop = true },
	["dancar548"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v2_female^3", walk = false, loop = true },
	["dancar549"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v2_female^2", walk = false, loop = true },
	["dancar550"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v2_female^1", walk = false, loop = true },
	["dancar551"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v2_female^6", walk = false, loop = true },
	["dancar552"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_13_v2_female^5", walk = false, loop = true },
	["dancar553"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_15_v1_male^6", walk = false, loop = true },
	["dancar554"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_15_v1_male^5", walk = false, loop = true },
	["dancar555"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_15_v1_male^4", walk = false, loop = true },
	["dancar556"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_15_v1_male^3", walk = false, loop = true },
	["dancar557"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_15_v1_male^2", walk = false, loop = true },
	["dancar558"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_15_v1_male^1", walk = false, loop = true },
	["dancar559"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_13_v1_male^6", walk = false, loop = true },
	["dancar560"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_13_v1_male^5", walk = false, loop = true },
	["dancar561"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_13_v1_male^4", walk = false, loop = true },
	["dancar562"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_13_v1_male^3", walk = false, loop = true },
	["dancar563"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_13_v1_male^2", walk = false, loop = true },
	["dancar564"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_13_v1_male^1", walk = false, loop = true },
	["dancar565"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_15_v1_female^3", walk = false, loop = true },
	["dancar566"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_15_v1_female^2", walk = false, loop = true },
	["dancar567"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_15_v1_female^1", walk = false, loop = true },
	["dancar568"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_15_v1_female^5", walk = false, loop = true },
	["dancar569"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_15_v1_female^4", walk = false, loop = true },
	["dancar570"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_09_v1_male^6", walk = false, loop = true },
	["dancar571"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_09_v1_male^5", walk = false, loop = true },
	["dancar572"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_09_v1_male^4", walk = false, loop = true },
	["dancar573"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_09_v1_male^3", walk = false, loop = true },
	["dancar574"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_09_v1_male^2", walk = false, loop = true },
	["dancar575"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_09_v1_male^1", walk = false, loop = true },
	["dancar576"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_15_v1_male^2", walk = false, loop = true },
	["dancar577"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_15_v1_male^1", walk = false, loop = true },
	["dancar578"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_11_v1_male^6", walk = false, loop = true },
	["dancar579"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_15_v1_male^6", walk = false, loop = true },
	["dancar580"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_15_v1_male^5", walk = false, loop = true },
	["dancar581"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_15_v1_male^4", walk = false, loop = true },
	["dancar582"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_15_v1_male^3", walk = false, loop = true },
	["dancar583"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_11_v1_male^3", walk = false, loop = true },
	["dancar584"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_11_v1_male^2", walk = false, loop = true },
	["dancar585"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_11_v1_male^1", walk = false, loop = true },
	["dancar586"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_11_v1_male^5", walk = false, loop = true },
	["dancar587"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_11_v1_male^4", walk = false, loop = true },
	["dancar588"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_11_v1_male^3", walk = false, loop = true },
	["dancar589"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_11_v1_male^2", walk = false, loop = true },
	["dancar590"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_11_v1_male^1", walk = false, loop = true },
	["dancar591"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_09_v1_female^6", walk = false, loop = true },
	["dancar592"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_17_v1_male^6", walk = false, loop = true },
	["dancar593"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_17_v1_male^5", walk = false, loop = true },
	["dancar594"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_17_v1_male^4", walk = false, loop = true },
	["dancar595"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"mi_dance_prop_17_v1_male^3", walk = false, loop = true },
	["dancar596"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_15_v1_female^6", walk = false, loop = true },
	["dancar597"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_09_v1_female^5", walk = false, loop = true },
	["dancar598"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_09_v1_female^4", walk = false, loop = true },
	["dancar599"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_09_v1_female^3", walk = false, loop = true },
	["dancar601"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_09_v1_female^2", walk = false, loop = true },
	["dancar602"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_09_v1_female^1", walk = false, loop = true },
	["dancar603"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_11_v1_female^6", walk = false, loop = true },
	["dancar604"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_11_v1_female^5", walk = false, loop = true },
	["dancar605"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_11_v1_female^4", walk = false, loop = true },
	["dancar606"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_11_v1_female^3", walk = false, loop = true },
	["dancar607"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_11_v1_female^2", walk = false, loop = true },
	["dancar608"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"hi_dance_prop_11_v1_female^1", walk = false, loop = true },
	["dancar609"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v2_female^4", walk = false, loop = true },
	["dancar610"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v2_female^3", walk = false, loop = true },
	["dancar611"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v2_female^5", walk = false, loop = true },
	["dancar612"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v2_female^2", walk = false, loop = true },
	["dancar613"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim =
	"li_dance_prop_13_v2_female^1", walk = false, loop = true },
	["dancar614"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_li_11_v1_female^6", walk = false, loop = true },
	["dancar615"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_09_v1_female^2", walk = false, loop = true },
	["dancar616"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_mi_11_v1_male^5", walk = false, loop = true },
	["dancar617"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_li_11_v1_male^3", walk = false, loop = true },
	["dancar618"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_11_v1_male^1", walk = false, loop = true },
	["dancar619"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_li_09_v1_female^1", walk = false, loop = true },
	["dancar620"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_11_v1_male^3", walk = false, loop = true },
	["dancar621"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_11_v1_female^6", walk = false, loop = true },
	["dancar622"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_li_09_v1_male^4", walk = false, loop = true },
	["dancar623"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_li_09_v1_female^5", walk = false, loop = true },
	["dancar624"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_mi_11_v1_female^3", walk = false, loop = true },
	["dancar625"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_09_v1_female^4", walk = false, loop = true },
	["dancar626"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_hi_07_v1_female^6", walk = false, loop = true },
	["dancar627"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_hi_07_v1_female^2", walk = false, loop = true },
	["dancar628"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_li_09_v1_female^3", walk = false, loop = true },
	["dancar629"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_11_v1_female^2", walk = false, loop = true },
	["dancar630"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_09_v1_male^4", walk = false, loop = true },
	["dancar631"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_li_09_v1_male^1", walk = false, loop = true },
	["dancar632"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_li_11_v1_male^5", walk = false, loop = true },
	["dancar633"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_li_11_v1_female^3", walk = false, loop = true },
	["dancar634"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_11_v1_female^1", walk = false, loop = true },
	["dancar635"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_li_09_v1_female^4", walk = false, loop = true },
	["dancar636"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_09_v1_male^5", walk = false, loop = true },
	["dancar637"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_09_v1_male^3", walk = false, loop = true },
	["dancar638"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_11_v1_male^5", walk = false, loop = true },
	["dancar639"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_li_11_v1_male^1", walk = false, loop = true },
	["dancar640"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_09_v1_female^6", walk = false, loop = true },
	["dancar641"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_hi_11_v1_male^2", walk = false, loop = true },
	["dancar642"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_mi_11_v1_female^4", walk = false, loop = true },
	["dancar643"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_li_09_v1_male^5", walk = false, loop = true },
	["dancar644"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_mi_11_v1_female^5", walk = false, loop = true },
	["dancar645"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_hi_11_v1_female^3", walk = false, loop = true },
	["dancar646"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_09_v1_male^6", walk = false, loop = true },
	["dancar647"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_li_09_v1_female^6", walk = false, loop = true },
	["dancar648"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_li_11_v1_male^2", walk = false, loop = true },
	["dancar649"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_hi_07_v1_female^5", walk = false, loop = true },
	["dancar650"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_hi_11_v1_male^4", walk = false, loop = true },
	["dancar651"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_li_11_v1_female^1", walk = false, loop = true },
	["dancar652"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_hi_11_v1_female^2", walk = false, loop = true },
	["dancar653"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_li_09_v1_female^2", walk = false, loop = true },
	["dancar654"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_mi_11_v1_male^2", walk = false, loop = true },
	["dancar655"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_09_v1_female^3", walk = false, loop = true },
	["dancar656"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_li_11_v1_female^2", walk = false, loop = true },
	["dancar657"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_hi_11_v1_female^5", walk = false, loop = true },
	["dancar658"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_hi_07_v1_female^1", walk = false, loop = true },
	["dancar659"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_09_v1_male^2", walk = false, loop = true },
	["dancar660"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_mi_11_v1_female^6", walk = false, loop = true },
	["dancar661"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_mi_11_v1_male^4", walk = false, loop = true },
	["dancar662"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_li_11_v1_female^4", walk = false, loop = true },
	["dancar663"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_11_v1_male^6", walk = false, loop = true },
	["dancar664"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_hi_07_v1_male^3", walk = false, loop = true },
	["dancar665"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_hi_11_v1_male^1", walk = false, loop = true },
	["dancar666"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_11_v1_female^5", walk = false, loop = true },
	["dancar667"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_li_09_v1_male^3", walk = false, loop = true },
	["dancar668"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_hi_07_v1_male^4", walk = false, loop = true },
	["dancar669"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_hi_11_v1_male^3", walk = false, loop = true },
	["dancar670"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_09_v1_female^1", walk = false, loop = true },
	["dancar671"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_hi_11_v1_male^6", walk = false, loop = true },
	["dancar672"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_hi_07_v1_female^4", walk = false, loop = true },
	["dancar673"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_hi_11_v1_male^5", walk = false, loop = true },
	["dancar674"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_mi_11_v1_female^1", walk = false, loop = true },
	["dancar675"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_09_v1_male^1", walk = false, loop = true },
	["dancar676"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_li_09_v1_male^6", walk = false, loop = true },
	["dancar677"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_hi_11_v1_female^4", walk = false, loop = true },
	["dancar678"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_mi_11_v1_male^3", walk = false, loop = true },
	["dancar679"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_hi_07_v1_male^1", walk = false, loop = true },
	["dancar680"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_11_v1_male^2", walk = false, loop = true },
	["dancar681"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_mi_11_v1_male^6", walk = false, loop = true },
	["dancar682"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_li_11_v1_male^4", walk = false, loop = true },
	["dancar683"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_09_v1_female^5", walk = false, loop = true },
	["dancar684"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_hi_07_v1_female^3", walk = false, loop = true },
	["dancar685"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_11_v1_female^3", walk = false, loop = true },
	["dancar686"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_hi_07_v1_male^5", walk = false, loop = true },
	["dancar687"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_11_v1_male^4", walk = false, loop = true },
	["dancar688"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_li_09_v1_male^2", walk = false, loop = true },
	["dancar689"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_mi_11_v1_female^2", walk = false, loop = true },
	["dancar690"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_li_11_v1_female^5", walk = false, loop = true },
	["dancar691"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_li_11_v1_male^6", walk = false, loop = true },
	["dancar692"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_hi_07_v1_male^6", walk = false, loop = true },
	["dancar693"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_li_to_hi_07_v1_male^2", walk = false, loop = true },
	["dancar694"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_hi_11_v1_female^6", walk = false, loop = true },
	["dancar695"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_mi_to_hi_11_v1_female^1", walk = false, loop = true },
	["dancar696"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim =
	"trans_dance_prop_hi_to_mi_11_v1_female^4", walk = false, loop = true },
	["argue"] = { dict = "misscarsteal4@actor", anim = "actor_berating_loop", walk = true, loop = true },
	["bird"] = { dict = "random@peyote@bird", anim = "wakeup", walk = true, loop = true },
	["blowkiss"] = { dict = "anim@mp_player_intcelebrationfemale@blow_kiss", anim = "blow_kiss", walk = true, loop = true },
	["bringiton"] = { dict = "misscommon@response", anim = "bring_it_on", walk = true, loop = false },
	["chill"] = { dict = "switch@trevor@scares_tramp", anim = "trev_scares_tramp_idle_tramp", walk = false, loop = true },
	["clapangry"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "angry_clap_a_player_a", walk = true, loop = true },
	["comeatmebro"] = { dict = "mini@triathlon", anim = "want_some_of_this", walk = true, loop = true },
	["crawl"] = { dict = "move_injured_ground", anim = "front_loop", walk = false, loop = true },
	["flip"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "cap_a_player_a", walk = false, loop = false },
	["flip2"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "flip_a_player_a", walk = false, loop = false },
	["meditate"] = { dict = "rcmcollect_paperleadinout@", anim = "meditiate_idle", walk = false, loop = true },
	["peace2"] = { dict = "anim@mp_player_intupperpeace", anim = "idle_a", walk = true, loop = true },
	["prone"] = { dict = "missfbi3_sniping", anim = "prone_dave", walk = false, loop = true },
	["inspect"] = { dict = "random@train_tracks", anim = "idle_e", walk = false, loop = false },
	["sitchair"] = { dict = "timetable@ron@ig_5_p3", anim = "ig_5_p3_base", walk = false, loop = true },
	["sitchair2"] = { dict = "timetable@reunited@ig_10", anim = "base_amanda", walk = false, loop = true },
	["sitchair3"] = { dict = "timetable@ron@ig_3_couch", anim = "base", walk = false, loop = true },
	["sitchair4"] = { dict = "timetable@jimmy@mics3_ig_15@", anim = "mics3_15_base_tracy", walk = false, loop = true },
	["sitchair5"] = { dict = "timetable@maid@couch@", anim = "base", walk = false, loop = true },
	["sitchair6"] = { dict = "timetable@reunited@ig_10", anim = "isthisthebest_jimmy", walk = false, loop = true },
	["sitchair7"] = { dict = "timetable@michael@on_sofabase", anim = "sit_sofa_base", walk = false, loop = true },
	["sitchair8"] = { dict = "timetable@trevor@smoking_meth@base", anim = "base", walk = false, loop = true },
	["sitchair9"] = { dict = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle", walk = false, loop = true },
	["superhero"] = { dict = "rcmbarry", anim = "base", walk = true, loop = true },
	["type"] = { dict = "anim@heists@prison_heiststation@cop_reactions", anim = "cop_b_idle", walk = true, loop = true },
	["yeah"] = { dict = "anim@mp_player_intupperair_shagging", anim = "idle_a", walk = true, loop = true },
	["sexo"] = { dict = "rcmpaparazzo_2", anim = "shag_loop_poppy", walk = false, loop = true },
	["sexo2"] = { dict = "rcmpaparazzo_2", anim = "shag_loop_a", walk = false, loop = true },
	["sexo3"] = { dict = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging", walk = false, loop = true },
	["sexo4"] = { dict = "oddjobs@towing", anim = "m_blow_job_loop", walk = false, loop = true, cars = true },
	["sexo5"] = { dict = "oddjobs@towing", anim = "f_blow_job_loop", walk = false, loop = true, cars = true },
	["sexo6"] = { dict = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female", walk = false, loop = true, cars = true },
	["sexo7"] = { dict = "timetable@trevor@skull_loving_bear", anim = "skull_loving_bear", walk = false, loop = true },
	["dildo"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "prop_cs_dildo_01", flag = 49, mao = 28422 },
	["dildo2"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "v_res_d_dildo_f", flag = 49, mao = 28422 },
	["dildo3"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "v_res_d_dildo_b", flag = 49, mao = 28422 },
	["dildo4"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "v_res_d_dildo_c", flag = 49, mao = 28422 },
	["dildo5"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "v_res_d_dildo_a", flag = 49, mao = 28422 },
	["sentar"] = { dict = "amb@world_human_picnic@male@base", anim = "base", walk = false, loop = true },
	["sentar2"] = { dict = "sol_3_int-9", anim = "cs_molly_dual-9", walk = false, loop = true },
	["sentar3"] = { dict = "anim@heists@fleeca_bank@ig_7_jetski_owner", anim = "owner_idle", walk = false, loop = true },
	["sentar4"] = { dict = "amb@world_human_stupor@male@base", anim = "base", walk = false, loop = true },
	["sentar5"] = { dict = "amb@world_human_picnic@female@base", anim = "base", walk = false, loop = true },
	["sentar6"] = { dict = "anim@amb@nightclub@lazlow@lo_alone@", anim = "lowalone_base_laz", walk = false, loop = true },
	["sentar7"] = { dict = "anim@amb@business@bgen@bgen_no_work@", anim = "sit_phone_phoneputdown_idle_nowork", walk = false, loop = true },
	["sentar8"] = { dict = "rcm_barry3", anim = "barry_3_sit_loop", walk = false, loop = true },
	["sentar9"] = { dict = "amb@world_human_picnic@male@idle_a", anim = "idle_a", walk = false, loop = true },
	["sentar10"] = { dict = "amb@world_human_picnic@female@idle_a", anim = "idle_a", walk = false, loop = true },
	["sentar11"] = { dict = "timetable@jimmy@mics3_ig_15@", anim = "idle_a_jimmy", walk = false, loop = true },
	["sentar12"] = { dict = "timetable@jimmy@mics3_ig_15@", anim = "mics3_15_base_jimmy", walk = false, loop = true },
	["sentar13"] = { dict = "amb@world_human_stupor@male@idle_a", anim = "idle_a", walk = false, loop = true },
	["sentar14"] = { dict = "timetable@tracy@ig_14@", anim = "ig_14_base_tracy", walk = false, loop = true },
	["sentar15"] = { dict = "anim@heists@ornate_bank@hostages@hit", anim = "hit_loop_ped_b", walk = false, loop = true },
	["sentar16"] = { dict = "anim@heists@ornate_bank@hostages@ped_e@", anim = "flinch_loop", walk = false, loop = true },
	["sentar17"] = { dict = "timetable@ron@ig_5_p3", anim = "ig_5_p3_base", walk = false, loop = true },
	["sentar18"] = { dict = "timetable@reunited@ig_10", anim = "base_amanda", walk = false, loop = true },
	["sentar19"] = { dict = "timetable@ron@ig_3_couch", anim = "base", walk = false, loop = true },
	["sentar20"] = { dict = "timetable@jimmy@mics3_ig_15@", anim = "mics3_15_base_tracy", walk = false, loop = true },
	["sentar21"] = { dict = "timetable@maid@couch@", anim = "base", walk = false, loop = true },
	["sentar22"] = { dict = "timetable@ron@ron_ig_2_alt1", anim = "ig_2_alt1_base", walk = false, loop = true },
	["sentar23"] = { dict = "timetable@reunited@ig_10", anim = "shouldntyouguys_jimmy", walk = false, loop = true },
	["sentar24"] = { dict = "timetable@tracy@ig_2@base", anim = "base", walk = false, loop = true },
	["sentar25"] = { dict = "anim@amb@office@boss@female@", anim = "base", walk = false, loop = true },
	["sentar26"] = { dict = "anim@amb@casino@out_of_money@ped_female@01a@base", anim = "base", walk = false, loop = true },
	["sentar27"] = { dict = "anim@amb@casino@out_of_money@ped_female@01b@base", anim = "base", walk = false, loop = true },
	["sentar28"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01a@base", anim = "base", walk = false, loop = true },
	["sentar29"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@01b@base", anim = "base", walk = false, loop = true },
	["sentar30"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@02a@base", anim = "base", walk = false, loop = true },
	["sentar31"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@02b@base", anim = "base", walk = false, loop = true },
	["sentar32"] = { dict = "anim_casino_a@amb@casino@games@slots@ped_female@regular@02a@base", anim = "base", walk = false, loop = true },
	["sentar33"] = { dict = "anim_casino_b@amb@casino@games@blackjack@ped_male@engaged@01a@base", anim = "base", walk = false, loop = true },
	["sentar34"] = { dict = "misslester1aig_3main", anim = "air_guitar_01_a", walk = false, loop = true },
	["sentar35"] = { dict = "missheistdocks2aleadinoutlsdh_2a_int", anim = "sitting_loop_wade", walk = false, loop = true },
	["sentar36"] = { dict = "switch@franklin@stripclub2", anim = "ig_16_base", walk = false, loop = true },
	["sentar37"] = { dict = "switch@michael@restaurant", anim = "001510_02_gc_mics3_ig_1_base_amanda", walk = false, loop = true },
	["sentar38"] = { dict = "switch@michael@ronex_ig_5_p2", anim = "base_michael", walk = false, loop = true },
	["sentar39"] = { dict = "timetable@amanda@facemask@base", anim = "base", walk = false, loop = true },
	["sentar40"] = { dict = "timetable@reunited@ig_7", anim = "amandabase_amanda", walk = false, loop = true },
	["sentar41"] = { dict = "drf_mic_1_cs_1-15", anim = "cs_drfriedlander_dual-15", walk = false, loop = true },
	["sentar42"] = { dict = "mini@strip_club@backroom@", anim = "leadin_loop_idle_c_stripper_c", walk = false, loop = true },
	["sentar43"] = { dict = "timetable@trevor@smoking_meth@base", anim = "base", walk = false, loop = true },
	["sentar44"] = { dict = "switch@michael@sitting_on_car_premiere", anim = "sitting_on_car_premiere_loop_player", walk = false, loop = true },
	["sentar45"] = { dict = "mp_am_stripper", anim = "lap_dance_player", walk = false, loop = true },
	["sentar46"] = { dict = "switch@michael@opens_door_for_ama", anim = "001895_02_mics3_17_opens_door_for_ama_idle_ama", walk = false, loop = true },
	["sentar47"] = { dict = "switch@michael@lounge_chairs", anim = "001523_01_mics3_9_lounge_chairs_idle_mic", walk = false, loop = true },
	["sentar48"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01a@base_big_screen", anim =
	"base_big_screen", walk = false, loop = true },
	["sentar49"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01b@base", anim = "base", walk = false, loop = true },
	["sentar50"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01b@base_big_screen", anim =
	"base_big_screen", walk = false, loop = true },
	["sentar51"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@regular@01a@base", anim = "base", walk = false, loop = true },
	["sentar52"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@regular@01b@base_big_screen", anim =
	"base_big_screen", walk = false, loop = true },
	["sentar53"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@02a@trans", anim =
	"base_to_big_screen", walk = false, loop = true },
	["sentar54"] = { dict = "switch@michael@parkbench_smoke_ranger", anim = "parkbench_smoke_ranger_loop", walk = false, loop = true },
	["sentar55"] = { dict = "missheist_jewelleadinout", anim = "jh_int_outro_loop_d", walk = false, loop = true },
	["sentar56"] = { dict = "anim@amb@business@cfm@cfm_machine_no_work@", anim = "smokers_cough_v1_operator", walk = false, loop = true },
	["sentar57"] = { dict = "rcmnigel1a_band_groupies", anim = "bump_f1", walk = false, loop = true },
	["sentar58"] = { dict = "anim@amb@nightclub@smoking@", anim = "base", walk = false, loop = true },
	["sentar59"] = { dict = "amb@lo_res_idles@", anim = "world_human_picnic_female_lo_res_base", walk = false, loop = true },
	["sentar60"] = { dict = "missheistdocks2aleadinoutlsdh_2a_int", anim = "massage_loop_2_trevor", walk = false, loop = true },
	["sentar61"] = { dict = "anim_casino_b@amb@casino@games@blackjack@ped_female@no_heels@regular@02a@reacts@v01", anim =
	"reaction_impartial_var03", walk = false, loop = true },
	["sentar62"] = { dict = "anim@amb@clubhouse@boss@female@", anim = "base", walk = false, loop = true },
	["sentar63"] = { dict = "timetable@denice@ig_4", anim = "base", walk = false, loop = true },
	["sentar64"] = { dict = "sil_int-29", anim = "mp_m_freemode_01^3_dual-29", walk = false, loop = true },
	["sentar65"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_r@", anim = "base", walk = false, loop = true },
	["sentar66"] = { dict = "safe@michael@ig_3", anim = "base_michael", walk = false, loop = true },
	["sentar67"] = { dict = "rcmnigel1a_band_groupies", anim = "base_m1", walk = false, loop = true },
	["sentar68"] = { dict = "anim@heists@fleeca_bank@hostages@intro", anim = "intro_loop_ped_a", walk = false, loop = true },
	["sentar69"] = { dict = "switch@michael@ronex_ig_5_p2", anim = "base_michael", walk = false, loop = true },
	["sentar70"] = { dict = "timetable@reunited@ig_10", anim = "shouldntyouguys_amanda", walk = false, loop = true },
	["sentar71"] = { dict = "bs_1_int-9", anim = "player_one_dual-9", walk = false, loop = true },
	["sentar72"] = { dict = "anim@amb@office@seating@female@var_b@base@", anim = "base", walk = false, loop = true },
	["sentar73"] = { dict = "rcmnigel1a_band_groupies", anim = "bump_f1", walk = false, loop = true },
	["sentar74"] = { dict = "anim@amb@facility@briefing_room@seating@male@var_a@", anim = "base", walk = false, loop = true },
	["sentar75"] = { dict = "anim@amb@business@cfid@cfid_desk_no_work_bgen_chair_no_work@", anim =
	"lookaround_phoneless_lazyworker", walk = false, loop = true },
	["sentar76"] = { dict = "arm_1_mcs_2_concat-0", anim = "cs_denise_dual-0", walk = false, loop = true },
	["sentar77"] = { dict = "timetable@reunited@ig_7", anim = "amandabase_amanda", walk = false, loop = true },
	["sentar78"] = { dict = "anim@amb@yacht@jacuzzi@seated@female@variation_05@", anim = "idle_a", walk = false, loop = true },
	["sentar79"] = { dict = "family_4_mcs_2-2", anim = "csb_hugh_dual-2", walk = false, loop = true },
	["sentar80"] = { dict = "anim@amb@office@boardroom@crew@female@var_a@base_r@", anim = "base", walk = false, loop = true },
	["sentar81"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@regular@01a@base", anim = "base", walk = false, loop = true },
	["sentar82"] = { dict = "missheistdocks2aleadinoutlsdh_2a_int", anim = "massage_loop_2_trevor", walk = false, loop = true },
	["sentar83"] = { dict = "timetable@amanda@ig_7", anim = "base", walk = false, loop = true },
	["sentar84"] = { dict = "hs3_pln_int-0", anim = "csb_huang_dual-0", walk = false, loop = true },
	["sentar85"] = { dict = "amb@incar@male@smoking_van@enter", anim = "enter", walk = false, loop = true },
	["sentar86"] = { dict = "mp_safehouselost_table@", anim = "lost_table_idle_a", walk = false, loop = true },
	["sentar87"] = { dict = "timetable@ron@ron_ig_2_alt1", anim = "ig_2_alt1_base", walk = false, loop = true },
	["sentar88"] = { dict = "anim@amb@office@boss@female@", anim = "base", walk = false, loop = true },
	["sentar89"] = { dict = "rcmnigel1aig_1", anim = "you_know_girl", walk = false, loop = true },
	["sentar90"] = { dict = "anim@amb@clubhouse@boardroom@boss@female@base_r@", anim = "base", walk = false, loop = true },
	["sentar91"] = { dict = "anim@amb@facility@briefing_room@seating@female@var_b@", anim = "base", walk = false, loop = true },
	["sentar92"] = { dict = "switch@michael@ronex_ig_5_p2", anim = "base_michael", walk = false, loop = true },
	["sentar93"] = { dict = "switch@franklin@stripclub3", anim = "ig_17_base", walk = false, loop = true },
	["sentar94"] = { dict = "safe@franklin@ig_14", anim = "base", walk = false, loop = true },
	["sentar95"] = { dict = "rcmnigel1bnmt_1b", anim = "base_girl", walk = false, loop = true },
	["sentar96"] = { dict = "anim@amb@business@cfm@cfm_machine_no_work@", anim = "hanging_out_operator", walk = false, loop = true },
	["sentar97"] = { dict = "timetable@reunited@ig_10", anim = "shouldntyouguys_tracy", walk = false, loop = true },
	["sentar98"] = { dict = "missfbi3_party", anim = "snort_coke_b_male5", walk = false, loop = true },
	["sentar99"] = { dict = "missheistpaletoscoresetupleadin", anim = "rbhs_mcs_1_leadin", walk = false, loop = true },
	["sentar100"] = { dict = "misslester1aig_3exit", anim = "air_guitar_01_exitloop_d", walk = false, loop = true },
	["sentar101"] = { dict = "misslester1aig_3main", anim = "air_guitar_01_b", walk = false, loop = true },
	["sentar102"] = { dict = "misslester1aig_5intro", anim = "boardroom_intro_f_c", walk = false, loop = true },
	["sentar103"] = { dict = "misslester1b_crowd@m_", anim = "001082_01_m_a", walk = false, loop = true },
	["sentar104"] = { dict = "mp_am_stripper", anim = "lap_dance_player", walk = false, loop = true },
	["sentar105"] = { dict = "safe@franklin@ig_14", anim = "base", walk = false, loop = true },
	["sentar106"] = { dict = "switch@trevor@mocks_lapdance", anim = "001443_01_trvs_28_idle_man", walk = false, loop = true },
	["sentar107"] = { dict = "switch@trevor@rude_at_cafe", anim = "001218_03_trvs_23_rude_at_cafe_idle_female", walk = false, loop = true },
	["sentar108"] = { dict = "amb@world_human_seat_steps@female@hands_by_sides@base", anim = "base", walk = false, loop = true },
	["sentar109"] = { dict = "amb@world_human_seat_wall@female@hands_by_sides@base", anim = "base", walk = false, loop = true },
	["sentar110"] = { dict = "timetable@trevor@trv_ig_2", anim = "base_trevor", walk = false, loop = true },
	["sentar111"] = { dict = "missdrfriedlanderdrf_idles", anim = "drf_idle_drf", walk = false, loop = true },
	["sentar112"] = { dict = "anim@amb@clubhouse@boss@female@", anim = "base", walk = false, loop = true },
	["sentar113"] = { dict = "anim@amb@clubhouse@boardroom@crew@male@var_b@base_r@", anim = "base", walk = false, loop = true },
	["sentar114"] = { dict = "anim@amb@office@seating@female@var_b@base@", anim = "base", walk = false, loop = true },
	["sentar115"] = { dict = "anim@amb@office@seating@female@var_c@base@", anim = "base", walk = false, loop = true },
	["sentar116"] = { dict = "amb@world_human_seat_steps@male@elbows_on_knees@base", anim = "base", walk = false, loop = true },
	["sentar117"] = { dict = "anim@amb@facility@briefing_room@seating@male@var_a@", anim = "base", walk = false, loop = true },
	["sentar118"] = { dict = "anim@amb@clubhouse@boardroom@boss@female@base_r@", anim = "base", walk = false, loop = true },
	["sentar119"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_r@", anim = "base", walk = false, loop = true },
	["sentar120"] = { dict = "iaaj_ext-27", anim = "csb_mp_agent14_dual-27", walk = false, loop = true },
	["sentar121"] = { dict = "anim@amb@facility@briefing_room@seating@male@var_b@", anim = "base", walk = false, loop = true },
	["sentar122"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_l@", anim = "base", walk = false, loop = true },
	["sentar123"] = { dict = "missfam2_bikehire@", anim = "base", walk = false, loop = true },
	["sentar124"] = { dict = "missarmenian2", anim = "car_react_gang_ps", walk = false, loop = true },
	["sentar125"] = { dict = "anim@amb@office@boardroom@boss@male@", anim = "base", walk = false, loop = true },
	["sentar126"] = { dict = "anim@amb@office@seating@female@var_a@base@", anim = "base", walk = false, loop = true },
	["sentar127"] = { dict = "anim@amb@office@seating@male@var_b@base@", anim = "base", walk = false, loop = true },
	["sentar128"] = { dict = "anim@amb@office@seating@male@var_e@base@", anim = "base", walk = false, loop = true },
	["sentar129"] = { dict = "anim@amb@office@boardroom@crew@male@var_b@base_r@", anim = "base", walk = false, loop = true },
	["sentar130"] = { dict = "sub_int-38", anim = "mp_m_freemode_01^1_dual-38", walk = false, loop = true },
	["sentar131"] = { dict = "sil_int-28", anim = "mp_m_freemode_01_dual-28", walk = false, loop = true },
	["sentar132"] = { dict = "drf_mic_1_cs_1-15", anim = "cs_drfriedlander_dual-15", walk = false, loop = true },
	["sentar133"] = { dict = "drf_mic_1_cs_1-24", anim = "cs_drfriedlander_dual-24", walk = false, loop = true },
	["sentar134"] = { dict = "drf_mic_1_cs_1-30", anim = "cs_drfriedlander_dual-30", walk = false, loop = true },
	["sentar135"] = { dict = "amb@lo_res_idles@", anim = "prop_human_deckchair_female_lo_res_base", walk = false, loop = true },
	["sentar136"] = { dict = "anim@amb@office@boardroom@boss@male@", anim = "base", walk = false, loop = true },
	["sentar137"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base@", anim = "base", walk = false, loop = true },
	["sentar138"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_l@", anim = "base", walk = false, loop = true },
	["sentar139"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_r@", anim = "base", walk = false, loop = true },
	["sentar140"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_b@base@", anim = "base", walk = false, loop = true },
	["sentar141"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_b@base_r@", anim = "base", walk = false, loop = true },
	["sentar142"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_c@base@", anim = "base", walk = false, loop = true },
	["sentar143"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_c@base_l@", anim = "base", walk = false, loop = true },
	["sentar144"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_c@base_r@", anim = "base", walk = false, loop = true },
	["sentar145"] = { dict = "anim@amb@clubhouse@boardroom@crew@male@var_a@base@", anim = "base", walk = false, loop = true },
	["sentar146"] = { dict = "anim@amb@clubhouse@boardroom@crew@male@var_a@base_l@", anim = "base", walk = false, loop = true },
	["sentar147"] = { dict = "anim@amb@clubhouse@boardroom@crew@male@var_a@base_r@", anim = "base", walk = false, loop = true },
	["sentar148"] = { dict = "anim@amb@clubhouse@boardroom@crew@male@var_b@base@", anim = "base", walk = false, loop = true },
	["sentar149"] = { dict = "anim@amb@clubhouse@boardroom@crew@male@var_c@base@", anim = "base", walk = false, loop = true },
	["foto"] = { dict = "amb@lo_res_idles@", anim = "world_human_lean_male_hands_together_lo_res_base", walk = false, loop = true },
	["foto1"] = { dict = "amb@code_human_cross_road@female@base", anim = "base", walk = false, loop = true },
	["foto2"] = { dict = "amb@code_human_in_car_mp_actions@tit_squeeze@bodhi@rps@base", anim = "idle_a", walk = false, loop = true },
	["foto3"] = { dict = "amb@world_human_hang_out_street@female_arm_side@enter", anim = "enter", walk = false, loop = true },
	["foto4"] = { dict = "amb@world_human_hang_out_street@female_arm_side@idle_a", anim = "idle_b", walk = false, loop = true },
	["foto5"] = { dict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a", anim = "idle_b", walk = false, loop = true },
	["foto6"] = { dict = "friends@", anim = "pickupwait", walk = false, loop = true },
	["foto7"] = { dict = "mini@hookers_sp", anim = "idle_reject_loop_a", walk = false, loop = true },
	["foto8"] = { dict = "misscarsteal2", anim = "sweep_high", walk = false, loop = true },
	["foto9"] = { dict = "missheist_agency3aig_23", anim = "urinal_base", walk = false, loop = true },
	["foto10"] = { dict = "misstrevor2ron_basic_moves", anim = "idle", walk = false, loop = true },
	["foto11"] = { dict = "oddjobs@basejump@", anim = "ped_a_loop", walk = false, loop = true },
	["foto12"] = { dict = "rcmjosh1", anim = "idle", walk = false, loop = true },
	["foto13"] = { dict = "switch@franklin@plays_w_dog", anim = "001916_01_fras_v2_9_plays_w_dog_idle", walk = false, loop = true },
	["foto14"] = { dict = "timetable@amanda@ig_9", anim = "ig_9_base_amanda", walk = false, loop = true },
	["foto15"] = { dict = "misscommon@response", anim = "bring_it_on", walk = false, loop = true },
	["foto16"] = { dict = "cover@first_person@move@base@core", anim = "low_idle_l_facecover", walk = false, loop = true },
	["foto17"] = { dict = "cover@weapon@core", anim = "idle_turn_stop", walk = false, loop = true },
	["foto18"] = { dict = "anim@amb@casino@hangout@ped_female@stand@02b@base", anim = "base", walk = false, loop = true },
	["foto19"] = { dict = "anim@amb@casino@hangout@ped_male@stand@01a@base", anim = "base", walk = false, loop = true },
	["foto20"] = { dict = "anim@amb@casino@out_of_money@ped_male@01b@base", anim = "base", walk = false, loop = true },
	["foto21"] = { dict = "anim@amb@casino@shop@ped_female@01a@base", anim = "base", walk = false, loop = true },
	["foto22"] = { dict = "anim@mp_corona_idles@female_c@base", anim = "base", walk = false, loop = true },
	["foto23"] = { dict = "anim@random@shop_clothes@watches", anim = "base", walk = false, loop = true },
	["foto24"] = { dict = "iaa_int-11", anim = "csb_avon_dual-11", walk = false, loop = true },
	["foto25"] = { dict = "mini@strip_club@lap_dance@ld_girl_a_approach", anim = "ld_girl_a_approach_f", walk = false, loop = true },
	["foto26"] = { dict = "amb@code_human_in_car_mp_actions@rock@bodhi@rps@base", anim = "idle_a", walk = false, loop = true },
	["foto27"] = { dict = "mini@hookers_spcrackhead", anim = "idle_reject_loop_c", walk = false, loop = true },
	["foto28"] = { dict = "anim@mp_player_intupperfinger", anim = "idle_a", walk = false, loop = true },
	["foto29"] = { dict = "switch@franklin@lamar_tagging_wall", anim = "lamar_tagging_wall_loop_franklin", walk = false, loop = true },
	["foto30"] = { dict = "mp_move@prostitute@m@cokehead", anim = "idle", walk = false, loop = true },
	["foto31"] = { dict = "anim@amb@casino@valet_scenario@pose_c@", anim = "base_a_m_y_vinewood_01", walk = false, loop = true },
	["foto32"] = { dict = "anim@amb@casino@valet_scenario@pose_d@", anim = "look_ahead_l_a_m_y_vinewood_01", walk = false, loop = true },
	["foto33"] = { dict = "anim@special_peds@casino@beth@wheel@", anim = "action10_beth", walk = false, loop = true },
	["foto34"] = { dict = "anim@special_peds@casino@beth@wheel@", anim = "action2_beth", walk = false, loop = true },
	["foto35"] = { dict = "anim@mp_player_intcelebrationfemale@v_sign", anim = "v_sign", walk = false, loop = true },
	["foto36"] = { dict = "mini@strip_club@idles@stripper", anim = "stripper_idle_03", walk = false, loop = true },
	["foto37"] = { dict = "mini@strip_club@idles@stripper", anim = "stripper_idle_04", walk = false, loop = true },
	["foto38"] = { dict = "anim_heist@arcade@fortune@female@", anim = "reaction_pondering", walk = false, loop = true },
	["foto39"] = { dict = "anim@mp_player_intcelebrationfemale@peace", anim = "peace", walk = false, loop = true },
	["foto40"] = { dict = "missfbi3_party_d", anim = "stand_talk_loop_b_female", walk = false, loop = true },
	["foto41"] = { dict = "armenian_1_int-44", anim = "a_m_y_musclbeac_01^1_dual-44", walk = false, loop = true },
	["foto42"] = { dict = "mp_clothing@female@trousers", anim = "try_trousers_positive_a", walk = false, loop = true },
	["foto43"] = { dict = "silj_ext-19", anim = "mp_m_freemode_01^3_dual-19", walk = false, loop = true },
	["foto44"] = { dict = "sdrm_mcs_2-0", anim = "ig_bestmen^1-0", walk = false, loop = true },
	["foto45"] = { dict = "anim_heist@arcade_combined@", anim = "ped_female@_stand@_02a@_idles_convo_idle_c", walk = false, loop = true },
	["foto46"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "thumbs_down_a_player_a", walk = false, loop = true },
	["foto47"] = { dict = "guard_reactions", anim = "1hand_aiming_cycle", walk = false, loop = true },
	["foto48"] = { dict = "armenian_1_int-3", anim = "a_f_y_fitness_02^5-3", walk = false, loop = true },
	["foto49"] = { dict = "anim_heist@arcade_combined@", anim = "ped_female@_stand_withdrink@_01b@_base_base", walk = false, loop = true },
	["foto50"] = { dict = "amb@lo_res_idles@", anim = "world_human_security_shine_torch_lo_res_base", walk = false, loop = true },
	["foto51"] = { dict = "rcmjosh2", anim = "stand_lean_back_beckon_a", walk = false, loop = true },
	["foto52"] = { dict = "rcmjosh2", anim = "stand_lean_back_beckon_b", walk = false, loop = true },
	["foto53"] = { dict = "pro_mcs_7_concat-1", anim = "cs_priest_dual-1", walk = false, loop = true },
	["foto54"] = { dict = "clothingshirt", anim = "try_shirt_base", walk = false, loop = true },
	["foto55"] = { dict = "special_ped@pamela@trevor_1@trevor_1a", anim =
	"pamela_convo_trevor_im_trying_to_get_noticed_0", walk = false, loop = true },
	["foto56"] = { dict = "special_ped@impotent_rage@intro", anim = "idle_intro", walk = false, loop = true },
	["foto57"] = { dict = "random@escape_paparazzi@standing@", anim = "idle", walk = false, loop = true },
	["foto58"] = { dict = "pro_mcs_7_concat-8", anim = "player_two_dual-8", walk = false, loop = true },
	["foto59"] = { dict = "anim@heists@ornate_bank@thermal_charge", anim = "cover_eyes_loop", walk = false, loop = true },
	["foto60"] = { dict = "low_fun_int-7", anim = "cs_lamardavis_dual-7", walk = false, loop = true },
	["foto61"] = { dict = "tale_intro-12", anim = "a_f_y_genhot_01^2_dual-12", walk = false, loop = true },
	["foto62"] = { dict = "amb@code_human_police_investigate@base", anim = "base", walk = false, loop = true },
	["foto63"] = { dict = "anim@mp_player_intincarpeacebodhi@ds@", anim = "enter", walk = false, loop = true },
	["foto64"] = { dict = "anim@mp_corona_idles@female_c@idle_a", anim = "idle_a", walk = false, loop = true },
	["foto65"] = { dict = "anim@miss@low@fin@vagos@", anim = "idle_ped07", walk = false, loop = true },
	["foto66"] = { dict = "oddjobs@assassinate@multi@", anim = "idle_a_pros", walk = false, loop = true },
	["foto67"] = { dict = "timetable@jimmy@ig_5@base", anim = "base", walk = false, loop = true },
	["foto68"] = { dict = "rcmnigel1bnmt_1b", anim = "base_tyler", walk = false, loop = true },
	["foto69"] = { dict = "mp_fm_intro_cut", anim = "world_human_standing_male_01_idle_03", walk = false, loop = true },
	["foto70"] = { dict = "mic_4_int-0", anim = "a_f_y_bevhills_04-0", walk = false, loop = true },
	["foto71"] = { dict = "mic_4_int-0", anim = "cs_milton_dual-0", walk = false, loop = true },
	["foto72"] = { dict = "cellphone@self@franklin@", anim = "west_coast", walk = false, loop = true },
	["foto73"] = { dict = "anim@random@shop_clothes@watches", anim = "idle_d", walk = false, loop = true },
	["foto74"] = { dict = "amb@world_human_muscle_flex@arms_in_front@idle_a", anim = "idle_b", walk = false, loop = true },
	["foto75"] = { dict = "amb@world_human_prostitute@crackhooker@idle_a", anim = "idle_c", walk = false, loop = true },
	["foto76"] = { dict = "amb@world_human_prostitute@hooker@base", anim = "base", walk = false, loop = true },
	["foto77"] = { dict = "armenian_1_int-33", anim = "ig_lamardavis_dual-33", walk = false, loop = true },
	["foto78"] = { dict = "anim@mp_player_intcelebrationmale@blow_kiss", anim = "blow_kiss", walk = false, loop = true },
	["foto79"] = { dict = "anim@mp_player_intcelebrationmale@knuckle_crunch", anim = "knuckle_crunch", walk = false, loop = true },
	["foto80"] = { dict = "anim@mp_player_intupperthumbs_up", anim = "idle_a_fp", walk = false, loop = true },
	["foto81"] = { dict = "switch@michael@prostitute", anim = "exit_hooker", walk = false, loop = true },
	["foto82"] = { dict = "mp_player_int_upperbro_love", anim = "mp_player_int_bro_love_fp", walk = false, loop = true },
	["foto83"] = { dict = "hs3_arc_int-9", anim = "csb_georginacheng_dual-9", walk = false, loop = true },
	["foto84"] = { dict = "armenian_1_int-0", anim = "a_f_y_beach_01_dual-0", walk = false, loop = true },
	["foto85"] = { dict = "armenian_1_int-0", anim = "a_f_y_hipster_02^2-0", walk = false, loop = true },
	["foto86"] = { dict = "armenian_1_int-0", anim = "a_f_y_tourist_01^2-0", walk = false, loop = true },
	["foto87"] = { dict = "armenian_1_int-0", anim = "a_m_y_beach_03-0", walk = false, loop = true },
	["foto88"] = { dict = "special_ped@pamela@base", anim = "base", walk = false, loop = true },
	["foto89"] = { dict = "mp_fm_intro_cut", anim = "world_human_standing_male_01_idle_01", walk = false, loop = true },
	["foto90"] = { dict = "amb@world_human_leaning@female@smoke@base", anim = "base", walk = false, loop = true },
	["foto91"] = { dict = "amb@world_human_leaning@female@wall@back@hand_up@base", anim = "base", walk = false, loop = true },
	["foto92"] = { dict = "amb@code_human_cross_road@female@base", anim = "base", walk = false, loop = true },
	["foto93"] = { dict = "anim@heists@heist_corona@single_team", anim = "single_team_intro_boss", walk = false, loop = true },
	["foto94"] = { dict = "amb@incar@male@smoking@idle_a", anim = "idle_b", walk = false, loop = true },
	["foto95"] = { anim = "idle_a", dict = "anim@amb@casino@hangout@ped_male@stand@02b@idles", walk = false, loop = true },
	["foto96"] = { anim = "rub_neck_a_m_y_vinewood_01", dict = "anim@amb@casino@valet_scenario@pose_c@", walk = false, loop = true },
	["foto97"] = { dict = "anim@mp_player_intuppershush", anim = "idle_a_fp", walk = false, loop = true },
	["foto98"] = { anim = "_car_a_flirt_girl", dict = "random@street_race", walk = false, loop = true },
	["foto99"] = { dict = "misshair_shop@barbers", anim = "keeper_base", walk = false, loop = true },
	["foto100"] = { dict = "cellphone@self@franklin@", anim = "chest_bump", walk = false, loop = true },
	["foto101"] = { dict = "amb@world_human_leaning@male@wall@back@foot_up@aggro_react", anim =
	"aggro_react_forward_enter", walk = false, loop = true },
	["foto102"] = { dict = "martin_1_int-0", anim = "cs_patricia_dual-0", walk = false, loop = true },
	["foto103"] = { dict = "mini@strip_club@lap_dance_2g@ld_2g_decline", anim = "ld_2g_decline_h_s2", walk = false, loop = true },
	["foto104"] = { anim = "stripper_idle_03", dict = "mini@strip_club@idles@stripper", walk = false, loop = true },
	["foto105"] = { dict = "amb@world_human_binoculars@male@base", anim = "base", walk = false, loop = true },
	["foto106"] = { dict = "amb@world_human_tourist_mobile@male@base", anim = "base", walk = false, loop = true },
	["foto107"] = { dict = "anim@amb@board_room@whiteboard@", anim = "read_03_amy_skater_01", walk = false, loop = true },
	["foto108"] = { dict = "anim@heists@team_respawn@variations@variation_b_rot", anim = "respawn_b_ped_c", walk = false, loop = true },
	["foto109"] = { anim = "idle_d", dict = "anim@amb@casino@hangout@ped_female@stand@01a@idles", walk = false, loop = true },
	["foto110"] = { dict = "amb@world_human_stand_guard@male@idle_a", anim = "idle_a", walk = false, loop = true },
	["foto111"] = { dict = "amb@world_human_tourist_mobile@male@base", anim = "base", walk = false, loop = true },
	["foto112"] = { dict = "switch@michael@pharmacy", anim = "mics1_ig_11_loop", walk = false, loop = true },
	["foto113"] = { dict = "weapons@first_person@aim_idle@p_m_one@unarmed@fidgets@c", anim = "fidget_low_loop", walk = false, loop = true },
	["foto114"] = { dict = "armenian_1_int-0", anim = "player_one_dual-0", walk = false, loop = true },
	["foto115"] = { dict = "amb@world_human_bum_wash@male@low@idle_a", anim = "idle_a", walk = false, loop = true },
	["foto116"] = { dict = "anim@amb@casino@hangout@ped_male@stand_withdrink@01b@base", anim = "base", walk = false, loop = true },
	["foto117"] = { dict = "anim@move_m@trash_rc", anim = "aim_high_loop", walk = false, loop = true },
	["foto118"] = { dict = "martin_1_int-10", anim = "cs_patricia_dual-10", walk = false, loop = true },
	["foto119"] = { dict = "club_open-30", anim = "ig_djsolmanager_dual-30", walk = false, loop = true },
	["foto120"] = { dict = "anim_heist@arcade_combined@", anim = "ped_female@_stand@_02a@_idles_convo_idle_d", walk = false, loop = true },
	["foto121"] = { dict = "amb@code_human_police_investigate@base", anim = "base", walk = false, loop = true },
	["foto122"] = { dict = "amb@world_human_golf_player@male@base", anim = "base", walk = false, loop = true },
	["foto123"] = { dict = "rcmnigel1a", anim = "base", walk = false, loop = true },
	["foto124"] = { dict = "timetable@ron@ig_1", anim = "ig_1_base", walk = false, loop = true },
	["foto125"] = { dict = "anim@amb@code_human_in_car_idles@arm@generic@ds@idle_j", anim = "idle_lowdoor", walk = false, loop = true },
	["foto126"] = { dict = "club_open-0", anim = "cs_lazlow_2_dual-0", walk = false, loop = true },
	["foto127"] = { dict = "armenian_1_int-33", anim = "a_m_y_runner_01-33", walk = false, loop = true },
	["tiktok"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_left_up", walk = false, loop = true },
	["tiktok2"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_f@", anim = "ped_a_dance_idle", walk = false, loop = true },
	["tiktok3"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_f@", anim = "ped_b_dance_idle", walk = false, loop = true },
	["tiktok4"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_h@", anim = "ped_a_dance_idle", walk = false, loop = true },
	["tiktok5"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_h@", anim = "ped_b_dance_idle", walk = false, loop = true },
	["tiktok6"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_j@", anim = "ped_a_dance_idle", walk = false, loop = true },
	["tiktok7"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_m@", anim = "ped_a_dance_idle", walk = false, loop = true },
	["tiktok8"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_f02", walk = false, loop = true },
	["tiktok9"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_b_f02", walk = false, loop = true },
	["tiktok10"] = { dict = "anim@mp_player_intcelebrationfemale@crowd_invitation", anim = "crowd_invitation", walk = false, loop = true },
	["tiktok11"] = { dict = "anim@mp_player_intcelebrationfemale@driver", anim = "driver", walk = false, loop = true },
	["tiktok12"] = { dict = "anim@mp_player_intcelebrationfemale@shooting", anim = "shooting", walk = false, loop = true },
	["tiktok13"] = { dict = "anim@mp_player_intcelebrationmale@shooting", anim = "shooting", walk = false, loop = true },
	["tiktok14"] = { dict = "anim@mp_player_intcelebrationmale@suck_it", anim = "suck_it", walk = false, loop = true },
	["tiktok15"] = { dict = "anim@mp_player_intuppercrowd_invitation", anim = "idle_a", walk = false, loop = true },
	["tiktok16"] = { dict = "anim@mp_player_intuppershooting", anim = "idle_a", walk = false, loop = true },
	["tiktok17"] = { dict = "anim@mp_player_intuppersuck_it", anim = "idle_a", walk = false, loop = true },
	["tiktok18"] = { dict = "custom@crossbounce", anim = "crossbounce", walk = false, loop = true },
	["tiktok19"] = { dict = "custom@dont_start", anim = "dont_start", walk = false, loop = true },
	["tiktok20"] = { dict = "custom@floss", anim = "floss", walk = false, loop = true },
	["tiktok21"] = { dict = "custom@orangejustice", anim = "orangejustice", walk = false, loop = true },
	["tiktok22"] = { dict = "custom@renegade", anim = "renegade", walk = false, loop = true },
	["tiktok23"] = { dict = "custom@rickroll", anim = "rickroll", walk = false, loop = true },
	["tiktok24"] = { dict = "custom@savage", anim = "savage", walk = false, loop = true },
	["tiktok25"] = { dict = "custom@sayso", anim = "sayso", walk = false, loop = true },
	["tiktok26"] = { dict = "custom@take_l", anim = "take_l", walk = false, loop = true },
	["tiktok27"] = { dict = "custom@toosie_slide", anim = "toosie_slide", walk = false, loop = true },
	["tiktok28"] = { dict = "custom@around_the_clock", anim = "around_the_clock", walk = false, loop = true },
	["tiktok29"] = { dict = "custom@dancemoves", anim = "dancemoves", walk = false, loop = true },
	["tiktok30"] = { dict = "custom@disco_dance", anim = "disco_dance", walk = false, loop = true },
	["tiktok31"] = { dict = "custom@electroshuffle_original", anim = "electroshuffle_original", walk = false, loop = true },
	["tiktok32"] = { dict = "custom@electroshuffle", anim = "electroshuffle", walk = false, loop = true },
	["tiktok33"] = { dict = "custom@fresh_fortnite", anim = "fresh_fortnite", walk = false, loop = true },
	["tiktok34"] = { dict = "custom@gylphic", anim = "gylphic", walk = false, loop = true },
	["tiktok35"] = { dict = "custom@hitit", anim = "hitit", walk = false, loop = true },
	["tiktok36"] = { dict = "custom@in_da_party", anim = "in_da_party", walk = false, loop = true },
	["tiktok37"] = { dict = "custom@robotdance_fortnite", anim = "robotdance_fortnite", walk = false, loop = true },
	["tiktok38"] = { dict = "custom@frightfunk", anim = "frightfunk", walk = false, loop = true },
	["tiktok39"] = { dict = "custom@gloss", anim = "gloss", walk = false, loop = true },
	["tiktok40"] = { dict = "custom@last_forever", anim = "last_forever", walk = false, loop = true },
	["tiktok41"] = { dict = "custom@smooth_moves", anim = "smooth_moves", walk = false, loop = true },
	["tiktok42"] = { dict = "custom@bellydance2", anim = "bellydance2", walk = false, loop = true },
	["tiktok43"] = { dict = "custom@introducing", anim = "introducing", walk = false, loop = true },
	["tiktok44"] = { dict = "custom@footwork", anim = "footwork", walk = false, loop = true },
	["tiktok45"] = { dict = "custom@headspin", anim = "headspin", walk = false, loop = true },
	["tiktok46"] = { dict = "custom@hiphop_pumpup", anim = "hiphop_pumpup", walk = false, loop = true },
	["tiktok47"] = { dict = "custom@hiphop_yeah", anim = "hiphop_yeah", walk = false, loop = true },
	["tiktok48"] = { dict = "custom@salsatime", anim = "salsatime", walk = false, loop = true },
	["tiktok49"] = { dict = "custom@samba", anim = "samba", walk = false, loop = true },
	["tiktok50"] = { dict = "custom@shockdance", anim = "shockdance", walk = false, loop = true },
	["tiktok51"] = { dict = "custom@specialdance", anim = "specialdance", walk = false, loop = true },
	["tiktok52"] = { dict = "custom@toetwist", anim = "toetwist", walk = false, loop = true },
	["tiktok53"] = { dict = "custom@gangnamstyle", anim = "gangnamstyle", walk = false, loop = true },
	["tiktok54"] = { dict = "custom@armswirl", anim = "armswirl", walk = false, loop = true },
	["cayo1"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_f02", walk = false, loop = true },
	["cayo2"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_m01", walk = false, loop = true },
	["cayo3"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_m02", walk = false, loop = true },
	["cayo4"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_m03", walk = false, loop = true },
	["cayo5"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_f01", walk = false, loop = true },
	["cayo6"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_f02", walk = false, loop = true },
	["cayo7"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_f03", walk = false, loop = true },
	["cayo8"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_m01", walk = false, loop = true },
	["cayo9"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_m02", walk = false, loop = true },
	["cayo10"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_m03", walk = false, loop = true },
	["cayo11"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_f01", walk = false, loop = true },
	["cayo12"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_ti_f03", walk = false, loop = true },
	["cayo13"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_f03", walk = false, loop = true },
	["cayo14"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_m01", walk = false, loop = true },
	["cayo15"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_m02", walk = false, loop = true },
	["cayo16"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_m03", walk = false, loop = true },
	["cayo17"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_f01", walk = false, loop = true },
	["cayo18"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_f02", walk = false, loop = true },
	["cayo19"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_f03", walk = false, loop = true },
	["cayo20"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_m01", walk = false, loop = true },
	["cayo21"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_f01", walk = false, loop = true },
	["cayo22"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_m03", walk = false, loop = true },
	["cayo23"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_e_f02", walk = false, loop = true },
	["cayo24"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_f_f02", walk = false, loop = true },
	["cayo25"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_f01", walk = false, loop = true },
	["cayo26"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_ti_f02", walk = false, loop = true },
	["cayo27"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_f03", walk = false, loop = true },
	["cayo28"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_m01", walk = false, loop = true },
	["cayo29"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_m02", walk = false, loop = true },
	["cayo30"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_m03", walk = false, loop = true },
	["cayo31"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_li_f01", walk = false, loop = true },
	["cayo32"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_li_f02", walk = false, loop = true },
	["cayo33"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_li_f03", walk = false, loop = true },
	["cayo34"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_li_m01", walk = false, loop = true },
	["cayo35"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_li_m02", walk = false, loop = true },
	["cayo36"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_li_m03", walk = false, loop = true },
	["cayo37"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_mi_f01", walk = false, loop = true },
	["cayo38"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_mi_f02", walk = false, loop = true },
	["cayo39"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_mi_f03", walk = false, loop = true },
	["cayo40"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_mi_m01", walk = false, loop = true },
	["cayo41"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_mi_m02", walk = false, loop = true },
	["cayo42"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_mi_m03", walk = false, loop = true },
	["cayo43"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_si_f01", walk = false, loop = true },
	["cayo44"] = { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_ti_f01", walk = false, loop = true },
	["beijar"] = { dict = "mp_ped_interaction", anim = "kisses_guy_a", walk = false, loop = false },
	["striper"] = { dict = "mini@strip_club@idles@stripper", anim = "stripper_idle_02", walk = false, loop = true },
	["escutar"] = { dict = "mini@safe_cracking", anim = "idle_base", walk = false, loop = true },
	["alongar"] = { dict = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e", walk = false, loop = true },
	["dj"] = { dict = "anim@mp_player_intupperdj", anim = "idle_a", walk = true, loop = true },
	["rock"] = { dict = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar", walk = false, loop = true },
	["rock2"] = { dict = "mp_player_introck", anim = "mp_player_int_rock", walk = false, loop = false },
	["abracar"] = { dict = "mp_ped_interaction", anim = "hugs_guy_a", walk = false, loop = false },
	["abracar2"] = { dict = "mp_ped_interaction", anim = "kisses_guy_b", walk = false, loop = false },
	["peitos"] = { dict = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b", walk = false, loop = false },
	["espernear"] = { dict = "missfam4leadinoutmcs2", anim = "tracy_loop", walk = false, loop = true },
	["arrumar"] = { dict = "anim@amb@business@coc@coc_packing_hi@", anim = "full_cycle_v1_pressoperator", walk = false, loop = true },
	["bebado"] = { dict = "missfam5_blackout", anim = "pass_out", walk = false, loop = false },
	["bebado2"] = { dict = "missheist_agency3astumble_getup", anim = "stumble_getup", walk = false, loop = false },
	["bebado3"] = { dict = "missfam5_blackout", anim = "vomit", walk = false, loop = false },
	["yoga"] = { dict = "missfam5_yoga", anim = "f_yogapose_a", walk = false, loop = true },
	["yoga2"] = { dict = "amb@world_human_yoga@male@base", anim = "base_a", walk = false, loop = true },
	["abdominal"] = { dict = "amb@world_human_sit_ups@male@base", anim = "base", walk = false, loop = true },
	["pensativo"] = { anim = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS" },
	["britadeira"] = { dict = "amb@world_human_const_drill@male@drill@base", anim = "base", prop = "prop_tool_jackham", flag = 15, mao = 28422 },
	["cerveja"] = { anim = "WORLD_HUMAN_PARTYING" },
	["churrasco"] = { anim = "PROP_HUMAN_BBQ" },
	["consertar"] = { anim = "WORLD_HUMAN_WELDING" },
	["bracos"] = { dict = "anim@heists@heist_corona@single_team", anim = "single_team_loop_boss", walk = true, loop = true },
	["postura3"] = { dict = "mini@strip_club@idles@bouncer@base", anim = "base", walk = true, loop = true },
	["dedos"] = { dict = "anim@mp_player_intupperfinger", anim = "idle_a_fp", walk = true, loop = true },
	["dormir"] = { dict = "anim@heists@ornate_bank@hostages@hit", anim = "hit_react_die_loop_ped_a", walk = false, loop = true },
	["dormir2"] = { dict = "anim@heists@ornate_bank@hostages@hit", anim = "hit_react_die_loop_ped_e", walk = false, loop = true },
	["dormir3"] = { dict = "anim@heists@ornate_bank@hostages@hit", anim = "hit_react_die_loop_ped_h", walk = false, loop = true },
	["encostar"] = { dict = "amb@lo_res_idles@", anim = "world_human_lean_male_foot_up_lo_res_base", walk = false, loop = true },
	["encostar2"] = { dict = "bs_2a_mcs_10-0", anim = "hc_gunman_dual-0", walk = false, loop = true },
	["encostar3"] = { dict = "misscarstealfinalecar_5_ig_1", anim = "waitloop_lamar", walk = false, loop = true },
	["encostar4"] = { dict = "anim@amb@casino@out_of_money@ped_female@02b@base", anim = "base", walk = false, loop = true },
	["encostar5"] = { dict = "anim@amb@casino@hangout@ped_male@stand@03b@base", anim = "base", walk = true, loop = true },
	["encostar6"] = { dict = "anim@amb@casino@hangout@ped_female@stand@02b@base", anim = "base", walk = false, loop = true },
	["encostar7"] = { dict = "anim@amb@casino@hangout@ped_female@stand@02a@base", anim = "base", walk = false, loop = true },
	["encostar8"] = { dict = "anim@amb@casino@hangout@ped_female@stand@01b@base", anim = "base", walk = false, loop = true },
	["encostar9"] = { dict = "anim@amb@clubhouse@bar@bartender@", anim = "base_bartender", walk = false, loop = true },
	["encostar10"] = { dict = "missclothing", anim = "idle_a", walk = false, loop = true },
	["encostar11"] = { dict = "misscarstealfinale", anim = "packer_idle_1_trevor", walk = false, loop = true },
	["encostar12"] = { dict = "missarmenian1leadinoutarm_1_ig_14_leadinout", anim = "leadin_loop", walk = false, loop = true },
	["encostar13"] = { dict = "rcmjosh2", anim = "josh_2_intp1_base", walk = false, loop = true },
	["encostar14"] = { dict = "rcmjosh2", anim = "josh_wait_loop", walk = false, loop = true },
	["encostar15"] = { dict = "anim@amb@yacht@bow@male@variation_01@", anim = "base", walk = false, loop = true },
	["encostar16"] = { dict = "anim@heists@prison_heist", anim = "ped_b_loop_a", walk = false, loop = true },
	["encostar17"] = { dict = "anim@heists@prison_heiststation@cop_reactions", anim = "drunk_idle", walk = false, loop = true },
	["encostar18"] = { dict = "rcmnigel1a_band_groupies", anim = "base_m2", walk = false, loop = true },
	["encostar19"] = { dict = "misscarsteal1car_1_ext_leadin", anim = "base_driver1", walk = false, loop = true },
	["encostar20"] = { dict = "missclothing", anim = "idle_b", walk = false, loop = true },
	["encostar21"] = { dict = "missfbi1ig_8", anim = "outro1_pedb", walk = false, loop = true },
	["encostar22"] = { dict = "missfbi1leadinout", anim = "fbi_1_int_leadin_exit_loop_daven", walk = false, loop = true },
	["encostar23"] = { dict = "misshair_shop@hair_dressers", anim = "assistant_base", walk = false, loop = true },
	["encostar24"] = { dict = "missheist_agency2aig_4", anim = "look_plan_base_worker2", walk = false, loop = true },
	["encostar25"] = { dict = "missheistdockssetup1ig_12@base", anim = "talk_gantry_idle_base_worker4", walk = false, loop = true },
	["encostar26"] = { dict = "missstrip_club_lean", anim = "player_lean_rail_loop", walk = false, loop = true },
	["encostar27"] = { dict = "missheist_jewelleadinout", anim = "jh_int_outro_loop_c", walk = false, loop = true },
	["encostar28"] = { dict = "anim@amb@business@bgen@bgen_no_work@", anim = "stand_phone_phoneputdown_fallasleep_nowork", walk = false, loop = true },
	["encostar29"] = { dict = "anim@amb@business@bgen@bgen_no_work@", anim = "stand_phone_phoneputdown_idle_nowork", walk = false, loop = true },
	["encostar30"] = { dict = "anim@amb@business@bgen@bgen_no_work@", anim = "stand_phone_phoneputdown_stretching_nowork", walk = false, loop = true },
	["encostar31"] = { dict = "anim@amb@clubhouse@bar@bartender@", anim = "greeting_c_bartender", walk = false, loop = true },
	["encostar32"] = { dict = "anim@amb@clubhouse@bar@drink@base", anim = "idle_a", walk = false, loop = true },
	["encostar33"] = { dict = "misscarsteal4leadinout", anim = "ig_1_base", walk = false, loop = true },
	["encostar34"] = { dict = "missclothing", anim = "base", walk = false, loop = true },
	["encostar35"] = { dict = "missheistdockssetup1ig_5@base", anim = "workers_talking_base_dockworker2", walk = false, loop = true },
	["encostar36"] = { dict = "switch@michael@sitting_on_car_bonnet", anim = "sitting_on_car_bonnet_loop", walk = false, loop = true },
	["encostar37"] = { dict = "amb@world_human_leaning@male@wall@back@foot_up@react_shock", anim = "front", walk = false, loop = true },
	["encostar38"] = { dict = "anim@amb@world_human_valet@informal@idle_a@", anim = "idle_a_a_m_y_vinewood_01", walk = false, loop = true },
	["encostar39"] = { dict = "anim@amb@nightclub@dancers@club_ambientpeds@low-med_intensity", anim =
	"li-mi_amb_club_06_base_female^1", walk = false, loop = true },
	["encostar41"] = { dict = "silj_int-8", anim = "csb_mp_agent14_dual-8", walk = false, loop = true },
	["encostar42"] = { dict = "anim@veh@btype@side_ds@base", anim = "sit", walk = false, loop = true },
	["encostar43"] = { dict = "anim@veh@btype@side_ps@base", anim = "sit", walk = false, loop = true },
	["encostar44"] = { dict = "timetable@michael@talk_phonebase", anim = "talk_phone_base", walk = false, loop = true },
	["encostar45"] = { dict = "anim@amb@clubhouse@bar@bartender@", anim = "base_bartender", walk = false, loop = true },
	["encostar46"] = { dict = "anim@amb@yacht@jacuzzi@standing@female@variation_02@", anim = "base_b", walk = false, loop = true },
	["encostar49"] = { dict = "rcmjosh2", anim = "josh_2_intp1_base", walk = false, loop = true },
	["encostar50"] = { dict = "anim@arena@prize_wheel@male", anim = "base", walk = false, loop = true },
	["encostar51"] = { dict = "hs3_arc_int-15", anim = "csb_wendy_dual-15", walk = false, loop = true },
	["encostar52"] = { dict = "anim@amb@yacht@rail@seated@female@variant_02@", anim = "base", walk = false, loop = true },
	["encostar53"] = { dict = "anim@amb@yacht@rail@seated@male@variant_01@", anim = "base", walk = false, loop = true },
	["encostar54"] = { dict = "misscarsteal4leadinout", anim = "ig_1_base", walk = false, loop = true },
	["encostar55"] = { dict = "anim@amb@business@meth@meth_monitoring_no_work@", anim = "turnaround_idle_v1_lazycook", walk = false, loop = true },
	["encostar56"] = { dict = "sub_int-42", anim = "a_m_y_busicas_01_dual-42", walk = false, loop = true },
	["encostar57"] = { dict = "fra_0_int-9", anim = "player_one_dual-9", walk = false, loop = true },
	["encostar58"] = { dict = "anim@amb@nightclub@dancers@club_ambientpeds@low-med_intensity", anim =
	"li-mi_amb_club_10_v1_male^3", walk = false, loop = true },
	["encostar59"] = { dict = "missheistdocks2aleadinoutlsdh_2a_int", anim = "massage_loop_floyd", walk = false, loop = true },
	["encostar60"] = { dict = "amb@lo_res_idles@", anim = "world_human_lean_female_holding_elbow_lo_res_base", walk = false, loop = true },
	["encostar61"] = { dict = "anim@amb@yacht@jacuzzi@standing@female@variation_01@", anim = "base", walk = false, loop = true },
	["encostar62"] = { dict = "anim@amb@yacht@jacuzzi@standing@female@variation_02@", anim = "base", walk = false, loop = true },
	["encostar63"] = { dict = "anim@amb@yacht@jacuzzi@standing@male@variation_01@", anim = "base", walk = false, loop = true },
	["encostar64"] = { dict = "anim@amb@yacht@jacuzzi@standing@male@variation_02@", anim = "base", walk = false, loop = true },
	["encostar65"] = { dict = "switch@michael@pier", anim = "pier_lean_toss_cigarette", walk = false, loop = true },
	["encostar66"] = { dict = "missheistdockssetup1ig_10@idle_d", anim = "talk_pipe_d_worker2", walk = false, loop = true },
	["encostar67"] = { dict = "missheistdockssetup1ig_10@idle_a", anim = "talk_pipe_a_worker2", walk = false, loop = true },
	["encostar68"] = { dict = "amb@code_human_in_car_mp_actions@finger@std@rps@base", anim = "idle_a", walk = false, loop = true },
	["pose"] = { dict = "lunyx@rgmp01", anim = "rgmp01", walk = true, loop = true },
	["pose2"] = { dict = "lunyx@rgmp02", anim = "rgmp02", walk = true, loop = true },
	["pose3"] = { dict = "lunyx@rgmp03", anim = "rgmp03", walk = true, loop = true },
	["pose4"] = { dict = "lunyx@rgmp04", anim = "rgmp04", walk = true, loop = true },
	["pose5"] = { dict = "lunyx@rgmp05", anim = "rgmp05", walk = true, loop = true },
	["pose6"] = { dict = "lunyx@rgmp06", anim = "rgmp06", walk = true, loop = true },
	["pose7"] = { dict = "lunyx@rgmp07", anim = "rgmp07", walk = true, loop = true },
	["pose8"] = { dict = "syx@cute01", anim = "cute01", walk = true, loop = true },
	["pose9"] = { dict = "syx@cute02", anim = "cute02", walk = true, loop = true },
	["pose10"] = { dict = "syx@cute03", anim = "cute03", walk = true, loop = true },
	["pose11"] = { dict = "syx@cute04", anim = "cute04", walk = true, loop = true },
	["pose12"] = { dict = "syx@cute05", anim = "cute05", walk = true, loop = true },
	["pose13"] = { dict = "lunyx@random@v3@pose001", anim = "random@v3@pose001", walk = true, loop = true },
	["pose14"] = { dict = "lunyx@random@v3@pose002", anim = "random@v3@pose002", walk = true, loop = true },
	["pose15"] = { dict = "lunyx@random@v3@pose003", anim = "random@v3@pose003", walk = false, loop = true },
	["pose16"] = { dict = "lunyx@random@v3@pose004", anim = "random@v3@pose004", walk = false, loop = true },
	["pose17"] = { dict = "lunyx@random@v3@pose005", anim = "random@v3@pose005", walk = false, loop = true },
	["pose18"] = { dict = "lunyx@random@v3@pose006", anim = "random@v3@pose006", walk = true, loop = true },
	["pose19"] = { dict = "lunyx@random@v3@pose007", anim = "random@v3@pose007", walk = true, loop = true },
	["pose20"] = { dict = "lunyx@random@v3@pose008", anim = "random@v3@pose008", walk = true, loop = true },
	["pose21"] = { dict = "lunyx@random@v3@pose009", anim = "random@v3@pose009", walk = true, loop = true },
	["pose22"] = { dict = "lunyx@random@v3@pose010", anim = "random@v3@pose010", walk = true, loop = true },
	["pose23"] = { dict = "lunyx@random@v3@pose011", anim = "random@v3@pose011", walk = true, loop = true },
	["pose24"] = { dict = "lunyx@random@v3@pose012", anim = "random@v3@pose012", walk = true, loop = true },
	["pose25"] = { dict = "lunyx@random@v3@pose013", anim = "random@v3@pose013", walk = true, loop = true },
	["pose26"] = { dict = "lunyx@random@v3@pose014", anim = "random@v3@pose014", walk = true, loop = true },
	["pose27"] = { dict = "lunyx@random@v3@pose015", anim = "random@v3@pose015", walk = true, loop = true },
	["pose28"] = { dict = "lunyx@random@v3@pose016", anim = "random@v3@pose016", walk = true, loop = true },
	["pose29"] = { dict = "lunyx@random@v3@pose017", anim = "random@v3@pose017", walk = false, loop = true },
	["pose30"] = { dict = "lunyx@random@v3@pose018", anim = "random@v3@pose018", walk = true, loop = true },
	["pose31"] = { dict = "lunyx@random@v3@pose019", anim = "random@v3@pose019", walk = true, loop = true },
	["pose32"] = { dict = "lunyx@random@v3@pose020", anim = "random@v3@pose020", walk = true, loop = true },
	["pose33"] = { dict = "missmic4premiere", anim = "prem_actress_star_a", walk = false, loop = true },
	["estatua"] = { dict = "amb@world_human_statue@base", anim = "base", walk = false, loop = true },
	["flexao"] = { dict = "amb@world_human_push_ups@male@base", anim = "base", walk = false, loop = true },
	["fumar"] = { anim = "WORLD_HUMAN_SMOKING" },
	["fumar2"] = { anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS" },
	["fumar3"] = { anim = "WORLD_HUMAN_AA_SMOKE" },
	["fumar4"] = { anim = "WORLD_HUMAN_SMOKING_POT" },
	["fumar5"] = { dict = "amb@world_human_aa_smoke@male@idle_a", anim = "idle_c", prop = "prop_cs_ciggy_01", flag = 49, mao = 28422 },
	["fumar6"] = { dict = "amb@world_human_aa_smoke@male@idle_a", anim = "idle_b", prop = "prop_cs_ciggy_01", flag = 49, mao = 28422 },
	["fumar7"] = { dict = "amb@world_human_smoking@female@idle_a", anim = "idle_b", prop = "prop_cs_ciggy_01", flag = 49, mao = 28422 },
	["malhar"] = { dict = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base", prop =
	"prop_curl_bar_01", flag = 49, mao = 28422 },
	["malhar2"] = { dict = "amb@prop_human_muscle_chin_ups@male@base", anim = "base", walk = false, loop = true },
	["martelo"] = { dict = "amb@world_human_hammering@male@base", anim = "base", prop = "prop_tool_hammer", flag = 49, mao = 28422 },
	["pescar"] = { dict = "amb@world_human_stand_fishing@base", anim = "base", prop = "prop_fishing_rod_01", flag = 49, mao = 60309 },
	["pescar2"] = { dict = "amb@world_human_stand_fishing@idle_a", anim = "idle_c", prop = "prop_fishing_rod_01", flag = 49, mao = 60309 },
	["plantar"] = { dict = "amb@world_human_gardener_plant@female@base", anim = "base_female", walk = false, loop = true },
	["plantar2"] = { dict = "amb@world_human_gardener_plant@female@idle_a", anim = "idle_a_female", walk = false, loop = true },
	["procurar"] = { dict = "amb@world_human_bum_wash@male@high@base", anim = "base", walk = false, loop = true },
	["soprador"] = { dict = "amb@code_human_wander_gardener_leaf_blower@base", anim = "static", prop =
	"prop_leaf_blower_01", flag = 49, mao = 28422 },
	["soprador2"] = { dict = "amb@code_human_wander_gardener_leaf_blower@idle_a", anim = "idle_a", prop =
	"prop_leaf_blower_01", flag = 49, mao = 28422 },
	["soprador3"] = { dict = "amb@code_human_wander_gardener_leaf_blower@idle_a", anim = "idle_b", prop =
	"prop_leaf_blower_01", flag = 49, mao = 28422 },
	["tragar"] = { anim = "WORLD_HUMAN_DRUG_DEALER" },
	["trotar"] = { dict = "amb@world_human_jog_standing@male@fitidle_a", anim = "idle_a", walk = false, loop = true },
	["tablet"] = { dict = "amb@code_human_in_bus_passenger_idles@female@tablet@base", anim = "base", prop =
	"prop_cs_tablet", flag = 50, mao = 28422 },
	["selfie"] = { dict = "cellphone@self", anim = "selfie_in_from_text", prop = "prop_npc_phone_02", flag = 50, mao = 28422 },
	["selfie2"] = { dict = "cellphone@", anim = "cellphone_text_read_base_cover_low", prop = "prop_npc_phone_02", flag = 50, mao = 28422 },
	["xiu"] = { dict = "anim@mp_player_intincarshushbodhi@ds@", anim = "idle_a_fp", walk = true, loop = true },
	["tapa"] = { dict = "melee@unarmed@streamed_variations", anim = "plyr_takedown_front_slap", walk = false, loop = false },
	["hotwired"] = { dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", walk = true, loop = true, cars = true },
	["pano2"] = { dict = "timetable@floyd@clean_kitchen@base", anim = "base", prop = "prop_sponge_01", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.01, pos3 = 90.0, pos4 = 0.0, pos5 = 0.0 },
	["pano"] = { dict = "amb@world_human_maid_clean@", anim = "base", prop = "prop_sponge_01", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.01, pos3 = 90.0, pos4 = 0.0, pos5 = 0.0 },
	["cruzar"] = { dict = "random@street_race", anim = "_car_b_lookout", walk = true, loop = true },
	["cruzar2"] = { dict = "anim@amb@nightclub@peds@", anim = "rcmme_amanda1_stand_loop_cop", walk = true, loop = true },
	["cruzar3"] = { dict = "amb@world_human_hang_out_street@male_c@idle_a", anim = "idle_b", walk = true, loop = true },
	["cruzar4"] = { dict = "random@street_race", anim = "_car_b_lookout", walk = true, loop = true },
	["cruzar5"] = { dict = "random@shop_gunstore", anim = "_idle", walk = true, loop = true },
	["cruzar6"] = { dict = "move_m@hiking", anim = "idle", walk = true, loop = true },
	["cruzar7"] = { dict = "anim@amb@casino@valet_scenario@pose_d@", anim = "base_a_m_y_vinewood_01", walk = true, loop = true },
	["cruzar8"] = { dict = "anim@amb@nightclub@peds@", anim = "rcmme_amanda1_stand_loop_cop", walk = true, loop = true },
	["cruzar9"] = { dict = "anim@amb@casino@shop@ped_female@01a@base", anim = "base", walk = true, loop = true },
	["cruzar10"] = { dict = "anim@amb@casino@valet_scenario@pose_c@", anim = "shuffle_feet_a_m_y_vinewood_01", walk = true, loop = true },
	["cruzar11"] = { dict = "anim@amb@casino@hangout@ped_male@stand@03a@idles_convo", anim = "idle_a", walk = true, loop = true },
	["esperar"] = { dict = "random@shop_tattoo", anim = "_idle_a", walk = true, loop = true },
	["esperar2"] = { dict = "rcmnigel1cnmt_1c", anim = "base", walk = true, loop = true },
	["esperar3"] = { dict = "rcmjosh1", anim = "idle", walk = true, loop = true },
	["esperar4"] = { dict = "timetable@amanda@ig_3", anim = "ig_3_base_tracy", walk = true, loop = true },
	["esperar5"] = { dict = "misshair_shop@hair_dressers", anim = "keeper_base", walk = true, loop = true },
	["esperar6"] = { dict = "jh_1_ig_3-2", anim = "cs_jewelass_dual-2", walk = true, loop = true },
	["esperar7"] = { dict = "oddjobs@taxi@", anim = "idle_a", walk = false, loop = true },
	["esperar8"] = { dict = "amb@world_human_bum_standing@twitchy@base", anim = "base", walk = true, loop = true },
	["superstar"] = { anim = "prem_4stars_a_molly", dict = "missmic4premiere", walk = false, loop = true },
	["superstar1"] = { anim = "prem_4stars_a_ruben", dict = "missmic4premiere", walk = false, loop = true },
	["superstar2"] = { anim = "idle_a", dict = "random@bus_tour_guide@idle_a", walk = false, loop = true },
	["superstar3"] = { anim = "prem_4stars_a_benton", dict = "missmic4premiere", walk = false, loop = true },
	["superstar4"] = { anim = "prem_milton_milton_a", dict = "missmic4premiere", walk = false, loop = true },
	["inspec"] = { dict = "anim@deathmatch_intros@melee@2h", anim = "intro_male_melee_2h_b", walk = false, loop = true },
	["inspec2"] = { dict = "anim@deathmatch_intros@melee@2h", anim = "intro_male_melee_2h_c", walk = false, loop = false },
	["inspec3"] = { dict = "anim@deathmatch_intros@melee@2h", anim = "intro_male_melee_2h_d", walk = false, loop = false },
	["inspec4"] = { dict = "anim@deathmatch_intros@melee@2h", anim = "intro_male_melee_2h_e", walk = false, loop = false },
	["inspec5"] = { dict = "mp_deathmatch_intros@1hmale", anim = "intro_male_1h_a_michael", walk = false, loop = false },
	["inspec6"] = { dict = "mp_deathmatch_intros@melee@1h", anim = "intro_male_melee_1h_a", walk = false, loop = false },
	["inspec7"] = { dict = "mp_deathmatch_intros@melee@1h", anim = "intro_male_melee_1h_b", walk = false, loop = false },
	["inspec8"] = { dict = "mp_deathmatch_intros@melee@1h", anim = "intro_male_melee_1h_c", walk = false, loop = false },
	["inspec9"] = { dict = "mp_deathmatch_intros@melee@1h", anim = "intro_male_melee_1h_d", walk = false, loop = false },
	["inspec10"] = { dict = "mp_deathmatch_intros@melee@1h", anim = "intro_male_melee_1h_e", walk = false, loop = false },
	["inspec11"] = { dict = "mp_deathmatch_intros@melee@2h", anim = "intro_male_melee_2h_a", walk = false, loop = false },
	["inspec12"] = { dict = "mp_deathmatch_intros@melee@2h", anim = "intro_male_melee_2h_b", walk = false, loop = false },
	["inspec13"] = { dict = "mp_deathmatch_intros@melee@2h", anim = "intro_male_melee_2h_c", walk = false, loop = false },
	["inspec14"] = { dict = "mp_deathmatch_intros@melee@2h", anim = "intro_male_melee_2h_d", walk = false, loop = false },
	["inspec15"] = { dict = "mp_deathmatch_intros@melee@2h", anim = "intro_male_melee_2h_e", walk = false, loop = false },
	["inspec16"] = { dict = "anim@deathmatch_intros@1hmale", anim = "intro_male_1h_d_michael", walk = true, loop = false },
	["swat"] = { dict = "swat", anim = "come", walk = true, loop = false },
	["swat2"] = { dict = "swat", anim = "freeze", walk = true, loop = false },
	["swat3"] = { dict = "swat", anim = "go_fwd", walk = true, loop = false },
	["swat4"] = { dict = "swat", anim = "rally_point", walk = true, loop = false },
	["swat5"] = { dict = "swat", anim = "understood", walk = true, loop = false },
	["swat6"] = { dict = "swat", anim = "you_back", walk = true, loop = false },
	["swat7"] = { dict = "swat", anim = "you_fwd", walk = true, loop = false },
	["swat8"] = { dict = "swat", anim = "you_left", walk = true, loop = false },
	["swat9"] = { dict = "swat", anim = "you_right", walk = true, loop = false },
	["knucklecrunch"] = { dict = "anim@mp_player_intcelebrationfemale@knuckle_crunch", anim = "knuckle_crunch", walk = true, loop = false },
	["leanside"] = { dict = "misscarstealfinalecar_5_ig_1", anim = "waitloop_lamar", walk = true, loop = true },
	["no2"] = { dict = "anim@heists@ornate_bank@chat_manager", anim = "fail", walk = true, loop = false },
	["ok"] = { dict = "anim@mp_player_intselfiedock", anim = "idle_a", walk = true, loop = false },
	["screwyou"] = { dict = "misscommon@response", anim = "screw_you", walk = true, loop = false },
	["think"] = { dict = "misscarsteal4@aliens", anim = "rehearsal_base_idle_director", walk = true, loop = true },
	["think2"] = { dict = "missheist_jewelleadinout", anim = "jh_int_outro_loop_a", walk = true, loop = true },
	["think3"] = { dict = "timetable@tracy@ig_8@base", anim = "base", walk = true, loop = true },
	["acenar"] = { dict = "random@mugging5", anim = "001445_01_gangintimidation_1_female_idle_b", walk = true, loop = true },
	["acenar2"] = { dict = "friends@fra@ig_1", anim = "over_here_idle_a", walk = true, loop = true },
	["acenar3"] = { dict = "friends@frj@ig_1", anim = "wave_e", walk = true, loop = true },
	["acenar4"] = { dict = "anim@mp_player_intcelebrationfemale@wave", anim = "wave", walk = true, loop = false },
	["acenar5"] = { dict = "friends@frj@ig_1", anim = "wave_c", walk = true, loop = false },
	["acenar6"] = { dict = "friends@frj@ig_1", anim = "wave_d", walk = true, loop = false },
	["gangsign"] = { dict = "mp_player_int_uppergang_sign_a", anim = "mp_player_int_gang_sign_a", walk = true, loop = true },
	["gangsign2"] = { dict = "mp_player_int_uppergang_sign_b", anim = "mp_player_int_gang_sign_b", walk = true, loop = true },
	["flipoff"] = { dict = "anim@arena@celeb@podium@no_prop@", anim = "flip_off_c_1st", walk = true, loop = true },
	["bow"] = { dict = "anim@arena@celeb@podium@no_prop@", anim = "regal_c_1st", walk = true, loop = false },
	["headbutt"] = { dict = "melee@unarmed@streamed_variations", anim = "plyr_takedown_front_headbutt", walk = true, loop = false },
	["airplane"] = { dict = "missfbi1", anim = "ledge_loop", walk = true, loop = true },
	["cough"] = { dict = "timetable@gardener@smoking_joint", anim = "idle_cough", walk = true, loop = true },
	["stretch"] = { dict = "mini@triathlon", anim = "idle_f", walk = true, loop = true },
	["punching"] = { dict = "rcmextreme2", anim = "loop_punching", walk = true, loop = true },
	["mindcontrol"] = { dict = "rcmbarry", anim = "bar_1_attack_idle_aln", walk = true, loop = true },
	["clown"] = { dict = "rcm_barry2", anim = "clown_idle_0", walk = false, loop = true },
	["clown2"] = { dict = "rcm_barry2", anim = "clown_idle_1", walk = false, loop = true },
	["clown3"] = { dict = "rcm_barry2", anim = "clown_idle_3", walk = false, loop = true },
	["namaste"] = { dict = "timetable@amanda@ig_4", anim = "ig_4_base", walk = false, loop = true },
	["wave4"] = { dict = "anim@mp_player_intcelebrationfemale@wave", anim = "wave", walk = true, loop = false },
	["wave5"] = { dict = "friends@frj@ig_1", anim = "wave_c", walk = true, loop = false },
	["wave6"] = { dict = "friends@frj@ig_1", anim = "wave_d", walk = true, loop = false },
	["ajustar"] = { dict = "missmic4", anim = "michael_tux_fidget", walk = true, loop = false },
	["argumentar"] = { dict = "oddjobs@assassinate@vice@hooker", anim = "argue_a", walk = true, loop = true },
	["argumentar2"] = { dict = "oddjobs@bailbond_mountain", anim = "excited_idle_b", walk = true, loop = true },
	["argumentar3"] = { dict = "oddjobs@bailbond_hobohang_out_street_c", anim = "idle_c", walk = false, loop = true },
	["argumentar4"] = { dict = "oddjobs@assassinate@old_lady", anim = "looking_for_help", walk = false, loop = true },
	["bow2"] = { dict = "anim@arena@celeb@podium@no_prop@", anim = "regal_a_1st", walk = true, loop = false },
	["boxing"] = { dict = "anim@mp_player_intcelebrationfemale@shadow_boxing", anim = "shadow_boxing", walk = true, loop = true },
	["cop"] = { dict = "amb@code_human_police_investigate@idle_a", anim = "idle_b", walk = true, loop = true },
	["countdown"] = { dict = "random@street_race", anim = "grid_girl_race_start", walk = true, loop = false },
	["reverencia"] = { dict = "anim@mp_player_intcelebrationpaired@f_f_sarcastic", anim = "sarcastic_left", walk = true, loop = true },
	["cutthroat2"] = { dict = "anim@mp_player_intcelebrationfemale@cut_throat", anim = "cut_throat", walk = true, loop = false },
	["damn"] = { dict = "gestures@m@standing@casual", anim = "gesture_damn", walk = true, loop = false },
	["damn2"] = { dict = "misscommon@response", anim = "damn", walk = true, loop = false },
	["handshake"] = { dict = "mp_ped_interaction", anim = "handshake_guy_a", walk = true, loop = false },
	["handshake2"] = { dict = "mp_ped_interaction", anim = "handshake_guy_b", walk = true, loop = false },
	["parado"] = { dict = "anim@heists@heist_corona@team_idles@male_a", anim = "idle", walk = true, loop = true },
	["parado2"] = { dict = "anim@heists@heist_corona@team_idles@female_a", anim = "idle", walk = true, loop = true },
	["parado3"] = { dict = "anim@heists@humane_labs@finale@strip_club", anim = "ped_b_celebrate_loop", walk = true, loop = true },
	["parado4"] = { dict = "anim@mp_celebration@idles@female", anim = "celebration_idle_f_a", walk = true, loop = true },
	["parado5"] = { dict = "anim@mp_corona_idles@female_b@idle_a", anim = "idle_a", walk = true, loop = true },
	["parado6"] = { dict = "anim@mp_corona_idles@male_c@idle_a", anim = "idle_a", walk = true, loop = true },
	["parado7"] = { dict = "anim@mp_corona_idles@male_d@idle_a", anim = "idle_a", walk = true, loop = true },
	["parado8"] = { dict = "amb@world_human_hang_out_street@male_b@idle_a", anim = "idle_b", walk = true, loop = true },
	["parado9"] = { dict = "friends@fra@ig_1", anim = "base_idle", walk = true, loop = true },
	["parado10"] = { dict = "mp_move@prostitute@m@french", anim = "idle", walk = true, loop = true },
	["parado11"] = { dict = "random@countrysiderobbery", anim = "idle_a", walk = true, loop = true },
	["idledrunk"] = { dict = "random@drunk_driver_1", anim = "drunk_driver_stand_loop_dd1", walk = true, loop = true },
	["idledrunk2"] = { dict = "random@drunk_driver_1", anim = "drunk_driver_stand_loop_dd2", walk = true, loop = true },
	["idledrunk3"] = { dict = "missarmenian2", anim = "standing_idle_loop_drunk", walk = true, loop = true },
	["jog3"] = { dict = "amb@world_human_jog_standing@female@idle_a", anim = "idle_a", walk = true, loop = true },
	["lean2"] = { dict = "amb@world_human_leaning@female@wall@back@hand_up@idle_a", anim = "idle_a", walk = true, loop = true },
	["lean3"] = { dict = "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", anim = "idle_a", walk = true, loop = true },
	["leanbar"] = { dict = "amb@prop_human_bum_shopping_cart@male@idle_a", anim = "idle_c", walk = true, loop = true },
	["leanbar2"] = { dict = "anim@amb@nightclub@lazlow@ig1_vip@", anim = "clubvip_base_laz", walk = true, loop = true },
	["leanbar3"] = { dict = "anim@heists@prison_heist", anim = "ped_b_loop_a", walk = true, loop = true },
	["me"] = { dict = "gestures@f@standing@casual", anim = "gesture_me_hard", walk = true, loop = false },
	["mecanico6"] = { dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", walk = true, loop = true },
	["metal"] = { dict = "anim@mp_player_intincarrockstd@ps@", anim = "idle_a", walk = true, loop = true },
	["mindblown"] = { dict = "anim@mp_player_intcelebrationmale@mind_blown", anim = "mind_blown", walk = true, loop = true },
	["mindblown2"] = { dict = "anim@mp_player_intcelebrationfemale@mind_blown", anim = "mind_blown", walk = true, loop = true },
	["mindcontrol2"] = { dict = "rcmbarry", anim = "mind_control_b_loop", walk = true, loop = true },
	["nervoso2"] = { dict = "amb@world_human_bum_standing@twitchy@idle_a", anim = "idle_c", walk = true, loop = true },
	["nervoso3"] = { dict = "mp_missheist_countrybank@nervous", anim = "nervous_idle", walk = true, loop = true },
	["olhadinha"] = { dict = "random@paparazzi@peek", anim = "left_peek_a", walk = true, loop = true },
	["pointdown"] = { dict = "gestures@f@standing@casual", anim = "gesture_hand_down", walk = true, loop = false },
	["banho"] = { dict = "mp_safehouseshower@male@", anim = "male_shower_idle_a", walk = true, loop = true },
	["cokecut"] = { dict = "anim@amb@business@coc@coc_unpack_cut@", anim = "fullcut_cycle_v6_cokecutter", walk = true, loop = true },
	["taxi"] = { dict = "taxi_hail", anim = "hail_taxi", walk = true, loop = false },
	["medo"] = { dict = "amb@code_human_cower@male@base", anim = "base", walk = true, loop = true },
	["preocupado"] = { dict = "random@homelandsecurity", anim = "knees_loop_girl", walk = true, loop = true },
	["conv"] = { dict = "special_ped@jessie@monologue_5@monologue_5c", anim = "jessie_ig_1_p5_heressomthinginteresting_2", walk = true, loop = false },
	["conv2"] = { dict = "special_ped@jessie@monologue_11@monologue_11c", anim = "jessie_ig_1_p11_canyouimagine_2", walk = true, loop = true },
	["conv3"] = { dict = "rcmjosh4", anim = "beckon_a_cop_b", walk = true, loop = true },
	["ohno"] = { dict = "misscommon@response", anim = "numbnuts", walk = true, loop = false },
	["ohno2"] = { dict = "misscommon@response", anim = "give_me_a_break", walk = true, loop = false },
	["limpar2"] = { dict = "move_m@_idles@shake_off", anim = "shakeoff_1", walk = true, loop = false },
	["ferido"] = { dict = "random@dealgonewrong", anim = "idle_a", walk = false, loop = true },
	["sleep"] = { dict = "timetable@tracy@sleep@", anim = "idle_c", walk = false, loop = true, },
	["fedor"] = { dict = "anim@mp_player_intcelebrationfemale@stinker", anim = "stinker", walk = true, loop = false },
	["estatua2"] = { dict = "fra_0_int-1", anim = "cs_lamardavis_dual-1", walk = false, loop = true },
	["estatua3"] = { dict = "club_intro2-0", anim = "csb_englishdave_dual-0", walk = false, loop = true },
	["shrug"] = { dict = "gestures@m@standing@casual", anim = "gesture_shrug_hard", walk = true, loop = false },
	["sitscared"] = { dict = "anim@heists@ornate_bank@hostages@hit", anim = "hit_loop_ped_b", walk = false, loop = true },
	["sitscared2"] = { dict = "anim@heists@ornate_bank@hostages@ped_c@", anim = "flinch_loop", walk = false, loop = true },
	["sitscared3"] = { dict = "anim@heists@ornate_bank@hostages@ped_e@", anim = "flinch_loop", walk = false, loop = true },
	["sitscared4"] = { dict = "amb@code_human_cower@male@base", anim = "base", walk = false, loop = true },
	["stunned"] = { dict = "stungun@standing", anim = "damage", walk = false, loop = true },
	["think5"] = { dict = "mp_cp_welcome_tutthink", anim = "b_think", walk = true, loop = false },
	["joia3"] = { dict = "anim@mp_player_intupperthumbs_up", anim = "idle_a", walk = true, loop = false },
	["tryclothes"] = { dict = "mp_clothing@female@trousers", anim = "try_trousers_neutral_a", walk = false, loop = false },
	["tryclothes2"] = { dict = "mp_clothing@female@shirt", anim = "try_shirt_positive_a", walk = false, loop = false },
	["tryclothes3"] = { dict = "mp_clothing@female@shoes", anim = "try_shoes_positive_a", walk = false, loop = false },
	["tryclothes4"] = { dict = "clothingtie", anim = "try_tie_neutral_c", walk = false, loop = false },
	["tryclothes5"] = { dict = "clothingtie", anim = "try_tie_neutral_d", walk = false, loop = false },
	["washhand"] = { dict = "missheist_agency3aig_23", anim = "urinal_sink_loop", walk = false, loop = true },
	["checkout"] = { dict = "anim@amb@carmeet@checkout_car@male_a@idles", anim = "idle_b", walk = false, loop = false },
	["checkout2"] = { dict = "anim@amb@carmeet@checkout_car@male_c@idles", anim = "idle_a", walk = false, loop = true },
	["dj3"] = { dict = "anim@scripted@nightclub@dj@dj_moodm@", anim = "moodm_cdj_left_a_12", walk = false, loop = true },
	["dj4"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj_transitions@from_low_intensity", anim =
	"trans_dance_facedj_li_to_mi_11_v1_male^3", walk = false, loop = true },
	["noway"] = { dict = "oddjobs@towingpleadingbase", anim = "base", walk = false, loop = false },
	["noway2"] = { dict = "gestures@m@car@std@casual@ds", anim = "gesture_no_way", walk = false, loop = false },
	["why"] = { dict = "random@shop_robbery_reactions@", anim = "is_this_it", walk = false, loop = false },
	["shock"] = { dict = "random@shop_robbery_reactions@", anim = "shock", walk = false, loop = false },
	["good"] = { dict = "missclothing", anim = "good_choice_storeclerk", walk = false, loop = false },
	["sunbathem"] = { dict = "amb@world_human_sunbathe@male@back@idle_a", anim = "idle_c", walk = false, loop = true },
	["jogger"] = { dict = "move_f@jogger", anim = "idle", walk = false, loop = true },
	["jogger2"] = { dict = "move_m@jogger", anim = "idle", walk = false, loop = true },
	["swatch"] = { dict = "amb@world_human_strip_watch_stand@male_c@idle_a", anim = "idle_b", walk = false, loop = true },
	["musculo"] = { dict = "oddjobs@assassinate@multi@", anim = "idle_a", walk = false, loop = false },
	["lookplan"] = { dict = "missheist_agency2aig_4", anim = "look_plan_c_worker2", walk = false, loop = true },
	["thanks"] = { dict = "random@arrests", anim = "thanks_male_05", walk = false, loop = false },
	["parachoque"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "imp_prop_impexp_front_bumper_02a", walk = true, loop = true, flag = 49, mao = 28422, pos1 = 0.0, pos2 = 0.1, pos3 = 0.05, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0, propAnim = true },
	["porta"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "imp_prop_impexp_car_door_04a", walk = true, loop = true, flag = 49, mao = 28422, pos1 = -0.5, pos2 = -0.15, pos3 = -0.1, pos4 = 0.0, pos5 = 0.0, pos6 = 90.0, propAnim = true },
	["porta2"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_car_door_02", walk = true, loop = true, flag = 49, mao = 28422, pos1 = 0.0, pos2 = -0.1, pos3 = -0.15, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0, propAnim = true },
	["porta3"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_car_door_03", walk = true, loop = true, flag = 49, mao = 28422, pos1 = 0.0, pos2 = -0.1, pos3 = -0.15, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0, propAnim = true },
	["porta4"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_car_door_04", walk = true, loop = true, flag = 49, mao = 28422, pos1 = 0.0, pos2 = -0.1, pos3 = -0.15, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0, propAnim = true },
	["banco"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_car_seat", walk = true, loop = true, flag = 49, mao = 28422, pos1 = 0.0, pos2 = -0.2, pos3 = -0.14, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0, propAnim = true },
	["pneu"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_wheel_tyre", walk = true, loop = true, flag = 49, mao = 28422, pos1 = 0.0, pos2 = -0.1, pos3 = -0.15, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0, propAnim = true },
	["pneu2"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_wheel_03", walk = true, loop = true, flag = 49, mao = 28422, pos1 = 0.0, pos2 = -0.1, pos3 = -0.15, pos4 = 0.0, pos5 = 0.0, pos6 = 0.0, propAnim = true },
	["pneu3"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "imp_prop_impexp_tyre_01a", flag = 49, mao = 28422, pos1 = -0.02, pos2 = -0.1, pos3 = 0.2, pos4 = 10.0, pos5 = 0.0, pos6 = 0.0 },
	["bateria"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_car_battery_01", flag = 50, mao = 28422 },
	["mecanico"] = { dict = "amb@world_human_vehicle_mechanic@male@idle_a", anim = "idle_a", walk = false, loop = true },
	["mecanico2"] = { dict = "mini@repair", anim = "fixing_a_player", walk = false, loop = true },
	["mecanico3"] = { dict = "mini@repair", anim = "fixing_a_ped", walk = false, loop = true },
	["mecanico4"] = { dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", walk = false, loop = true },
	["mecanico5"] = { dict = "amb@prop_human_movie_bulb@base", anim = "base", walk = true, loop = true },
	["mecanico6"] = { dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", walk = true, loop = true }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMOTES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("emotes")
AddEventHandler("emotes", function(Name)
	local Ped = PlayerPedId()
	if Anims[Name] and not IsPedArmed(Ped, 7) and not IsPedSwimming(Ped) and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Cancel"] and not LocalPlayer["state"]["Handcuff"] then
		vRP.Destroy("one")

		if not IsPedInAnyVehicle(Ped) and not Anims[Name]["cars"] then
			if Anims[Name]["altura"] and not Anims[Name]["anim"] then
				vRP.CreateObjects("", "", Anims[Name]["prop"], Anims[Name]["flag"], Anims[Name]["mao"], Anims[Name]["altura"], Anims[Name]["pos1"], Anims[Name]["pos2"], Anims[Name]["pos3"], Anims[Name]["pos4"], Anims[Name]["pos5"])
			elseif Anims[Name]["altura"] and Anims[Name]["anim"] then
				vRP.CreateObjects(Anims[Name]["dict"], Anims[Name]["anim"], Anims[Name]["prop"], Anims[Name]["flag"], Anims[Name]["mao"], Anims[Name]["altura"], Anims[Name]["pos1"], Anims[Name]["pos2"], Anims[Name]["pos3"], Anims[Name]["pos4"], Anims[Name]["pos5"])
			elseif Anims[Name]["prop"] then
				vRP.CreateObjects(Anims[Name]["dict"], Anims[Name]["anim"], Anims[Name]["prop"], Anims[Name]["flag"], Anims[Name]["mao"])
			elseif Anims[Name]["dict"] then
				vRP.PlayAnim(Anims[Name]["walk"], { Anims[Name]["dict"], Anims[Name]["anim"] }, Anims[Name]["loop"])
			else
				vRP.PlayAnim(false, { task = Anims[Name]["anim"] }, false)
			end
		else
			if IsPedInAnyVehicle(Ped) and Anims[Name]["cars"] then
				local Vehicle = GetVehiclePedIsUsing(Ped)

				if (GetPedInVehicleSeat(Vehicle, -1) == Ped or GetPedInVehicleSeat(Vehicle, 1) == Ped) and Name == "sexo4" then
					vRP.PlayAnim(Anims[Name]["walk"], { Anims[Name]["dict"], Anims[Name]["anim"] }, Anims[Name]["loop"])
				elseif (GetPedInVehicleSeat(Vehicle, 0) == Ped or GetPedInVehicleSeat(Vehicle, 2) == Ped) and (Name == "sexo5" or Name == "sexo6") then
					vRP.PlayAnim(Anims[Name]["walk"], { Anims[Name]["dict"], Anims[Name]["anim"] }, Anims[Name]["loop"])
				elseif Name == "hotwired" then
					vRP.PlayAnim(Anims[Name]["walk"], { Anims[Name]["dict"], Anims[Name]["anim"] }, Anims[Name]["loop"])
				end
			end
		end
	end
end)