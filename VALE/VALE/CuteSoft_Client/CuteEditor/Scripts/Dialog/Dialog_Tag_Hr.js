var OxOafee=["inp_width","eenheid","alignment","hrcolor","hrcolorpreview","shade","sel_size","width","style","value","px","%","size","align","color","backgroundColor","noShade","noshade","","onclick"];var inp_width=Window_GetElement(window,OxOafee[0],true);var eenheid=Window_GetElement(window,OxOafee[1],true);var alignment=Window_GetElement(window,OxOafee[2],true);var hrcolor=Window_GetElement(window,OxOafee[3],true);var hrcolorpreview=Window_GetElement(window,OxOafee[4],true);var shade=Window_GetElement(window,OxOafee[5],true);var sel_size=Window_GetElement(window,OxOafee[6],true);UpdateState=function UpdateState_Hr(){} ;SyncToView=function SyncToView_Hr(){if(element[OxOafee[8]][OxOafee[7]]){if(element[OxOafee[8]][OxOafee[7]].search(/%/)<0){eenheid[OxOafee[9]]=OxOafee[10];inp_width[OxOafee[9]]=element[OxOafee[8]][OxOafee[7]].split(OxOafee[10])[0];} else {eenheid[OxOafee[9]]=OxOafee[11];inp_width[OxOafee[9]]=element[OxOafee[8]][OxOafee[7]].split(OxOafee[11])[0];} ;} ;sel_size[OxOafee[9]]=element[OxOafee[12]];alignment[OxOafee[9]]=element[OxOafee[13]];hrcolor[OxOafee[9]]=element[OxOafee[14]];if(element[OxOafee[14]]){hrcolor[OxOafee[8]][OxOafee[15]]=element[OxOafee[14]];} ;if(element[OxOafee[16]]){shade[OxOafee[9]]=OxOafee[17];} else {shade[OxOafee[9]]=OxOafee[18];} ;} ;SyncTo=function SyncTo_Hr(element){if(sel_size[OxOafee[9]]){element[OxOafee[12]]=sel_size[OxOafee[9]];} ;if(hrcolor[OxOafee[9]]){element[OxOafee[14]]=hrcolor[OxOafee[9]];} ;if(alignment[OxOafee[9]]){element[OxOafee[13]]=alignment[OxOafee[9]];} ;if(shade[OxOafee[9]]==OxOafee[17]){element[OxOafee[16]]=true;} else {element[OxOafee[16]]=false;} ;if(inp_width[OxOafee[9]]){element[OxOafee[8]][OxOafee[7]]=inp_width[OxOafee[9]]+eenheid[OxOafee[9]];} ;} ;hrcolor[OxOafee[19]]=hrcolorpreview[OxOafee[19]]=function hrcolor_onclick(){SelectColor(hrcolor,hrcolorpreview);} ;