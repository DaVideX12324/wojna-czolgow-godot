# rank_system.gd
# Auto-generated from fa-4.java (Procyon decompile of Wojny Czołgów)
# System rang, achievementów i zadań na awans

extends Node

# 16 rang z fa.aK
const RANKS = [
	"Rekrut",            # 0
	"Szeregowy",         # 1
	"Starszy szeregowy", # 2
	"Sierżant",          # 3
	"Starszy sierżant",  # 4
	"Chorąży",           # 5
	"Starszy chorąży",   # 6
	"Podporucznik",      # 7
	"Porucznik",         # 8
	"Kapitan",           # 9
	"Major",             # 10
	"Podpułkownik",      # 11
	"Pułkownik",         # 12
	"Generał brygady",   # 13
	"Imperator",         # 14
	"Wielki Imperator",  # 15
]

# 54 achievementy z fa.aF
const ACHIEVEMENTS = [
	"Zwykły pocisk",          # 0
	"Tarcza podstawowa",      # 1
	"Przejedź 5 km",          # 2
	"Zabij wroga",            # 3
	"Pocisk ziemny",          # 4
	"Antymateria",            # 5
	"Marker",                 # 6
	"Przekąska",              # 7
	"Mały cmentarz",          # 8
	"Użyj kręcioła",          # 9
	"Przejażdżka",            # 10
	"Prawie oczko",           # 11
	"Kwartet",                # 12
	"Broń specjalna",         # 13
	"Powiększona kula",       # 14
	"Kręcioł",                # 15
	"Lucky Luke",             # 16
	"Energooszczędny",        # 17
	"Odłamkowym ładuj",       # 18
	"Wycieczka",              # 19
	"50 skalpów",             # 20
	"Pierwsze trafienie x3",  # 21
	"Dubeltówka",             # 22
	"Przepaść",               # 23
	"5x skoczek",             # 24
	"10x duża kula",          # 25
	"10 regionów",            # 26
	"5x spaaadek",            # 27
	"25x salwa 5 pocisków",   # 28
	"5x super salwa",         # 29
	"5x nietkniętY",          # 30
	"150 trupów",             # 31
	"40x prosty pocisk",      # 32
	"10x super MIRV",         # 33
	"Potrójny traf",          # 34
	"Bania w lesie",          # 35
	"Spec od okopów",         # 36
	"25x duża salwa",         # 37
	"2 wrogów naraz",         # 38
	"Duży region życia",      # 39
	"30x skoczek",            # 40
	"300 zabitych",           # 41
	"0 jeńców",               # 42
	"25x super salwa",        # 43
	"Podbij Grecję",          # 44
	"Przetestuj EMP",         # 45
	"Specjalista uzbrojenia", # 46
	"25x super MIRV",         # 47
	"5x duży region życia",   # 48
	"40x Duży MIRV",          # 49
	"100x 1 trafienie",       # 50
	"Żołnierz specjalista",   # 51
	"50x broń specjalna",     # 52
	"Podbij Ukrainę",         # 53
]

