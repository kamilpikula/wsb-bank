# WsbBank by Kamil Pikula

Projekt bankowy na przedmiot "programowanie aplikacji internetowych" - WSB Poznań. Jest to projekt prostej aplikacji bankowości internetowej. Funkcjonalności:

  - wpłata i wypłata pieniędzy
  - przelewy
  - uwierzytelnianie użytkowników
  - historia operacji na koncie
  - możliwość edytowania konta
  - autogenerowanie numeru konta podczas rejestracji
  - wyświetlanie nazwy banku do którego realizowany jest przelew
  - przyjazne UI panelu klienta
  - intuicyjna i prosta nawigacja po aplikacji
  - responsywność
  - kontakt

## Wersja live
##### [KLIKNIJ TUTAJ](https://aqueous-hollows-11968.herokuapp.com/)
Deploy aplikacji zostały wykonany w serwisie Heroku dla darmowej wersji, więc pierwsze ładowanie może potrwać dłużej.

## Konto do testowania

W tabeli poniżej znajdują się dane do konta testerskiego na środowisku produkcyjnym (link wyżej). Oczywiście sama rejestracja działa i można założyć swoje własne konto.

| login | hasło |
| ------ | ------ |
| user | password |

## Schemat bazy danych
Schemat bazy danych (tabele oraz pola) znajdują się w pliku [db/schema.rb](https://github.com/kamilpikula/wsb-bank/blob/master/db/schema.rb)

## Instalacja projektu lokalnie
Po instalacji Ruby v.2.7.0 oraz zainstalowaniu gemu Ruby on Rails wykonaj następujące kroki:

```sh
$ cd wsb-bank
$ bundle install
$ rake db:create
$ rake db:migrate
$ yarn
$ rails s
```
Po kilku chwilach aplikacja powinna się uruchomić na adresie `http://localhost:3000/`
## Zrzuty ekranu
Główne okno przed zalogowaniem się:
![Główne okno przed zalogowaniem](https://user-images.githubusercontent.com/23015380/84588994-f8d8b580-ae2b-11ea-85a5-90f6c2b5d7c9.png)

Logowanie:
![aqueous-hollows-11968 herokuapp com_users_sign_in](https://user-images.githubusercontent.com/23015380/84589032-3c332400-ae2c-11ea-856b-3eeee9e4844b.png)

Główny panel użytkownika (statystyki):
![Główny panel użytkownika (statystyki)](https://user-images.githubusercontent.com/23015380/85221418-f938f980-b3b3-11ea-866f-a61cc82581d1.png)

Historia transakcji:
![Historia transakcji](https://user-images.githubusercontent.com/23015380/84589155-0e021400-ae2d-11ea-882e-6861cd8333e3.png)

Edycja konta:
![Edycja konta](https://user-images.githubusercontent.com/23015380/84589191-3ab62b80-ae2d-11ea-99b9-8dff25f9d596.png)

Klienci banku:
![Klienci banku](https://user-images.githubusercontent.com/23015380/84589219-73560500-ae2d-11ea-9239-20ac8f824191.png)


**Wykonanie: Kamil Pikula**
