.RP
.TL
Robot Reboot
.AU
Elias Nijs
.AI
Logisch Programeren, Universiteit Gent
.DA
.AM
.2C
.R1
accumulate
database bib.ref
.R2
.EQ
delim $$
.EN
.NH 1
Introductie
.LP
In dit verslag bespreek ik mijn implementatie voor het spel robot reboot. Deze
implementatie bevat drie modi. Ten eerste een interactieve modus, ten tweede een
modus die de optimale oplossing zoekt voor een gegeven puzzel en tot slot een
modus die een nieuwe puzzel genereert op basis van het aantal robots en
dimensies van het bord.

We bespreken eerste enkele datastucturen die doorheen heel het programma
voorkomen, daarna bekijken we elke van de drie modi en tot slot trekken we enkele
conclusies.
.NH
Belangrijke Datastructuren
.LP
We bespreken eerst enkele datastructuren. De belangrijkste structuur die
doorheen heel de implementatie telkens terugkomt is deze van de puzzel.

Deze ziet er als volgt uit:
.BD
.CW
.ps -1
puzzle(
	board(W, H, [wall(Dv, P)]),
	[robot(ID, Dv, P)],
	target(P)
	)
.ps +1
.Di
.EB

.LP
Er werd gekozen om bij het bord niet het hele bord bij te houden maar
enkel de muren. Deze keuze werd gemaakt omdat het de logica signficant kan
vereenvoudigen. Verder werd er ook gekozen om de character representaties van de
muren en robots bij te houden. Ook deze keuze werd gemaakt om de logica van het
programma te kunnen vereenvoudigen.

De data hierbij wordt voorgesteld
door de variabelen. Hier
stellen
.CW W
en
.CW H
respectievelijk de breedte en hoogte voor. Verder stelt Dv (Display
value) de character representatie voor, en is P (Position) telkens een
.CW vec2(X,Y)
die de positie van de muur of entiteit aanduidt.
De
.CW vec2(X,Y)
wordt doorheen het programma vaak gebruikt om posities en richtingen weer te
geven.
.LP
Andere predicaten zijn vanzelfsprekend of worden besproken bij hun modus indien
deze enkel daar van toepassing zijn.
.NH
De drie modi
.LP
We bekijken nu elk van de drie modi in meer detail.
.NH 2
De interactive/spel modus
.LP
We beginnen bij de interactieve/spel modus. In deze modus kan de gebruiker aan
de hand van de terminal het spel spelen.

.PSPIC -C "images/interactive.eps" 1.5i

Er zijn een aantal opmerkelijke zaken
aan deze modus. Deze zijn de volgende:
.nr step 1 1
.IP \n[step]. 3
De spel loop.
.IP \n+[step].
Het session object.
.IP \n+[step].
Het gebruik van ansi escape sequences om het spel aantrekkelijker te maken.
.IP \n+[step].
Verbreeding van de weergave
.IP \n+[step].
De win/lose schermen
.LP

De spel loop is een loop die loopt tot het doel bereikt wordt of tot
de speler het programma verlaat. Elke iteratie van de loop gaat als volgt.
Eerst wordt de huidige puzzel afgebeeld en daarna wordt er input gevraagt aan de
speler. Eens de input geleverd is wordt deze afgehandeld en belanden we zo in de
volgende iteratie terecht. De input kan een van volgende zaken zijn:
.TS
expand tab(:);
lb lb
__
l l.
Actie:Input
Selecteer vorige robot:F
Selecteer volgende robot:D
Ga naar links:H
Ga omlaag:J
Ga omhoog:K
Ga naar rechts:L
Verlaat het spel:Q
Toon het help menu:;
.TE

Het session object bij de interactieve modus is een datastructuur die in de
meeste geralteerde predicaten gebruikt wordt. Dit object ziet er als volgt uit:
.BD
.CW
.ps -1
session( puzzle(...), ID, H)
.ps +1
.Di
.LP
Het puzzel object hierbij werd eerder besproken,
.CW ID
is de id van de huidig geselecteerde robot en
.CW H
is de geschiedenis van de zetten in string-vorm.

