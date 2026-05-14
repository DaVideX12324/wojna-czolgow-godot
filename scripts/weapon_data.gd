# weapon_data.gd
# Auto-generated from eu-8.java (Procyon decompile of Wojna Czołgów)
# Każdy wpis: id -> { name, key, damage, damage_arm, radius, price, min_rank, tech, category, desc }

extends Node

const WEAPONS = {
	0:  { "name": "Brak",                   "key": "w_none",             "damage": 0,   "damage_arm": 0,   "radius": 0,   "price": 0,       "min_rank": 127, "tech": -1,  "category": "none" },
	1:  { "name": "Mały pocisk",             "key": "w_zwykla",           "damage": 40,  "damage_arm": 50,  "radius": 0,   "price": 0,       "min_rank": 0,   "tech": 0,   "category": "projectile",
	      "desc": "Podstawowe kule. Masz ich bez liku, ale zadają małe obrażenia." },
	2:  { "name": "Duży pocisk",             "key": "w_duza",             "damage": 110, "damage_arm": 140, "radius": 80,  "price": 0,       "min_rank": 0,   "tech": 1,   "category": "projectile",
	      "desc": "Powiększone kule o zwiększonym rażeniu." },
	3:  { "name": "Pocisk ziemny",           "key": "w_ziemny",           "damage": 0,   "damage_arm": 0,   "radius": 25,  "price": 25,      "min_rank": 1,   "tech": 0,   "category": "terrain",
	      "desc": "Bomba ziemna pozwala usypać wzniesienie bądź zasypać nim wroga." },
	4:  { "name": "D. Pocisk ziemny",        "key": "w_ziemnyduzy",       "damage": 0,   "damage_arm": 0,   "radius": 40,  "price": 40,      "min_rank": 5,   "tech": 1,   "category": "terrain",
	      "desc": "Powiększona wersja Bomby ziemnej." },
	5:  { "name": "Antymateria",             "key": "w_antymateria",      "damage": 0,   "damage_arm": 0,   "radius": 25,  "price": 25,      "min_rank": 1,   "tech": 0,   "category": "terrain",
	      "desc": "Usuwa ziemię w obszarze rażenia nie powodując uszkodzeń czołgów." },
	6:  { "name": "Duża Antymateria",        "key": "w_antymateriaduza",  "damage": 0,   "damage_arm": 0,   "radius": 40,  "price": 40,      "min_rank": 5,   "tech": 1,   "category": "terrain",
	      "desc": "Powiększona wersja anty-ziemi." },
	7:  { "name": "Ściana z ziemi",          "key": "w_sciana",           "damage": 0,   "damage_arm": 0,   "radius": 150, "price": 150,     "min_rank": 6,   "tech": 4,   "category": "terrain",
	      "desc": "Ściana piasku. W miejscu trafienia powstaje wysoka i cienka ściana." },
	8:  { "name": "Salwa 5 pocisków",        "key": "w_5xzwykla",         "damage": 40,  "damage_arm": 50,  "radius": 110, "price": 110,     "min_rank": 4,   "tech": 2,   "category": "projectile",
	      "desc": "Kule składające się z 5 odłamków wylatujących jednocześnie z lufy." },
	9:  { "name": "5 Dużych pocisków",       "key": "w_5xduza",           "damage": 110, "damage_arm": 140, "radius": 400, "price": 400,     "min_rank": 8,   "tech": 2,   "category": "projectile",
	      "desc": "Powiększony zestaw 5 odłamków wylatujących jednocześnie z lufy." },
	10: { "name": "MIRV",                    "key": "w_MIRV",             "damage": 40,  "damage_arm": 50,  "radius": 130, "price": 130,     "min_rank": 7,   "tech": 2,   "category": "projectile",
	      "desc": "Pocisk MIRV rozrywający się na kawałki podczas opadania. Razi obszar nad którym wybucha." },
	11: { "name": "Duży MIRV",               "key": "w_MIRVduzy",         "damage": 110, "damage_arm": 140, "radius": 400, "price": 400,     "min_rank": 11,  "tech": 2,   "category": "projectile",
	      "desc": "Powiększona wersja Pocisku MIRV." },
	12: { "name": "Bomba odłamkowa",         "key": "w_odlamkowy",        "damage": 40,  "damage_arm": 50,  "radius": 110, "price": 110,     "min_rank": 4,   "tech": 3,   "category": "projectile",
	      "desc": "Po trafieniu w cel rozrywa się na szereg mniejszych." },
	13: { "name": "Skoczek",                 "key": "w_skoczek",          "damage": 56,  "damage_arm": 70,  "radius": 90,  "price": 90,      "min_rank": 5,   "tech": 3,   "category": "projectile",
	      "desc": "Bomba skacząca, zdolna do 5 odbić od terenu." },
	14: { "name": "Kręcioł",                 "key": "w_kreciol",          "damage": 48,  "damage_arm": 60,  "radius": 70,  "price": 70,      "min_rank": 2,   "tech": 3,   "category": "projectile",
	      "desc": "Bomba staczająca się po zboczu. Wybucha w kontakcie z czołgiem lub w najniższym punkcie terenu." },
	15: { "name": "Tarcza podstawowa",       "key": "w_tzwykla",          "damage": 0,   "damage_arm": 0,   "radius": 250, "price": 250,     "min_rank": 0,   "tech": 5,   "category": "shield",
	      "desc": "Detonuje pociski zanim dolecą do celu i pochłania znaczną część siły wybuchu." },
	16: { "name": "Tarcza pełna",            "key": "w_tpelna",           "damage": 0,   "damage_arm": 0,   "radius": 600, "price": 600,     "min_rank": 9,   "tech": 5,   "category": "shield",
	      "desc": "Pełna tarcza chroniąca czołg ze wszystkich kierunków." },
	17: { "name": "Tarcza odbijająca",       "key": "w_todbijajaca",      "damage": 0,   "damage_arm": 0,   "radius": 350, "price": 350,     "min_rank": 2,   "tech": 5,   "category": "shield",
	      "desc": "Tarcza odbijająca pociski lecące w kierunku czołgu." },
	18: { "name": "Tarcza załamująca",       "key": "w_tzalamujaca",      "damage": 0,   "damage_arm": 0,   "radius": 100, "price": 100,     "min_rank": 6,   "tech": 5,   "category": "shield",
	      "desc": "Odchyla tor lotu pocisków nadlatujących z góry. Chroni czołg jedynie od góry." },
	19: { "name": "Tarcza teleportująca",    "key": "w_tteleportujaca",   "damage": 0,   "damage_arm": 0,   "radius": 550, "price": 550,     "min_rank": 12,  "tech": 5,   "category": "shield",
	      "desc": "Teleportuje pociski z otoczenia czołgu w losowy punkt mapy. Chroni ze wszystkich stron." },
	20: { "name": "Paliwo",                  "key": "w_paliwo",           "damage": 0,   "damage_arm": 0,   "radius": 10,  "price": 10,      "min_rank": 0,   "tech": -1,  "category": "utility",
	      "desc": "Paliwo niezbędne do poruszania się po mapie." },
	21: { "name": "Spadochron",              "key": "w_spadochron",       "damage": 0,   "damage_arm": 0,   "radius": 400, "price": 400,     "min_rank": 3,   "tech": 4,   "category": "utility",
	      "desc": "Jednorazowy spadochron chroniący czołg przed gwałtownymi upadkami." },
	22: { "name": "Znaczniki",               "key": "w_marker",           "damage": 0,   "damage_arm": 0,   "radius": 10,  "price": 10,      "min_rank": 1,   "tech": 0,   "category": "utility",
	      "desc": "Znacznik pomagający dobrać optymalny kąt wystrzału." },
	23: { "name": "Elektro-Magnetyk",        "key": "w_EMP",              "damage": 0,   "damage_arm": 0,   "radius": 125, "price": 125,     "min_rank": 10,  "tech": 4,   "category": "special",
	      "desc": "Impuls elektromagnetyczny niszczący włączoną elektronikę. Świetnie do usuwania tarcz wrogów." },
	24: { "name": "Nowa elektronika",        "key": "w_elektro",          "damage": 0,   "damage_arm": 0,   "radius": 999999999, "price": 5000, "min_rank": 5, "tech": 900, "category": "upgrade",
	      "desc": "Nowy komputer celowniczy (likwiduje limit czasu)." },
	25: { "name": "Ciężki pancerz",          "key": "w_pancerz",          "damage": 0,   "damage_arm": 0,   "radius": 999999999, "price": 5000, "min_rank": 5, "tech": 900, "category": "upgrade",
	      "desc": "Zwiększa odporność na obrażenia." },
	26: { "name": "Duży bak",                "key": "w_bak",              "damage": 0,   "damage_arm": 0,   "radius": 999999999, "price": 5000, "min_rank": 5, "tech": 900, "category": "upgrade",
	      "desc": "Dodatkowy zbiornik paliwa. Zwiększa ilość paliwa na pokładzie." },
	27: { "name": "Lepszy generator tarcz",  "key": "w_generatortarcz",   "damage": 0,   "damage_arm": 0,   "radius": 999999999, "price": 5000, "min_rank": 5, "tech": 900, "category": "upgrade",
	      "desc": "Zmniejsza ilość energii zużywanej przez tarcze." },
	28: { "name": "Auto-Obrona",             "key": "w_autodefense",      "damage": 0,   "damage_arm": 0,   "radius": 999999999, "price": 5000, "min_rank": 5, "tech": 900, "category": "upgrade",
	      "desc": "Pozwala włączyć tarcze przed rozpoczęciem bitwy." },
	29: { "name": "Zdalna detonacja",        "key": "w_remotedetonation",  "damage": 0,   "damage_arm": 0,   "radius": 999999999, "price": 5000, "min_rank": 5, "tech": 900, "category": "upgrade",
	      "desc": "Pozwala zneutralizować część pocisków nim te dosięgną celu." },
	30: { "name": "Silniejsze C4",           "key": "w_proch",            "damage": 0,   "damage_arm": 0,   "radius": 999999999, "price": 5000, "min_rank": 5, "tech": 900, "category": "upgrade",
	      "desc": "Zwiększa o 25% obrażenia zadawane przez wybuchające pociski." },
	31: { "name": "Bomba teleportująca",     "key": "w_teleportation",    "damage": 110, "damage_arm": 140, "radius": 999999, "price": 999999, "min_rank": 127, "tech": 1000, "category": "special_drop",
	      "desc": "Teleportuje fragment przestrzeni w losowy punkt mapy. Widowiskowa i skuteczna." },
	32: { "name": "Crazy Ivan",              "key": "w_crazyIvan",        "damage": 110, "damage_arm": 140, "radius": 999999, "price": 999999, "min_rank": 127, "tech": 1000, "category": "special_drop",
	      "desc": "Pocisk rozrywa się nad ziemią na mniejsze kule losowego typu. Broń zaskakująca i skuteczna." },
	33: { "name": "Deszcz MIRV",             "key": "w_MIRVrain",         "damage": 110, "damage_arm": 140, "radius": 999999, "price": 999999, "min_rank": 127, "tech": 1000, "category": "special_drop",
	      "desc": "Zasypuje obszar gradem pocisków. Praktycznie całkowicie wypala rażony obszar." },
	34: { "name": "Bomba Tesli",             "key": "w_tesla",            "damage": 120, "damage_arm": 150, "radius": 999999, "price": 999999, "min_rank": 127, "tech": 1000, "category": "special_drop",
	      "desc": "Potężny ładunek energii elektrycznej, którego żadna tarcza nie powstrzyma." },
}

