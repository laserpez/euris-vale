var OxObfac=["value","idSource","length","DIV","innerHTML","checked","linebreaks","\x0D\x0A","ig","\x3Cbr /\x3E","\x0D","\x0A"];var editor=Window_GetDialogArguments(window);function cancel(){Window_CloseDialog(window);} ;function insertContent(){var Oxce=document.getElementById(OxObfac[1])[OxObfac[0]];if(Oxce&&Oxce[OxObfac[2]]>0){var Ox7c=document.createElement(OxObfac[3]);Ox7c.appendChild(document.createTextNode(Oxce));var Ox283=Ox7c[OxObfac[4]];if(document.getElementById(OxObfac[6])[OxObfac[5]]){Ox283=Ox283.replace(( new RegExp(OxObfac[7],OxObfac[8])),OxObfac[9]);Ox283=Ox283.replace(( new RegExp(OxObfac[10],OxObfac[8])),OxObfac[9]);Ox283=Ox283.replace(( new RegExp(OxObfac[11],OxObfac[8])),OxObfac[9]);} else {} ;editor.PasteHTML(Ox283);Window_CloseDialog(window);} ;} ;