# Opisy zadań (fa.aL)
const ACHIEVEMENT_DESC = [
	"Oddaj przynajmniej 1 strzał z broni Zwykły pocisk.",
	"Włącz przynajmniej 1 tarczę o typie Tarcza podstawowa.",
	"Przejedź czołgiem 5 km po mapie - zużycie 13 baku.",
	"Wyeliminuj przynajmniej 1 wrogi czołg.",
	"Oddaj przynajmniej 1 strzał z broni Pocisk ziemny.",
	"Oddaj przynajmniej 1 strzał z broni Antymateria.",
	"Oddaj przynajmniej 1 strzał pociskiem Marker.",
	"Powiększ swój stan posiadania o przynajmniej 1 nowy region.",
	"Rozwal co najmniej 10 wrogich czołgów.",
	"Oddaj przynajmniej 1 strzał z broni Kręcioł.",
	"Przemieść się po mapie w sumie o przynajmniej 100 km.",
	"Wyeliminuj przynajmniej 20 wrogich czołgów.",
	"Powiększ swój stan posiadania o przynajmniej 4 nowe regiony.",
	"Strzel chociaż raz z dowolnej broni specjalnej.",
	"Wymorduj przynajmniej 5 wrogich czołgów używając broni Powiększona kula.",
	"Rozwal przeciwnika przynajmniej 5 razy używając broni Kręcioł.",
	"Zabij przynajmniej jednego wroga pierwszym celnym trafieniem odbierającym cały pasek życia.",
	"Wybij wszystkich co do nogi bez utraty energii z paska życia.",
	"Pięć razy rozwal wroga z użyciem broni Pocisk odłamkowy.",
	"Powędruj trochę po mapie, przejedź przynajmniej 250 km w sumie.",
	"Ustrzel przynajmniej 50 czołgów.",
	"3 razy zniszcz wrogi czołg jednym trafieniem.",
	"Zalicz zabicie 2 wrogów jednym strzałem!",
	"Zabij przynajmniej 1 wroga zrzucając go z wysokości.",
	"Pięć razy zlikwiduj wroga z użyciem broni Skoczek.",
	"Przynajmniej 10 razy wyeliminuj wroga jednym celnym trafieniem z użyciem broni Powiększona kula.",
	"Zdobądź przynajmniej 10 nowych regionów.",
	"Przynajmniej 5 razy zabij wroga zrzucając go z wysokości.",
	"25 razy wyeliminuj wrogi czołg z użyciem broni Salwa 5 pocisków.",
	"Przynajmniej pięć razy pozbądź się wroga pierwszym trafieniem z broni Salwa 5 pocisków.",
	"Przynajmniej 5 razy wygrąj bitwę eliminując wszystkich i nie tracąc energii.",
	"Pozbądź się przynajmniej 150 wrogich czołgów!",
	"Wyeliminuj przynajmniej 40 wrogów samym prostym pociskiem.",
	"Wyeliminuj wroga 10 razy pierwszym celnym trafieniem z użyciem broni MIRV.",
	"Wyeliminuj przynajmniej 3 czołgi jednym strzałem.",
	"Przejmij wszystkie ziemie należące do Rosji i Finlandii.",
	"Przynajmniej czterdzieści razy użyj broni Duży pocisk ziemny.",
	"Wyeliminuj przynajmniej 25 razy wrogi czołg pierwszym trafieniem z broni Salwa 5 dużych pocisków.",
	"Pierwszy strzał i dwóch martwych wrogów. Potrafisz?",
	"Wygrąj wszystkie bitwy w dużym regionie (min 3 bitwy) bez utraty energii.",
	"Wyeliminuj przynajmniej 30 wrogów z użyciem broni Skoczek.",
	"Twój licznik wyeliminowanych czołgów musi pokazywać wartość 300!",
	"Wyeliminuj przynajmniej 25 razy wrogi czołg pierwszym trafieniem z broni Salwa 5 pocisków.",
	"Zajmij Olimp i wyeliminuj Greków z mapy Europy.",
	"Oddaj przynajmniej 1 strzał z broni EMP.",
	"Wykorzystaj jednorazowo wszystkie bronie specjalne.",
	"Wyeliminuj wroga 25 razy pierwszym celnym trafieniem z użyciem broni MIRV.",
	"Wygrąj 5 razy wszystkie bitwy w dużym regionie bez utraty energii.",
	"Wyeliminuj najmniej 40 wrogich czołgów z użyciem broni Duży MIRV.",
	"Zrób to nie raz, zrób to sto razy! Zniszcz wrogi czołg pierwszym celnym trafieniem.",
	"Rozwal przynajmniej 1 wroga z broni specjalnych: Crazy Ivan / Deszcz MIRV / Bomba Tesli.",
	"Za pomocą dowolnej broni specjalnej zmiażdż przynajmniej 50 wrogich czołgów.",
	"Przejmij wszystkie regiony należące do Ukrainy i wyeliminuj ich z gry.",
]

# Stan gracza
var current_rank: int = 0
var kills: int = 0
var km_traveled: float = 0.0
var regions_owned: int = 0
var perfect_wins: int = 0
var fall_kills: int = 0
var achievement_flags: Array
var tech_unlocked: Array

func _ready() -> void:
	achievement_flags = []
	achievement_flags.resize(len(ACHIEVEMENTS))
	achievement_flags.fill(false)
	tech_unlocked = []
	tech_unlocked.resize(6)
	tech_unlocked.fill(0)

func get_rank_name(rank: int = -1) -> String:
	var r = rank if rank >= 0 else current_rank
	r = clamp(r, 0, len(RANKS) - 1)
	return RANKS[r]

func unlock_achievement(idx: int) -> bool:
	if idx < 0 or idx >= len(achievement_flags):
		return false
	if achievement_flags[idx]:
		return false
	achievement_flags[idx] = true
	return true

func add_kill() -> void:
	kills += 1

func add_km(km: float) -> void:
	km_traveled += km