# Technologie odblokowujące kategorie broni (fa.ap[])
const TECH_TREE = {
	0: { "name": "Podstawowa",  "price": 0,     "desc": "Wymagana do: Małego pocisku, Znaczników, Ziemnego, Antymaterii" },
	1: { "name": "Powiększona", "price": 45000, "desc": "Wymagana do: Dużego pocisku, Dużego ziemnego, Dużej antymaterii" },
	2: { "name": "Multi",       "price": 70000, "desc": "Wymagana do: Salwy 5, 5x Dużych, MIRV, Dużego MIRV" },
	3: { "name": "Wykręty",     "price": 25000, "desc": "Wymagana do: Odłamkowej, Skoczka, Kręcioła" },
	4: { "name": "Ochrona",     "price": 20000, "desc": "Wymagana do: Ściany, Spadochronu, EMP" },
	5: { "name": "Tarcze",      "price": 99000, "desc": "Wymagana do: wszystkich tarcz" },
}

func get_weapon(id: int) -> Dictionary:
	return WEAPONS.get(id, WEAPONS[0])

func get_damage(id: int, armored: bool) -> int:
	var w = get_weapon(id)
	return w["damage_arm"] if armored else w["damage"]

func get_radius(id: int) -> int:
	return get_weapon(id).get("radius", 0)

func is_projectile(id: int) -> bool:
	return get_weapon(id).get("category", "") in ["projectile", "special_drop"]

func is_shield(id: int) -> bool:
	return get_weapon(id).get("category", "") == "shield"

func is_terrain_weapon(id: int) -> bool:
	return get_weapon(id).get("category", "") == "terrain"
