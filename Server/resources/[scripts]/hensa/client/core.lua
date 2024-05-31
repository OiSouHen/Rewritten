-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local TheNpcControl = 0.5
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {
	{ 280.38, -584.45, 43.29, 80, 59, "Hospital", 0.5 },
	{ -247.42, 6331.39, 32.42, 80, 59, "Hospital", 0.5 },

	{ 76.99,-194.58,54.49, 225, 43, "Garagem", 0.6 },
	{ -1686.58,26.39,64.38, 225, 43, "Garagem", 0.6 },
	{ -616.03,-1209.16,14.2, 225, 43, "Garagem", 0.6 },
	{ 964.11,-1035.85,40.83, 225, 43, "Garagem", 0.6 },
	{ 453.0,-1917.46,24.7, 225, 43, "Garagem", 0.6 },
	{ 1700.43,3766.2,34.42, 225, 43, "Garagem", 0.6 },
	{ -197.57,6233.16,31.49, 225, 43, "Garagem", 0.6 },
	{ 1109.02,2660.88,37.98, 225, 43, "Garagem", 0.6 },

	{ -1204.85,-1564.27,4.6, 126, 13, "Academia", 0.6 },

	{ 1852.16,2582.58,45.66, 60, 10, "Departamento Policial", 0.6 },
	{ 426.57,-981.71,30.7, 60, 10, "Departamento Policial", 0.6 },

	{ 234.11,216.26,106.29, 108, 24, "Banco Central", 0.7 },
	{ -109.99,6463.55,31.63, 108, 24, "Banco Central", 0.7 },

	{ 29.2,-1351.89,29.34, 52, 36, "Loja de Departamento", 0.6 },
	{ 2561.74,385.22,108.61, 52, 36, "Loja de Departamento", 0.6 },
	{ 1160.21,-329.4,69.03, 52, 36, "Loja de Departamento", 0.6 },
	{ -711.99,-919.96,19.01, 52, 36, "Loja de Departamento", 0.6 },
	{ -54.56,-1758.56,29.05, 52, 36, "Loja de Departamento", 0.6 },
	{ 375.87,320.04,103.42, 52, 36, "Loja de Departamento", 0.6 },
	{ -3237.48,1004.72,12.45, 52, 36, "Loja de Departamento", 0.6 },
	{ 1730.64,6409.67,35.0, 52, 36, "Loja de Departamento", 0.6 },
	{ 543.51,2676.85,42.14, 52, 36, "Loja de Departamento", 0.6 },
	{ 1966.53,3737.95,32.18, 52, 36, "Loja de Departamento", 0.6 },
	{ 2684.73,3281.2,55.23, 52, 36, "Loja de Departamento", 0.6 },
	{ 1696.12,4931.56,42.07, 52, 36, "Loja de Departamento", 0.6 },
	{ -1820.18,785.69,137.98, 52, 36, "Loja de Departamento", 0.6 },
	{ 1395.35,3596.6,34.86, 52, 36, "Loja de Departamento", 0.6 },
	{ -2977.14,391.22,15.03, 52, 36, "Loja de Departamento", 0.6 },
	{ -3034.99,590.77,7.8, 52, 36, "Loja de Departamento", 0.6 },
	{ 1144.46,-980.74,46.19, 52, 36, "Loja de Departamento", 0.6 },
	{ 1166.06,2698.17,37.95, 52, 36, "Loja de Departamento", 0.6 },
	{ -1493.12,-385.55,39.87, 52, 36, "Loja de Departamento", 0.6 },
	{ -1228.6,-899.7,12.27, 52, 36, "Loja de Departamento", 0.6 },

	{ 1692.27,3760.91,34.69, 269, 6, "Loja de Armas", 0.7 },
	{ 253.8,-50.47,69.94, 269, 6, "Loja de Armas", 0.7 },
	{ 842.54,-1035.25,28.19, 269, 6, "Loja de Armas", 0.7 },
	{ -331.67,6084.86,31.46, 269, 6, "Loja de Armas", 0.7 },
	{ -662.37,-933.58,21.82, 269, 6, "Loja de Armas", 0.7 },
	{ -1304.12,-394.56,36.7, 269, 6, "Loja de Armas", 0.7 },
	{ -1118.98,2699.73,18.55, 269, 6, "Loja de Armas", 0.7 },
	{ 2567.98,292.62,108.73, 269, 6, "Loja de Armas", 0.7 },
	{ -3173.51,1088.35,20.84, 269, 6, "Loja de Armas", 0.7 },
	{ 22.53,-1105.52,29.79, 269, 6, "Loja de Armas", 0.7 },
	{ 810.22,-2158.99,29.62, 269, 6, "Loja de Armas", 0.7 },

	{ -815.12,-184.15,37.57, 71, 62, "Barbearia", 0.5 },
	{ 139.56,-1704.12,29.05, 71, 62, "Barbearia", 0.5 },
	{ -1278.11,-1116.66,6.75, 71, 62, "Barbearia", 0.5 },
	{ 1928.89,3734.04,32.6, 71, 62, "Barbearia", 0.5 },
	{ 1217.05,-473.45,65.96, 71, 62, "Barbearia", 0.5 },
	{ -34.08,-157.01,56.83, 71, 62, "Barbearia", 0.5 },
	{ -274.5,6225.27,31.45, 71, 62, "Barbearia", 0.5 },

	{ -1081.43,-249.57,37.76, 489, 51, "Life Invader", 0.7 },

	{ 220.98,-1844.86,27.18, 478, 31, "Loja de Usados", 0.7 },

	{ 86.06,-1391.64,29.23, 366, 62, "Loja de Roupas", 0.5 },
	{ -719.94,-158.18,37.0, 366, 62, "Loja de Roupas", 0.5 },
	{ -152.79,-306.79,38.67, 366, 62, "Loja de Roupas", 0.5 },
	{ -816.39,-1081.22,11.12, 366, 62, "Loja de Roupas", 0.5 },
	{ -1206.51,-781.5,17.12, 366, 62, "Loja de Roupas", 0.5 },
	{ -1458.26,-229.79,49.2, 366, 62, "Loja de Roupas", 0.5 },
	{ -2.41,6518.29,31.48, 366, 62, "Loja de Roupas", 0.5 },
	{ 1682.59,4819.98,42.04, 366, 62, "Loja de Roupas", 0.5 },
	{ 129.46,-205.18,54.51, 366, 62, "Loja de Roupas", 0.5 },
	{ 618.49,2745.54,42.01, 366, 62, "Loja de Roupas", 0.5 },
	{ 1197.93,2698.21,37.96, 366, 62, "Loja de Roupas", 0.5 },
	{ -3165.74,1061.29,20.84, 366, 62, "Loja de Roupas", 0.5 },
	{ -1093.76,2703.99,19.04, 366, 62, "Loja de Roupas", 0.5 },
	{ 414.86,-807.57,29.34, 366, 62, "Loja de Roupas", 0.5 },

	{ -1728.06,-1050.69,1.71, 356, 62, "Embarcações", 0.6 },
	{ -776.72,-1495.02,2.29, 356, 62, "Embarcações", 0.6 },
	{ -893.97,5687.78,3.29, 356, 62, "Embarcações", 0.6 },
	{ 1509.64,3788.7,33.51, 356, 62, "Embarcações", 0.6 },

	{ 91.9,-230.88,54.66, 403, 34, "Farmácia", 0.7 },

	{ -428.56,-1728.33,19.79, 467, 11, "Reciclagem", 0.7 },
	{ 180.07,2793.29,45.65, 467, 11, "Reciclagem", 0.7 },
	{ -195.42,6264.62,31.49, 467, 11, "Reciclagem", 0.7 },

	{ 408.98,-1622.71,29.28, 357, 9, "Reboque", 0.6 },

	{ -656.67,-858.73,24.48, 459, 39, "Digital Den", 0.7 },

	{ -361.85,-132.89,38.67, 402, 18, "Mecânica", 0.7 },
	{ -1142.1,-1987.5,13.16, 402, 18, "Mecânica", 0.7 },
	{ 1178.96,2651.42,37.81, 402, 18, "Mecânica", 0.7 },
	{ 116.95,6615.26,31.85, 402, 18, "Mecânica", 0.7 },
	{ 718.03,-1088.61,22.36, 402, 18, "Mecânica", 0.7 },
	{ -205.64,-1306.65,31.31, 402, 18, "Mecânica", 0.7 },

	{ 2101.75,2322.74,94.53, 515, 10, "Central de Eletricidade", 0.7 },

	{ 562.36,2741.56,42.87, 273, 11, "Animal Park", 0.5 },

	{ 827.1,5426.91,485.51, 141, 51, "Área de Caça", 0.7 },
	{ -2080.6,1357.4,257.87, 141, 51, "Área de Caça", 0.7 },

	{ -679.13,5839.52,17.3, 141, 51, "Cabana de Caça", 0.7 },

	{ 29.28,-1230.81,29.91, 486, 13, "Área Perigosa", 0.6 },
	{ 349.88,-1099.39,29.42, 486, 13, "Área Perigosa", 0.6 },
	{ -1040.45,-1595.09,4.75, 486, 13, "Área Perigosa", 0.6 },
	{ -966.05,315.08,70.13, 486, 13, "Área Perigosa", 0.6 },
	{ -555.46,302.18,82.87, 486, 13, "Área Perigosa", 0.6 },
	{ 626.89,73.84,89.57, 486, 13, "Área Perigosa", 0.6 },
	{ 1088.39,-771.85,57.53, 486, 13, "Área Perigosa", 0.6 },
	{ 1190.04,-1821.12,37.12, 486, 13, "Área Perigosa", 0.6 },
	{ 372.2,-2132.46,15.91, 486, 13, "Área Perigosa", 0.6 },
	{ -1110.18,-1993.49,12.81, 486, 13, "Área Perigosa", 0.6 },
	{ -1445.39,-682.23,26.02, 486, 13, "Área Perigosa", 0.6 },

	{ 1327.98,-1654.78,52.03, 75, 13, "Loja de Tatuagem", 0.5 },
	{ -1149.04,-1428.64,4.71, 75, 13, "Loja de Tatuagem", 0.5 },
	{ 322.01,186.24,103.34, 75, 13, "Loja de Tatuagem", 0.5 },
	{ -3175.64,1075.54,20.58, 75, 13, "Loja de Tatuagem", 0.5 },
	{ 1866.01,3748.07,32.79, 75, 13, "Loja de Tatuagem", 0.5 },
	{ -295.51,6199.21,31.24, 75, 13, "Loja de Tatuagem", 0.5 },

	{ 1654.84,4862.14,41.99, 76, 62, "Loja de Frutas", 0.5 },

	{ -1177.93,-884.13,13.88, 439, 62, "Restaurante", 0.7 },

	{ -364.41,-249.27,36.08, 351, 16, "Central de Empregos", 0.9 },

	{ -70.49,-1104.59,26.12, 89, 66, "Concessionária", 0.5 },

	{ -535.04,-221.34,37.64, 267, 5,  "Prefeitura", 0.6 },

	{ -37.95,-205.64,45.78, 380, 81, "Auto Escola", 0.8 },

	{ -628.79,-238.7,38.05, 617, 84, "Joalheria", 0.6 },

	{ -237.81,6545.23,2.07, 68, 18, "Pescador", 0.7 },

	{ 282.23,6792.7,15.69, 78, 21, "Mergulhador", 0.6 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALPHAS
-----------------------------------------------------------------------------------------------------------------------------------------
local Alphas = {
	-- Impound
	{ vec3(405.21, -1638.34, 29.28), 100, 9, 15.0 },

	-- War Zones
	{ vec3(2954.97, 2807.08, 41.75), 100, 72, 150.0 },
	{ vec3(3533.77, 3720.49, 28.36), 100, 72, 150.0 },

	-- Car Wash
	{ vec3(24.27, -1391.96, 28.7), 200, 54, 15.0 },
	{ vec3(167.69, -1715.92, 28.66), 200, 54, 15.0 },
	{ vec3(-699.86, -932.84, 18.38), 200, 54, 15.0 },

	-- Speed Cameras
	{ vec3(348.72, -1921.64, 24.2), 200, 76, 15.0 },
	{ vec3(945.37, -1935.09, 30.46), 200, 76, 15.0 },
	{ vec3(1280.27, -1504.25, 40.05), 200, 76, 15.0 },
	{ vec3(145.67, -1614.32, 28.83), 200, 76, 15.0 },
	{ vec3(310.92, 155.6, 103.32), 200, 76, 15.0 },
	{ vec3(-441.11, 244.36, 82.58), 200, 76, 15.0 },
	{ vec3(-2690.74, -39.01, 15.3), 200, 76, 15.0 },
	{ vec3(-1468.19, -104.2, 50.36), 200, 76, 15.0 },
	{ vec3(774.04, -743.38, 26.96), 200, 76, 15.0 },
	{ vec3(-638.7, -837.08, 24.42), 200, 76, 15.0 },
	{ vec3(-632.22, -373.37, 34.31), 200, 76, 15.0 },
	{ vec3(-227.22, -1003.37, 28.83), 200, 76, 15.0 },
	{ vec3(154.36, -1019.31, 28.88), 200, 76, 15.0 },
	{ vec3(73.64, -164.13, 54.61), 200, 76, 15.0 },
	{ vec3(394.65, -592.25, 28.27), 200, 76, 15.0 },
	{ vec3(-521.92, -1770.01, 21.42), 200, 76, 15.0 },
	{ vec3(2578.46, 4245.33, 41.8), 200, 76, 15.0 },
	{ vec3(1578.62, -980.07, 60.09), 200, 76, 15.0 },
	{ vec3(2134.19, -572.18, 95.1), 200, 76, 15.0 },
	{ vec3(714.88, 6511.94, 27.41), 200, 76, 15.0 },
	{ vec3(-2658.32, 2632.84, 16.68), 200, 76, 15.0 },
	{ vec3(2559.33, 5399.29, 44.21), 200, 76, 15.0 },
	{ vec3(2654.56, 4938.91, 44.4), 200, 76, 15.0 },

	-- Ilegal
	{ vec3(-472.08, 6287.5, 14.63), 200, 59, 20.0 },

	-- Gas Stations
	{ vec3(265.09, -1258.94, 29.13), 200, 34, 20.0 },
	{ vec3(-2097.61, -320.57, 13.16), 200, 34, 20.0 },
	{ vec3(-2555.19, 2334.31, 33.08), 200, 34, 20.0 },
	{ vec3(179.99, 6602.84, 31.86), 200, 34, 20.0 },
	{ vec3(818.92, -1028.65, 26.89), 200, 34, 20.0 },
	{ vec3(1207.05, -1403.68, 36.26), 200, 34, 20.0 },
	{ vec3(1181.61, -330.8, 69.78), 200, 34, 20.0 },
	{ vec3(619.47, 270.18, 103.26), 200, 34, 20.0 },
	{ vec3(2581.01, 362.42, 108.88), 200, 34, 20.0 },
	{ vec3(174.86, -1562.55, 29.87), 200, 34, 20.0 },
	{ vec3(-319.25, -1470.23, 30.5), 200, 34, 20.0 },
	{ vec3(1786.08, 3329.86, 40.42), 200, 34, 20.0 },
	{ vec3(48.92, 2779.59, 57.05), 200, 34, 20.0 },
	{ vec3(264.98, 2607.18, 43.99), 200, 34, 20.0 },
	{ vec3(1039.9, 2671.05, 39.53), 200, 34, 20.0 },
	{ vec3(1208.52, 2659.43, 36.9), 200, 34, 20.0 },
	{ vec3(2539.8, 2594.81, 36.96), 200, 34, 20.0 },
	{ vec3(2006.21, 3774.96, 31.4), 200, 34, 20.0 },
	{ vec3(1690.1, 4927.81, 41.23), 200, 34, 20.0 },
	{ vec3(1701.73, 6416.49, 31.77), 200, 34, 20.0 },
	{ vec3(-91.29, 6422.54, 30.65), 200, 34, 20.0 },
	{ vec3(-1797.22, 800.56, 137.66), 200, 34, 20.0 },
	{ vec3(-1435.5, -284.68, 45.41), 200, 34, 20.0 },
	{ vec3(-732.64, -939.32, 18.22), 200, 34, 20.0 },
	{ vec3(-524.92, -1216.15, 17.33), 200, 34, 20.0 },
	{ vec3(-69.45, -1758.01, 28.55), 200, 34, 20.0 },

	-- Scuba
	{ vec3(767.19, 7192.03, -30.16), 200, 21, 100.0 },

	-- Fishing
	{ vec3(-315.33, 6588.65, -0.47), 200, 18, 30.0 },

	-- Caça
	{ vec3(827.1,5426.91,485.51), 200, 51, 700.0 },
	{ vec3(-2080.6,1357.4,257.87), 200, 51, 500.0 },

	-- Influence
	{ vec3(349.88,-1099.39,29.42), 200, 58, 100.0 },
	{ vec3(29.28,-1230.81,29.91), 200, 58, 100.0 },
	{ vec3(-1040.45,-1595.09,4.75), 200, 58, 100.0 },
	{ vec3(-966.05,315.08,70.13), 200, 58, 100.0 },
	{ vec3(-555.46,302.18,82.87), 200, 58, 100.0 },
	{ vec3(626.89,73.84,89.57), 200, 58, 100.0 },
	{ vec3(1088.39,-771.85,57.53), 200, 58, 100.0 },
	{ vec3(1190.04,-1821.12,37.12), 200, 58, 100.0 },
	{ vec3(372.2,-2132.46,15.91), 200, 58, 100.0 },
	{ vec3(-1110.18,-1993.49,12.81), 200, 58, 100.0 },
	{ vec3(-1445.39,-682.23,26.02), 200, 58, 100.0 },

	-- Bikes
	{ vec3(156.44, -1065.79, 30.04), 200, 56, 10.0 },
	{ vec3(-1188.13, -1574.47, 4.35), 200, 56, 10.0 },
	{ vec3(-777.44, 5593.64, 33.63), 200, 56, 10.0 },
	{ vec3(435.06, -647.39, 28.73), 200, 56, 10.0 },
	{ vec3(-896.38, -779.06, 15.91), 200, 56, 10.0 },
	{ vec3(-1668.56, -998.63, 7.38), 200, 56, 10.0 },
	{ vec3(102.53, -1957.14, 20.74), 200, 56, 10.0 },
	{ vec3(-161.23, -1623.57, 33.65), 200, 56, 10.0 },
	{ vec3(337.84, -2036.2, 21.37), 200, 56, 10.0 },
	{ vec3(524.05, -1829.38, 28.43), 200, 56, 10.0 },
	{ vec3(232.37, -1756.87, 29.0), 200, 56, 10.0 },
	{ vec3(143.91, 6653.49, 31.53), 200, 56, 10.0 },
	{ vec3(1703.32, 4820.19, 41.97), 200, 56, 10.0 },
	{ vec3(958.53, 3618.86, 32.67), 200, 56, 10.0 },
	{ vec3(1032.52, 2656.05, 39.55), 200, 56, 10.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISLAND
-----------------------------------------------------------------------------------------------------------------------------------------
local Island = {
	"h4_islandairstrip",
	"h4_islandairstrip_props",
	"h4_islandx_mansion",
	"h4_islandx_mansion_props",
	"h4_islandx_props",
	"h4_islandxdock",
	"h4_islandxdock_props",
	"h4_islandxdock_props_2",
	"h4_islandxtower",
	"h4_islandx_maindock",
	"h4_islandx_maindock_props",
	"h4_islandx_maindock_props_2",
	"h4_IslandX_Mansion_Vault",
	"h4_islandairstrip_propsb",
	"h4_beach",
	"h4_beach_props",
	"h4_beach_bar_props",
	"h4_islandx_barrack_props",
	"h4_islandx_checkpoint",
	"h4_islandx_checkpoint_props",
	"h4_islandx_Mansion_Office",
	"h4_islandx_Mansion_LockUp_01",
	"h4_islandx_Mansion_LockUp_02",
	"h4_islandx_Mansion_LockUp_03",
	"h4_islandairstrip_hangar_props",
	"h4_IslandX_Mansion_B",
	"h4_islandairstrip_doorsclosed",
	"h4_Underwater_Gate_Closed",
	"h4_mansion_gate_closed",
	"h4_aa_guns",
	"h4_IslandX_Mansion_GuardFence",
	"h4_IslandX_Mansion_Entrance_Fence",
	"h4_IslandX_Mansion_B_Side_Fence",
	"h4_IslandX_Mansion_Lights",
	"h4_islandxcanal_props",
	"h4_beach_props_party",
	"h4_islandX_Terrain_props_06_a",
	"h4_islandX_Terrain_props_06_b",
	"h4_islandX_Terrain_props_06_c",
	"h4_islandX_Terrain_props_05_a",
	"h4_islandX_Terrain_props_05_b",
	"h4_islandX_Terrain_props_05_c",
	"h4_islandX_Terrain_props_05_d",
	"h4_islandX_Terrain_props_05_e",
	"h4_islandX_Terrain_props_05_f",
	"h4_islandx_terrain_01",
	"h4_islandx_terrain_02",
	"h4_islandx_terrain_03",
	"h4_islandx_terrain_04",
	"h4_islandx_terrain_05",
	"h4_islandx_terrain_06",
	"h4_ne_ipl_00",
	"h4_ne_ipl_01",
	"h4_ne_ipl_02",
	"h4_ne_ipl_03",
	"h4_ne_ipl_04",
	"h4_ne_ipl_05",
	"h4_ne_ipl_06",
	"h4_ne_ipl_07",
	"h4_ne_ipl_08",
	"h4_ne_ipl_09",
	"h4_nw_ipl_00",
	"h4_nw_ipl_01",
	"h4_nw_ipl_02",
	"h4_nw_ipl_03",
	"h4_nw_ipl_04",
	"h4_nw_ipl_05",
	"h4_nw_ipl_06",
	"h4_nw_ipl_07",
	"h4_nw_ipl_08",
	"h4_nw_ipl_09",
	"h4_se_ipl_00",
	"h4_se_ipl_01",
	"h4_se_ipl_02",
	"h4_se_ipl_03",
	"h4_se_ipl_04",
	"h4_se_ipl_05",
	"h4_se_ipl_06",
	"h4_se_ipl_07",
	"h4_se_ipl_08",
	"h4_se_ipl_09",
	"h4_sw_ipl_00",
	"h4_sw_ipl_01",
	"h4_sw_ipl_02",
	"h4_sw_ipl_03",
	"h4_sw_ipl_04",
	"h4_sw_ipl_05",
	"h4_sw_ipl_06",
	"h4_sw_ipl_07",
	"h4_sw_ipl_08",
	"h4_sw_ipl_09",
	"h4_islandx_mansion",
	"h4_islandxtower_veg",
	"h4_islandx_sea_mines",
	"h4_islandx",
	"h4_islandx_barrack_hatch",
	"h4_islandxdock_water_hatch",
	"h4_beach_party"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
local InfoList = {
	{
		["Props"] = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		["Coords"] = vec3(-1150.70,-1520.70,10.60)
	},{
		["Props"] = {
			"csr_beforeMission",
			"csr_inMission"
		},
		["Coords"] = vec3(-47.10,-1115.30,26.50)
	},{
		["Props"] = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		["Coords"] = vec3(-802.30,175.00,72.80)
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Pid = PlayerId()
		local Ped = PlayerPedId()

		for Number = 1,22 do
			if Number ~= 14 and Number ~= 16 then
				HideHudComponentThisFrame(Number)
			end
		end

		InvalidateIdleCam()
		InvalidateVehicleIdleCam()

		SetCreateRandomCops(false)
		CancelCurrentPoliceReport()
		BlockWeaponWheelThisFrame()
		DisableControlAction(0,37,true)
		DisableControlAction(0,204,true)
		DisableControlAction(0,211,true)
		DisableControlAction(0,349,true)
		DisableControlAction(0,192,true)
		DisableControlAction(0,157,true)
		DisableControlAction(0,158,true)
		DisableControlAction(0,159,true)
		DisableControlAction(0,160,true)
		DisableControlAction(0,161,true)
		DisableControlAction(0,162,true)
		DisableControlAction(0,163,true)
		DisableControlAction(0,164,true)
		DisableControlAction(0,165,true)

		SetVehicleDensityMultiplierThisFrame(TheNpcControl)
		SetRandomVehicleDensityMultiplierThisFrame(TheNpcControl)
		SetParkedVehicleDensityMultiplierThisFrame(TheNpcControl)
		SetScenarioPedDensityMultiplierThisFrame(TheNpcControl, TheNpcControl)
		SetPedDensityMultiplierThisFrame(TheNpcControl)

		if IsPedArmed(Ped,6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
		end

		if IsPedUsingActionMode(Ped) then
			SetPedUsingActionMode(Ped,-1,-1,1)
		end

		if IsPedInAnyVehicle(Ped) then
			DisableControlAction(0,345,true)
		end

		SetPauseMenuActive(false)
		DisablePlayerVehicleRewards(Pid)
		SetPedInfiniteAmmoClip(Ped,false)
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)

		if IsPlayerWantedLevelGreater(Pid,0) then
			ClearPlayerWantedLevel(Pid)
		end

		if not DisableTargetMode then
			SetPlayerLockonRangeOverride(Pid, 0.0)
		end

		SetArtificialLightsState(GlobalState["Blackout"])
		SetArtificialLightsStateAffectsVehicles(false)

		if LocalPlayer["state"]["Active"] then
			NetworkOverrideClockTime(GlobalState["Hours"], GlobalState["Minutes"], 00)
		else
			NetworkOverrideClockTime(12, 00, 00)
		end

		if IsPedOnFoot(GetPlayerPed(-1)) then
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			SetRadarZoom(1100)
		end

		Wait(0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			local Distance = #(Coords - vec3(253.73, 224.19, 101.91))
			if Distance <= 1.5 then
				TimeDistance = 1

				if IsControlJustPressed(1, 38) then
					local Handle, Object = FindFirstObject()
					local Finished = false

					repeat
						local Heading = GetEntityHeading(Object)
						local CoordsObj = GetEntityCoords(Object)
						local DistanceObjs = #(CoordsObj - Coords)

						if DistanceObjs < 3.0 and GetEntityModel(Object) == 961976194 then
							if Heading > 150.0 then
								SetEntityHeading(Object, 0.0)
							else
								SetEntityHeading(Object, 160.0)
							end

							FreezeEntityPosition(Object, true)
							Finished = true
						end

						Finished, Object = FindNextObject(Handle)
					until not Finished

					EndFindObject(Handle)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	SetMapZoomDataLevel(0,0.96,0.9,0.08,0.0,0.0)
	SetMapZoomDataLevel(1,1.6,0.9,0.08,0.0,0.0)
	SetMapZoomDataLevel(2,8.6,0.9,0.08,0.0,0.0)
	SetMapZoomDataLevel(3,12.3,0.9,0.08,0.0,0.0)
	SetMapZoomDataLevel(4,22.3,0.9,0.08,0.0,0.0)

	for _,v in pairs(InfoList) do
		local Interior = GetInteriorAtCoords(v["Coords"])
		LoadInterior(Interior)

		if v["Props"] then
			for _,Index in pairs(v["Props"]) do
				EnableInteriorProp(Interior,Index)
			end
		end

		RefreshInterior(Interior)
	end

	for Number = 1,#Alphas do
		local Blip = AddBlipForRadius(Alphas[Number][1]["x"],Alphas[Number][1]["y"],Alphas[Number][1]["z"],Alphas[Number][4])
		SetBlipAlpha(Blip,Alphas[Number][2])
		SetBlipColour(Blip,Alphas[Number][3])
	end

	for Number = 1,#Blips do
		local Blip = AddBlipForCoord(Blips[Number][1],Blips[Number][2],Blips[Number][3])
		SetBlipSprite(Blip,Blips[Number][4])
		SetBlipDisplay(Blip,4)
		SetBlipAsShortRange(Blip,true)
		SetBlipColour(Blip,Blips[Number][5])
		SetBlipScale(Blip,Blips[Number][7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Blips[Number][6])
		EndTextCommandSetBlipName(Blip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		if #(Coords - vec3(4840.57,-5174.42,2.0)) <= 2000 then
			if not IsIplActive("h4_islandairstrip") then
				for _,v in pairs(Island) do
					RequestIpl(v)
				end

				SetIslandHopperEnabled("HeistIsland",true)
				SetAiGlobalPathNodesType(1)
				SetDeepOceanScaler(0.0)
				LoadGlobalWaterType(1)
			end
		else
			if IsIplActive("h4_islandairstrip") then
				for _,v in pairs(Island) do
					RemoveIpl(v)
				end

				SetIslandHopperEnabled("HeistIsland",false)
				SetAiGlobalPathNodesType(0)
				SetDeepOceanScaler(1.0)
				LoadGlobalWaterType(0)
			end
		end

		for _,Entity in pairs(GetGamePool("CPed")) do
			if (NetworkGetEntityOwner(Entity) == -1 or NetworkGetEntityOwner(Entity) == PlayerId()) and GetPedArmour(Entity) <= 0 and not NetworkGetEntityIsNetworked(Entity) then
				if IsPedInAnyVehicle(Entity) then
					local Vehicle = GetVehiclePedIsUsing(Entity)
					if NetworkGetEntityIsNetworked(Vehicle) then
						TriggerServerEvent("garages:Delete",NetworkGetNetworkIdFromEntity(Vehicle),GetVehicleNumberPlateText(Vehicle))
					else
						DeleteEntity(Vehicle)
					end
				else
					DeleteEntity(Entity)
				end
			end
		end

		for _,Vehicle in pairs(GetGamePool("CVehicle")) do
			if (NetworkGetEntityOwner(Vehicle) == -1 or NetworkGetEntityOwner(Vehicle) == PlayerId()) and not NetworkGetEntityIsNetworked(Vehicle) and GetVehicleNumberPlateText(Vehicle) ~= "PDMSPORT" then
				DeleteEntity(Vehicle)
			end
		end

		for Number = 1,121 do
			EnableDispatchService(Number,false)
		end

		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRAPPEL
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyHeli(Ped) then
			TimeDistance = 1

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if IsControlJustPressed(1,154) and not IsAnyPedRappellingFromHeli(Vehicle) and (GetPedInVehicleSeat(Vehicle,1) == Ped or GetPedInVehicleSeat(Vehicle,2) == Ped) then
				TaskRappelFromHeli(Ped,1)
			end
		end

		Wait(TimeDistance)
	end
end)