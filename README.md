# Park Valley

## Algemene uitleg

Deze app is ontwikkeld voor het vak Native Apps 2: iOS.  

Park Valley is een applicatie die je de mogelijkheid geeft om een garage te huren voor een opgegeven periode.  
De bedoeling is dat hiermee steeds je auto op een veilige plaats kan zetten als je op reis bent.

## Tech stack

De app is geschreven in swift.  
De testen vonden plaats op iOS 14.3 maar de app werkt ook op lagere versies van iOS.

De backend van de applicatie is geschreven in Vapor, zie deze github link: https://github.com/RobbeRamon/park-valley-api

## Aan de slag
De app maakt gebruik van enkele cocaopod packages.
Deze packages kan je installeren aan de hand van volgend commando:
```
pod install
```

## Uitleg over app

Het is de bedoeling om eerst een user te registreren via de app. Deze zal automatisch in de backend een garage toegekend krijgen in New York met de naam "Garage near city center". Dit kan je altijd nagaan bij je profiel op de app. Dit is enkel testdata.
Je hebt uiteraard ook de mogelijkheid om garages toe te voegen en te verwijderen.  

Je kan ook een booking maken op een garage, deze booking kan je terugvinden onder bookings in je profiel.

Je hebt de mogelijkheid om garages bij te houden als favoriet. Dit kan door op het hartje te drukken bij het overzicht van een garage (zie rechtsboven).
Een overzicht van de favoriete garages vind je ook bij je profiel in de app.

### Garage zoeken

Om een garage te zoeken kan je via de daarvoor voorziene view zoeken op **stad**.  
Het is belangrijk om te weten dat je enkel en alleen garages kan opzoeken aan de hand van hun stad.  
Dit is een business keuze en voldoende voor het prototype. Je hebt dus niet de mogelijkheid om te zoeken op naam van de garage.  

![screenshot_search](https://i.imgur.com/V0baBDT.png) ![screenshot_search](https://i.imgur.com/JxQBaRn.png)

### Garage boeken

Om een garage te boeken ga je naar de detailpagina van de garage. Daar druk je op de knop "Book garage".
Op het scherm om een booking toe te voegen moet je een data range opgeven. Hierdoor zal er een call naar de backend gebeuren om alle **beschikbare** dagen te krijgen binnen de opgegeven date range. Indien je meerdere dagen wil boeken, is het de bedoeling dat je dit doet in meerdere boekings. Het concept is dat je doorgaans maar één dag de garage nodig hebt, maar wel meerdere dagen *kan* boeken.

![screenshot_garage](https://i.imgur.com/zUQh4WC.png) ![screenshot_booking](https://i.imgur.com/SP1m5Pp.png)

### Garage toevoegen

Om een garage toe te voegen ga je naar je profiel, druk je op "My garages". Hier heb je een overzicht van jouw garages. Je kan een garage toevoegen door rechtsboven op de plus te drukken. Hier kan je de informatie invullen. De locatie kan je ingeven door bijvoorbeeld je eigen locatie te gebruiken door op de blauwe pijl te klikken. De app zal dan automatisch jouw adres in je juiste vorm in het invulveld zetten.

Je kan hier ook een afbeelding toevegen, echter wordt deze niet opgeslaan in de backend.
In het prototype is het behandelen van afbeeldingen in de backend niet van toepassing. Dit vooral omdat de opdracht voornamelijk gefocust is op de app en niet zozeer op de backend. Alle afbeeldingen van garages zijn dus ook hetzelfde in de prototype. Dit kan uiteindelijk veranderd worden als de app in productie komt.

![screenshot_add_garage](https://i.imgur.com/9qTkhcr.png)

### Garage verwijderen

Een garage kan je verwijderen door in het overzicht van je garages naar links te swipen en op "Delete" te klikken.

![screenshot_remove_garage](https://i.imgur.com/32OwchG.png)

### Prototype settings

Aan de hand van de prototype settings heb je de mogelijkheid de cache van de applicatie te legen en de backend te resetten.
De bezochte garages worden gecached en getoond. Als je de backend herestart verdwijnen ze uit de backend (zie uitleg op prototyp settings pagina).
Er is in het prototype geen manier om automatisch cache te legen indien een garage niet meer bestaat.

![screenshot_prototype_settings](https://i.imgur.com/NqexWrL.png)
