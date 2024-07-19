---
layout: default
title: QoS szolgáltatásminőség
parent: ROS 2 haladó 
---

 





# DDS protokoll

A DDS (Data Distribution Service) az Object Management Group (OMG) által standardizált kommuinkációs protokoll.

![](https://raw.githubusercontent.com/sze-info/arj/main/docs/_images/overview17.svg)

A DDS protokoll széles körben használt az ipari automatizálásban, a hálózatosított rendszerekben és más területeken, ahol az elosztott adatkommunikáció és a valós idejű adatfeldolgozás kiemelt fontossággal bír. DDS-átvitel rugalmasságából profitál veszteséges vezeték nélküli hálózatokkal rendelkező környezetekben, ahol a "legjobb erőfeszítés" (`best effort`) elv lenne megfelelőbb vagy valós idejű számítástechnikai rendszerekben, ahol pedig a megfelelő minőség. Az időzítések betartásához szükség van a szolgáltatási profilra.
A QoS "házirendek" halmaza egy QoS "profilt" alkot. Tekintettel az adott forgatókönyvhöz megfelelő QoS-irányelvek kiválasztásának bonyolultságára, a kommunikáció előre definiált QoS-profilokat biztosít általános használati esetekre (pl. szenzoradatok). 

## Szolgáltatásminőség (QoS)

A szolgáltatásminőség  angol szóval Quality of Service vagy röviden QoS. Az alap QoS-profil a következő házirendek beállításait tartalmazza:


### Múlt (`history`)
-	Utolsó megtartása (`keep last`): legfeljebb N mintát tárolhat, a sormélység opcióval konfigurálható.
-	Mind megtartása (`keep all`): az összes mintát tárolja, az alapul szolgáló köztes szoftver konfigurált erőforrás-korlátjaitól függően.
### Mélység (`depth`)
-	Sor mérete: csak akkor teljesül, ha az "előzmények" házirend "utolsó megőrzésre" van állítva.
### Megbízhatóság (`relyability`)
-	Legjobb erőfeszítés (`best effort`): próbáljon meg mintákat szállítani, de elveszítheti azokat, ha a hálózat nem robusztus.
-	Megbízható (`reliable`): garantálja a minták kiszállítását, többször is próbálkozhat.
### Tartósság (`durability`)
-	Átmeneti helyi (`transient local`): a kiadó felelős a „későn csatlakozó” előfizetések tartós mintáiért.
-	Illékony: nem történik kísérlet a minták fennmaradására.
### Határidő, időzítés (`deadline`)
-	Időtartam: a várható maximális időtartam a következő üzenetek közzététele között egy témában
### Élettartam (`lifespan`)
-	Időtartam: az üzenet közzététele és fogadása közötti maximális időtartam anélkül, hogy az üzenet elavultnak vagy lejártnak minősülne (a lejárt üzeneteket a rendszer eldobja, és gyakorlatilag soha nem érkezik meg).
### Élénkség (`liveliness`)
-	Automatikus: a rendszer a node összes publisherjét élőnek tekinti egy újabb "elengedési időtartamra", ha valamelyik kiadója közzétett egy üzenetet.
-	Manuális: a rendszer a publishert egy másik " elengedési időtartamra" élőnek tekinti, ha manuálisan (a publisher API-jának hívásával) azt állítja, hogy még életben van.
### Elengedési időtartam (`lease duration`)
-	Időtartam: az a maximális időtartam, ameddig a kommunikációs adónak jeleznie kell, hogy életben van, mielőtt a rendszer úgy ítélné meg, hogy elvesztette az élőségét.

# QoS kompatibilitás


# Gyakorlat



# Források

- [docs.ros.org/en/humble/Concepts/Intermediate/About-Quality-of-Service-Settings.html](https://docs.ros.org/en/humble/Concepts/Intermediate/About-Quality-of-Service-Settings.html)
- [docs.ros.org/en/humble/Tutorials/Intermediate/Launch/Creating-Launch-Files.html](https://docs.ros.org/en/humble/Tutorials/Intermediate/Launch/Creating-Launch-Files.html)