Een ander opmerkelijke punt is het gebruik van de ansi-escape characters. Deze
laten ons toe om kleur en andere effecten voor onze terminal output te
specifieren. Om hier goed van gebruik te maken werden er predicaten
gedefinieerd. Deze zijn terug te vinden in
.CW "src/utils/ansi.pl". Er werd verder ook een kleuren palet gedefinieerd, deze
valt terug te vinden in
.CW "src/config.pl".

Verder werd de weergave van de puzzel ook verbreed. Dit wordt gedaan door aan de
rechterkant van elke cel een spatie of extra muur toe te voegen tijdens de
weergave. Op deze manier is bord minder rechthoekig en ziet het er beter
gebalanceerd uit. Intern wordt het bord wel nog in de normale dimensies
opgeslaan.

Tot slot hebben we de win en verlies schermen. Deze werden toegevoed om de
speler een betere ervaring te geven en zien er als volgt uit:
.mk
.PSPIC -C "images/win.eps" 1.5i
.r
.PSPIC -C "images/lose.eps" 1.5i

.NH 2
De oplos modus
.LP
De oplos modus zal een optimale oplossing zoeken voor een gegeven puzzel. Het
belangrijkste aspect aan deze modus is het gebruikte algoritme. Het algoritme
dat in deze implementatie gebruikt werd is iterative deepening. Dit werd gekozen
omwille van de interne werking van prolog. Prolog gebruikt intern immers
Depth-First-Search. Door een maximum diepte mee te geven en deze incrementeel te
verhogen kunnen we dus heel makkelijk een iterative-deepening algoritme
implementeren.

De effectieve implementatie bestaat uit 3 delen: Het iterative deepening deel,
een dfs deel en een logging deel. Het iteratieve deel zal steeds het dfs deel
oproepen met een maximum diepte. Dit zal blijven gebeuren met een incrementerede
diepte tot een oplossing gevonden wordt. Het dfs deel bestaat voornamlijk uit de
oplossings ruimte snoeien en de bewegingen uit voeren. De effectieve uitvoering
van dfs is intern in prolog ingebouwd. Tot slot hebben we ook nog een logging
deel. Deze wordt opgeroepen bij elke nieuwe diepte om de gebruiker op de hoogte
te houden van hoe ver het algoritme zit. Daarnaast wordt deze ook opgeroepen op
het einde om de optimale oplossingen naar de terminal uit te schrijven.

.NH 2
De genereer modus
.LP
De genereer modus bestaat uit loop. Deze loop bevat 2 delen: het
genereer deel en het oplos deel. Deze loop zal blijven duren tot er een puzzel
gegenereerd wordt die oplosbaar is in een maximum aantal stappen.

Het genereren van de puzzels wordt gedaan door, met bepaalde beperkingen in
gedachte, willekeurig het aantal obstakels te bepalen, en willekeurige posities
te genereren voor de obstakels en voor de robots. Eens de puzzel gegenereerd is
zullen ook de display values van de muren opgelost worden door voor elke muur
naar de buren te kijken en op basis hiervan de bijhorende waarde op te zoeken.

Het oplos deel bestaat erin de oplos modus, die hiervoor besproken werd, op te
roepen op de nieuw gegenereerde puzzel. Indien deze een oplossing vindt binnen
een bepaalde maximum diepte wordt de lus stop gezet en wordt de puzzel samen met
het een optimale oplossing voor de puzzel naar de standaard uitvoer geschreven.

.NH
Conclusie
.LP
We hebben een robot reboot implementatie succesvol gemaakt. We hebben
ondervonden dat prolog een interessante taal is die ondanks zijn oude leeftijd
nog hard in ontwikkeling is. In het algemeen kunnen we besluiten dat het kennen
en kunnen van deze taal zeker een meerwaarde is voor de moderne programmeur. In
het vervolg zouden we waarschijnlijk beter op voorhand plannen hoe bepaalde
predicaten zich tegenover elkaar verhouden om de logica zo simpel en logisch
mogelijk te houden.

