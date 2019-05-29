local _, L = ...;
if GetLocale() == "itIT" then


	L["Insert QuestID to get info:"] = "Inserisci l'ID missione per recuperare informazioni:";
	L["Check"] = "Controlla";
	L["Cancel"] = "Annulla";

	L["Quest ID \124cff9d9d9d[%s]\124r %s"] = "La missione con ID \124cff9d9d9d[%s]\124r %s"
	L["has already been completed"] = "risulta già compleata";
	L["has not yet been completed"] = "non risulta ancora completata";

	L["NO DATABASE INFO FOUND"] = "NESSUNA INFO TROVATA NEL DATABASE";

	L[": wrong type value for quest id."] = ": inserisci un id missione valido.";
	L[": quest id out of range."] = ": id missione fuori range.";
	L[": input field null."] = ": inserisci un valore per controllare.";


	-- [Options Localization] --
	L[ADDONNAME.." is designed to help user retrieving infos by a quest ID. "
    ..ADDONNAME.." can be useful for example, if you want know what quest"
    .." of a quests chain has not yet completed or if you want find out its title. "
    ..ADDONNAME.." is looking for beta testers to provide feedback for bug fixes and to suggest new features.\n"
    .."Please PM me at "..RnB.LBlue(PM).." if you are want helping or suggesting.\n\r\r"] = ADDONNAME
    .." è progettato per ottenere info tramite l'ID missione. "
    ..ADDONNAME.." può essere utile per esempio, se si vuole sapere quale missione "
    .." di una serie non è stata ancora completata o se ne si vuole ottenere il titolo. "
    ..ADDONNAME.." cerca beta testers che forniscano feedback per il debug o per introdurre funzionalità.\n"
    .."Inviate un PM a "..RnB.LBlue(PM).." se interessati.\n\r\r";

    L["Bug Reports"] = "Rapporto sui Bug";
	L[RnB.Grey("Please use ")..RnB.WYellow("!BugGrabber")..RnB.Grey(" and ")..RnB.WYellow("BugSack")
	..RnB.Grey(" to provide meaningful information to help me debug without which, "
	.."I probably won't be able to find out, repeat, diagnose, and fix the issue you see).\n\r")] = RnB.Grey("Vi prego di utilizzare ")..RnB.WYellow("!BugGrabber")..RnB.Grey(" e ")..RnB.WYellow("BugSack")
	..RnB.Grey(" che mi aiutino a fornire informazioni significative in fase di debug e senza i quali, "
	.."probabilmente non sarei in grado di scovare, riprodurre, fare diagnosi, e risolvere il problema che riscontrate).\n\r");

	L["Features"] = "Funzionalità";
	L["- Keyboard support keys to easy way control UI. "] = "- Supporto comodo per la gestione da tastiera. ";
	L["[Keys: ESC, Enter]\n"] = "[Tasti: ESC, Invio]\n";
	L["- Colored responses"] = "- Risultati elaborati colorati.";

	L["Slash Commands"] = "Comandi d'avvio";
	L[" - show the GUI."] = " - aprono la GUI.";

	L["Languages "] = "Linguaggi ";

	L["Project Website "] = "Sito del progetto ";

	L["Developer"] = "Sviluppatore";
	L["Version"] = "Versione";

end