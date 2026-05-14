# Wojna Czołgów - Godot 4 Port

Port klasycznej polskiej mobilnej gry turowej **Wojna Czołgów** (2011, CTSMS.pl/Wapster) do silnika **Godot 4**.

Gra jest klonem gatunku Scorched Earth / Worms — turowa artyleria czołgowa z deformacją terenu.

## Stan projektu
- [ ] Generowanie i rendering terenu
- [ ] System tur
- [ ] Mechanika strzału (kąt + moc)
- [ ] Fizyka terenu (opadanie po wybuchu)
- [ ] AI przeciwników
- [ ] HUD i UI
- [ ] Dźwięki
- [ ] Kampania / poziomy

## Mechanika (na podstawie reverse engineeringu oryginału)
- Mapa: siatka **800×600** komórek (bajt na komórkę): `0`=powietrze, `1`=ziemia, `2-4`=specjalne
- Czołgi: pozycja (m, n), HP (s/t), kąt lufy `o` (0–π rad), moc strzału `q` (10–999)
- Tura: do 24 stanów gry (celowanie, strzał, animacja, opadanie terenu, koniec rundy...)
- Deformacja terenu: po wybuchu ziemia opada grawitacyjnie (kolumna po kolumnie)
- Sterowanie: 3 tryby — celowanie, jazda, kamera

## Struktura projektu
```
project.godot
scenes/
  Battle.tscn       # Główna scena bitwy
  Tank.tscn         # Czołg (gracz i AI)
  Terrain.tscn      # Teren z deformacją
  HUD.tscn          # HUD bitwy
  MainMenu.tscn     # Menu główne
scripts/
  battle.gd         # Logika bitwy i system tur
  tank.gd           # Logika czołgu
  terrain.gd        # Generowanie i deformacja terenu
  projectile.gd     # Fizyka pocisku
  ai.gd             # AI przeciwników
  hud.gd            # HUD
assets/
  sprites/          # Grafiki czołgów, terenu, pocisków
  sounds/           # Dźwięki (strzał, wybuch, itp.)
  fonts/            # Fonty
```

## Uruchomienie
1. Zainstaluj [Godot 4](https://godotengine.org/)
2. Klonuj repozytorium
3. Otwórz `project.godot` w Godot
4. Uruchom scenę `scenes/Battle.tscn`

## Licencja
Kod źródłowy portu: MIT  
Oryginalna gra: © CTSMS.pl / Wapster (2011)
