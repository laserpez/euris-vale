var OxO4ff4=["rowSpan","removeNode","parentNode","firstChild","colSpan","nodeName","TABLE","Map","rowIndex","rows","length","cells","cellIndex","innerHTML","cell","\x26nbsp;","Can\x27t Get The Position ?","RowCount","ColCount","Unknown Error , pos ",":"," already have cell","Unknown Error , Unable to find bestpos","tbody","richDropDown","list_Templates","subcolumns","addcolumns","subcolspan","addcolspan","btn_row_dialog","btn_cell_dialog","inp_cell_width","inp_cell_height","btn_cell_editcell","tabledesign","subrows","addrows","subrowspan","addrowspan","display","style","none","disabled","value","width","height","[[ValidNumber]]","","\x3Ctable\x3E\x3Ctr\x3E\x3Ctd height=\x2224\x22\x3E\x3C/td\x3E\x3C/tr\x3E\x3C/table\x3E","\x3Ctable\x3E\x3Ctr\x3E\x3Ctd\x3E\x3C/td\x3E\x3Ctd\x3E\x3C/td\x3E\x3C/tr\x3E\x3C/table\x3E","\x3Ctable\x3E\x3Ctr\x3E\x3Ctd\x3E\x3C/td\x3E\x3Ctd\x3E\x3C/td\x3E\x3Ctd\x3E\x3C/td\x3E\x3C/tr\x3E\x3C/table\x3E","\x3Ctable border=\x220\x22 cellpadding=\x220\x22 cellspacing=\x220\x22\x3E\x3Ctr\x3E\x3Ctd valign=\x22top\x22 colspan=\x222\x22\x3E\x3C/td\x3E\x3C/tr\x3E","\x3Ctr\x3E\x3Ctd valign=\x22top\x22 rowspan=\x222\x22\x3E\x3C/td\x3E\x3Ctd valign=\x22top\x22\x3E\x3C/td\x3E\x3C/tr\x3E","\x3Ctr\x3E\x3Ctd valign=\x22top\x22\x3E\x3C/td\x3E\x3C/tr\x3E\x3C/table\x3E","\x3Ctr\x3E\x3Ctd valign=\x22top\x22\x3E\x3C/td\x3E\x3Ctd valign=\x22top\x22 rowspan=\x222\x22\x3E\x3C/td\x3E\x3C/tr\x3E\x3Ctr\x3E\x3Ctd valign=\x22top\x22\x3E\x3C/td\x3E\x3C/tr\x3E\x3C/table\x3E","\x3Ctable border=\x220\x22 cellpadding=\x220\x22 cellspacing=\x220\x22\x3E\x3Ctr\x3E\x3Ctd valign=\x22top\x22 colspan=\x223\x22\x3E\x3C/td\x3E\x3C/tr\x3E","\x3Ctr\x3E\x3Ctd valign=\x22top\x22\x3E\x3C/td\x3E\x3Ctd valign=\x22top\x22\x3E\x3C/td\x3E\x3Ctd valign=\x22top\x22\x3E\x3C/td\x3E\x3C/tr\x3E","\x3Ctr\x3E\x3Ctd valign=\x22top\x22 colspan=\x223\x22\x3E\x3C/td\x3E\x3C/tr\x3E\x3C/table\x3E","DIV","onclick","bgColor","#d4d0c8","onmouseover","onmouseout","ondblclick","contains","ToggleBorder","backgroundColor","highlight","cssText","runtimeStyle","background-color:gray","onload","body","document","csstext","font:normal 11px Tahoma;background-color:windowtext;","isOpen"];function Table_GetCellFromMap(Ox50e,Ox50f,Ox510){var Ox511=Ox50e[Ox50f];if(Ox511){return Ox511[Ox510];} ;} ;function Table_CanSubRowSpan(Ox397){return Ox397[OxO4ff4[0]]>1;} ;function Element_RemoveNode(element,Ox514){if(element[OxO4ff4[1]]){element.removeNode(Ox514);return ;} ;var p=element[OxO4ff4[2]];if(!p){return ;} ;if(Ox514){p.removeChild(element);return ;} ;while(true){var Ox217=element[OxO4ff4[3]];if(!Ox217){break ;} ;p.insertBefore(Ox217,element);} ;p.removeChild(element);} ;function Table_CanSubColSpan(Ox397){return Ox397[OxO4ff4[4]]>1;} ;function Table_GetTable(Ox43){for(;Ox43!=null;Ox43=Ox43[OxO4ff4[2]]){if(Ox43[OxO4ff4[5]]==OxO4ff4[6]){return Ox43;} ;} ;return null;} ;function Table_SubRowSpan(Ox397){var Ox395=Table_GetTable(Ox397);var Ox4=Table_CalculateTableInfo(Ox395);var Ox50e=Ox4[OxO4ff4[7]];var Ox126=Table_GetCellPositionFromMap(Ox50e,Ox397);var Ox518=Ox395[OxO4ff4[9]].item(Ox397[OxO4ff4[2]][OxO4ff4[8]]+Ox397[OxO4ff4[0]]-1);var Ox519=0;for(var i=0;i<Ox518[OxO4ff4[11]][OxO4ff4[10]];i++){var Ox51a=Ox518[OxO4ff4[11]].item(i);var Ox51b=Table_GetCellPositionFromMap(Ox50e,Ox51a);if(Ox51b[OxO4ff4[12]]<Ox126[OxO4ff4[12]]){Ox519=i+1;} ;} ;for(var i=0;i<Ox397[OxO4ff4[4]];i++){var Ox217=Ox518.insertCell(Ox519);if(Browser_IsOpera()){Ox217[OxO4ff4[13]]=OxO4ff4[14];} else {if(Browser_IsGecko()||Browser_IsSafari()){Ox217[OxO4ff4[13]]=OxO4ff4[15];} ;} ;} ;Ox397[OxO4ff4[0]]--;} ;function Table_GetCellPositionFromMap(Ox50e,Ox397){for(var y=0;y<Ox50e[OxO4ff4[10]];y++){var Ox511=Ox50e[y];for(var x=0;x<Ox511[OxO4ff4[10]];x++){if(Ox511[x]==Ox397){return {rowIndex:y,cellIndex:x};} ;} ;} ;throw ( new Error(-1,OxO4ff4[16]));} ;function Table_GetCellMap(Ox395){return Table_CalculateTableInfo(Ox395)[OxO4ff4[7]];} ;function Table_GetRowCount(Ox43){return Table_CalculateTableInfo(Ox43)[OxO4ff4[17]];} ;function Table_GetColCount(Ox43){return Table_CalculateTableInfo(Ox43)[OxO4ff4[18]];} ;function Table_CalculateTableInfo(Ox43){var Ox395=Table_GetTable(Ox43);var Ox521=Ox395[OxO4ff4[9]];for(var Oxa=Ox521[OxO4ff4[10]]-1;Oxa>=0;Oxa--){var Ox387=Ox521.item(Oxa);if(Ox387[OxO4ff4[11]][OxO4ff4[10]]==0){Element_RemoveNode(Ox387,true);continue ;} ;} ;var Ox522=Ox521[OxO4ff4[10]];var Ox523=0;var Ox524= new Array(Ox521.length);for(var Ox525=0;Ox525<Ox522;Ox525++){Ox524[Ox525]=[];} ;function Ox526(Oxa,Ox217,Ox397){while(Oxa>=Ox522){Ox524[Ox522]=[];Ox522++;} ;var Ox527=Ox524[Oxa];if(Ox217>=Ox523){Ox523=Ox217+1;} ;if(Ox527[Ox217]!=null){throw ( new Error(-1,OxO4ff4[19]+Oxa+OxO4ff4[20]+Ox217+OxO4ff4[21]));} ;Ox527[Ox217]=Ox397;} ;function Ox528(Oxa,Ox217){var Ox527=Ox524[Oxa];if(Ox527){return Ox527[Ox217];} ;} ;for(var Ox525=0;Ox525<Ox521[OxO4ff4[10]];Ox525++){var Ox387=Ox521.item(Ox525);var Ox529=Ox387[OxO4ff4[11]];for(var Ox39b=0;Ox39b<Ox529[OxO4ff4[10]];Ox39b++){var Ox397=Ox529.item(Ox39b);var Ox52a=Ox397[OxO4ff4[0]];var Ox52b=Ox397[OxO4ff4[4]];var Ox527=Ox524[Ox525];var Ox52c=-1;for(var Ox52d=0;Ox52d<Ox523+Ox52b+1;Ox52d++){if(Ox52a==1&&Ox52b==1){if(Ox527[Ox52d]==null){Ox52c=Ox52d;break ;} ;} else {var Ox52e=true;for(var Ox52f=0;Ox52f<Ox52a;Ox52f++){for(var Ox530=0;Ox530<Ox52b;Ox530++){if(Ox528(Ox525+Ox52f,Ox52d+Ox530)!=null){Ox52e=false;break ;} ;} ;} ;if(Ox52e){Ox52c=Ox52d;break ;} ;} ;} ;if(Ox52c==-1){throw ( new Error(-1,OxO4ff4[22]));} ;if(Ox52a==1&&Ox52b==1){Ox526(Ox525,Ox52c,Ox397);} else {for(var Ox52f=0;Ox52f<Ox52a;Ox52f++){for(var Ox530=0;Ox530<Ox52b;Ox530++){Ox526(Ox525+Ox52f,Ox52c+Ox530,Ox397);} ;} ;} ;} ;} ;var Ox13e={};Ox13e[OxO4ff4[17]]=Ox522;Ox13e[OxO4ff4[18]]=Ox523;Ox13e[OxO4ff4[7]]=Ox524;for(var Oxa=0;Oxa<Ox522;Oxa++){var Ox527=Ox524[Oxa];for(var Ox217=0;Ox217<Ox523;Ox217++){} ;} ;return Ox13e;} ;function Table_SubColSpan(Ox397){var Ox395=Table_GetTable(Ox397);Ox397[OxO4ff4[2]].insertCell(Ox397[OxO4ff4[12]]+1)[OxO4ff4[0]]=Ox397[OxO4ff4[0]];Ox397[OxO4ff4[4]]--;} ;function Table_CanAddRowSpan(Ox397){var Ox395=Table_GetTable(Ox397);var Ox4=Table_CalculateTableInfo(Ox395);var Ox50e=Ox4[OxO4ff4[7]];var Ox126=Table_GetCellPositionFromMap(Ox50e,Ox397);var Ox533=0;for(var Ox217=0;Ox217<Ox397[OxO4ff4[4]];Ox217++){var Ox534=Table_GetCellFromMap(Ox50e,Ox126[OxO4ff4[8]]+Ox397[OxO4ff4[0]],Ox126[OxO4ff4[12]]+Ox217);if(Ox534==null){return false;} ;if(Ox533!=0&&Ox533!=Ox534[OxO4ff4[0]]){return false;} ;Ox533=Ox534[OxO4ff4[0]];var Ox535=Table_GetCellPositionFromMap(Ox50e,Ox534);if(Ox535[OxO4ff4[12]]<Ox126[OxO4ff4[12]]){return false;} ;if(Ox535[OxO4ff4[12]]+Ox534[OxO4ff4[4]]>Ox126[OxO4ff4[12]]+Ox397[OxO4ff4[4]]){return false;} ;} ;return true;} ;function Table_AddRow(Ox397){var Ox395=Table_GetTable(Ox397);var Ox4=Table_CalculateTableInfo(Ox395);var Ox50e=Ox4[OxO4ff4[7]];var Ox523=Ox4[OxO4ff4[18]];var Ox522=Ox4[OxO4ff4[17]];var Ox387;if(!Browser_IsSafari()){Ox387=Ox395.insertRow(-1);} else {var Ox225=document.createElement(OxO4ff4[23]);Ox395.appendChild(Ox225);Ox387=Ox225.insertRow(-1);} ;for(var i=0;i<Ox523;i++){var Ox217=Ox387.insertCell(-1);if(Browser_IsOpera()){Ox217[OxO4ff4[13]]=OxO4ff4[14];} else {if(Browser_IsGecko()||Browser_IsSafari()){Ox217[OxO4ff4[13]]=OxO4ff4[15];} ;} ;} ;} ;function Table_AddCol(Ox397){var Ox395=Table_GetTable(Ox397);for(var Oxa=0;Oxa<Ox395[OxO4ff4[9]][OxO4ff4[10]];Oxa++){var Ox387=Ox395[OxO4ff4[9]].item(Oxa);var Ox217=Ox387.insertCell(-1);if(Browser_IsOpera()){Ox217[OxO4ff4[13]]=OxO4ff4[14];} else {if(Browser_IsGecko()||Browser_IsSafari()){Ox217[OxO4ff4[13]]=OxO4ff4[15];} ;} ;} ;} ;function Table_CleanUpTableInfo(Ox395,Ox4){var Ox521=Ox395[OxO4ff4[9]];for(var Oxa=Ox521[OxO4ff4[10]]-1;Oxa>=0;Oxa--){var Ox387=Ox521.item(Oxa);if(Ox387[OxO4ff4[11]][OxO4ff4[10]]==0){Element_RemoveNode(Ox387,true);continue ;} ;} ;var Ox50e=Ox4[OxO4ff4[7]];var Ox523=Ox4[OxO4ff4[18]];var Ox522=Ox4[OxO4ff4[17]];for(var Ox525=1;Ox525<Ox522;Ox525++){var Ox539=true;for(var Ox39b=0;Ox39b<Ox523;Ox39b++){if(Table_GetCellFromMap(Ox50e,Ox525-1,Ox39b)!=Table_GetCellFromMap(Ox50e,Ox525,Ox39b)){Ox539=false;break ;} ;} ;if(Ox539){for(var Ox39b=0;Ox39b<Ox523;Ox39b++){var Ox397=Table_GetCellFromMap(Ox50e,Ox525,Ox39b);if(Ox397){if(Ox397[OxO4ff4[0]]>1){Ox397[OxO4ff4[0]]=Ox397[OxO4ff4[0]]-1;} ;Ox39b+=Ox397[OxO4ff4[4]]-1;} ;} ;} ;} ;for(var Ox39b=1;Ox39b<Ox523;Ox39b++){var Ox539=true;for(var Ox525=0;Ox525<Ox522;Ox525++){if(Table_GetCellFromMap(Ox50e,Ox525,Ox39b-1)!=Table_GetCellFromMap(Ox50e,Ox525,Ox39b)){Ox539=false;break ;} ;} ;if(Ox539){for(var Ox525=0;Ox525<Ox522;Ox525++){var Ox397=Table_GetCellFromMap(Ox50e,Ox525,Ox39b);if(Ox397){if(Ox397[OxO4ff4[4]]>1){Ox397[OxO4ff4[4]]=Ox397[OxO4ff4[4]]-1;} ;Ox525+=Ox397[OxO4ff4[0]]-1;} ;} ;} ;} ;} ;function Table_SubRow(Ox397){var Ox395=Table_GetTable(Ox397);var Ox4=Table_CalculateTableInfo(Ox395);var Ox50e=Ox4[OxO4ff4[7]];var Ox523=Ox4[OxO4ff4[18]];var Ox522=Ox4[OxO4ff4[17]];if(Ox522==0){return ;} ;var Ox53b={};var Ox525=Ox522-1;for(var Ox39b=0;Ox39b<Ox523;Ox39b++){var Ox397=Table_GetCellFromMap(Ox50e,Ox525,Ox39b);if(Ox397){if(Ox397[OxO4ff4[2]]==null){continue ;} ;if(Ox397[OxO4ff4[0]]==1){Element_RemoveNode(Ox397,true);} else {Ox397[OxO4ff4[0]]=Ox397[OxO4ff4[0]]-1;} ;} ;} ;Ox4[OxO4ff4[17]]--;Table_CleanUpTableInfo(Ox395,Ox4);} ;function Table_CanAddColSpan(Ox397){var Ox395=Table_GetTable(Ox397);var Ox4=Table_CalculateTableInfo(Ox395);var Ox50e=Ox4[OxO4ff4[7]];var Ox126=Table_GetCellPositionFromMap(Ox50e,Ox397);var Ox53d=0;for(var Oxa=0;Oxa<Ox397[OxO4ff4[0]];Oxa++){var Ox534=Table_GetCellFromMap(Ox50e,Ox126[OxO4ff4[8]]+Oxa,Ox126[OxO4ff4[12]]+Ox397[OxO4ff4[4]]);if(Ox534==null){return false;} ;if(Ox53d!=0&&Ox53d!=Ox534[OxO4ff4[4]]){return false;} ;Ox53d=Ox534[OxO4ff4[4]];var Ox535=Table_GetCellPositionFromMap(Ox50e,Ox534);if(Ox535[OxO4ff4[8]]<Ox126[OxO4ff4[8]]){return false;} ;if(Ox535[OxO4ff4[8]]+Ox534[OxO4ff4[0]]>Ox126[OxO4ff4[8]]+Ox397[OxO4ff4[0]]){return false;} ;} ;return true;} ;function Table_AddRowSpan(Ox397){var Ox395=Table_GetTable(Ox397);var Ox4=Table_CalculateTableInfo(Ox395);var Ox50e=Ox4[OxO4ff4[7]];var Ox126=Table_GetCellPositionFromMap(Ox50e,Ox397);var Ox533=0;for(var Ox217=0;Ox217<Ox397[OxO4ff4[4]];Ox217++){var Ox534=Table_GetCellFromMap(Ox50e,Ox126[OxO4ff4[8]]+Ox397[OxO4ff4[0]],Ox126[OxO4ff4[12]]+Ox217);if(Ox533==0){Ox533=Ox534[OxO4ff4[0]];} ;Element_RemoveNode(Ox534,true);} ;Ox397[OxO4ff4[0]]=Ox397[OxO4ff4[0]]+Ox533;for(var Ox525=0;Ox525<Ox397[OxO4ff4[0]];Ox525++){for(var Ox39b=0;Ox39b<Ox397[OxO4ff4[4]];Ox39b++){Ox4[OxO4ff4[7]][Ox126[OxO4ff4[8]]+Ox525][Ox126[OxO4ff4[12]]+Ox39b]=Ox397;} ;} ;Table_CleanUpTableInfo(Ox395,Ox4);} ;function Table_AddColSpan(Ox397){var Ox395=Table_GetTable(Ox397);var Ox4=Table_CalculateTableInfo(Ox395);var Ox50e=Ox4[OxO4ff4[7]];var Ox126=Table_GetCellPositionFromMap(Ox50e,Ox397);var Ox53d=0;for(var Oxa=0;Oxa<Ox397[OxO4ff4[0]];Oxa++){var Ox534=Table_GetCellFromMap(Ox50e,Ox126[OxO4ff4[8]]+Oxa,Ox126[OxO4ff4[12]]+Ox397[OxO4ff4[4]]);if(Ox53d==0){Ox53d=Ox534[OxO4ff4[4]];} ;Element_RemoveNode(Ox534,true);} ;Ox397[OxO4ff4[4]]+=Ox53d;for(var Ox525=0;Ox525<Ox397[OxO4ff4[0]];Ox525++){for(var Ox39b=0;Ox39b<Ox397[OxO4ff4[4]];Ox39b++){Ox4[OxO4ff4[7]][Ox126[OxO4ff4[8]]+Ox525][Ox126[OxO4ff4[12]]+Ox39b]=Ox397;} ;} ;Table_CleanUpTableInfo(Ox395,Ox4);} ;function Table_SubCol(Ox397){var Ox395=Table_GetTable(Ox397);var Ox4=Table_CalculateTableInfo(Ox395);var Ox50e=Ox4[OxO4ff4[7]];var Ox523=Ox4[OxO4ff4[18]];var Ox522=Ox4[OxO4ff4[17]];if(Ox522==0){return ;} ;var Ox53b={};var Ox39b=Ox523-1;for(var Ox525=0;Ox525<Ox522;Ox525++){var Ox397=Table_GetCellFromMap(Ox50e,Ox525,Ox39b);if(Ox397[OxO4ff4[2]]==null){continue ;} ;if(Ox397[OxO4ff4[4]]==1){Element_RemoveNode(Ox397,true);} else {Ox397[OxO4ff4[4]]=Ox397[OxO4ff4[4]]-1;} ;} ;Ox4[OxO4ff4[18]]--;Table_CleanUpTableInfo(Ox395,Ox4);} ;var richDropDown=Window_GetElement(window,OxO4ff4[24],true);var list_Templates=Window_GetElement(window,OxO4ff4[25],true);var subcolumns=Window_GetElement(window,OxO4ff4[26],true);var addcolumns=Window_GetElement(window,OxO4ff4[27],true);var subcolspan=Window_GetElement(window,OxO4ff4[28],true);var addcolspan=Window_GetElement(window,OxO4ff4[29],true);var btn_row_dialog=Window_GetElement(window,OxO4ff4[30],true);var btn_cell_dialog=Window_GetElement(window,OxO4ff4[31],true);var inp_cell_width=Window_GetElement(window,OxO4ff4[32],true);var inp_cell_height=Window_GetElement(window,OxO4ff4[33],true);var btn_cell_editcell=Window_GetElement(window,OxO4ff4[34],true);var tabledesign=Window_GetElement(window,OxO4ff4[35],true);var subrows=Window_GetElement(window,OxO4ff4[36],true);var addrows=Window_GetElement(window,OxO4ff4[37],true);var subrowspan=Window_GetElement(window,OxO4ff4[38],true);var addrowspan=Window_GetElement(window,OxO4ff4[39],true);btn_cell_editcell[OxO4ff4[41]][OxO4ff4[40]]=OxO4ff4[42];UpdateState=function UpdateState_InsertTable(){btn_cell_editcell[OxO4ff4[43]]=btn_row_dialog[OxO4ff4[43]]=btn_cell_dialog[OxO4ff4[43]]=GetElementCell()==null;} ;SyncToView=function SyncToView_InsertTable(){var Ox553=GetElementCell();if(Ox553){inp_cell_width[OxO4ff4[44]]=Ox553[OxO4ff4[45]];inp_cell_height[OxO4ff4[44]]=Ox553[OxO4ff4[46]];} ;} ;SyncTo=function SyncTo_InsertTable(element){var Ox553=GetElementCell();if(Ox553){try{Ox553[OxO4ff4[45]]=inp_cell_width[OxO4ff4[44]];Ox553[OxO4ff4[46]]=inp_cell_height[OxO4ff4[44]];} catch(er){alert(OxO4ff4[47]);} ;} ;} ;function selectTemplate(Ox9a){var Ox556=OxO4ff4[48];switch(Ox9a){case 1:Ox556=OxO4ff4[49];break ;;case 2:Ox556=OxO4ff4[50];break ;;case 3:Ox556=OxO4ff4[51];break ;;case 4:Ox556=OxO4ff4[52];Ox556=Ox556+OxO4ff4[53];Ox556=Ox556+OxO4ff4[54];break ;;case 5:Ox556=OxO4ff4[52];Ox556=Ox556+OxO4ff4[55];break ;;case 6:Ox556=OxO4ff4[56];Ox556=Ox556+OxO4ff4[57];Ox556=Ox556+OxO4ff4[58];break ;;default:break ;;} ;try{var Ox7c=document.createElement(OxO4ff4[59]);Ox7c[OxO4ff4[13]]=Ox556;var Ox395=Ox7c.children(0);ApplyTable(Ox395,element);ApplyTable(Ox395,tabledesign);HandleTableChanged();hidePopup();} catch(x){} ;} ;subcolumns[OxO4ff4[60]]=function subcolumns_onclick(){Table_SubCol(GetElementCell());Table_SubCol(currentcell);HandleTableChanged();} ;addcolumns[OxO4ff4[60]]=function addcolumns_onclick(){Table_AddCol(GetElementCell());Table_AddCol(currentcell);HandleTableChanged();} ;subrows[OxO4ff4[60]]=function subrows_onclick(){Table_SubRow(GetElementCell());Table_SubRow(currentcell);HandleTableChanged();} ;addrows[OxO4ff4[60]]=function addrows_onclick(){Table_AddRow(currentcell);Table_AddRow(GetElementCell());HandleTableChanged();} ;subcolspan[OxO4ff4[60]]=function subcolspan_onclick(){Table_SubColSpan(GetElementCell());Table_SubColSpan(currentcell);HandleTableChanged();} ;addcolspan[OxO4ff4[60]]=function addcolspan_onclick(){Table_AddColSpan(GetElementCell());Table_AddColSpan(currentcell);HandleTableChanged();} ;subrowspan[OxO4ff4[60]]=function subrowspan_onclick(){Table_SubRowSpan(GetElementCell());Table_SubRowSpan(currentcell);HandleTableChanged();} ;addrowspan[OxO4ff4[60]]=function addrowspan_onclick(){Table_AddRowSpan(GetElementCell());Table_AddRowSpan(currentcell);HandleTableChanged();} ;function InitDesignTableCells(){for(var Oxa=0;Oxa<tabledesign[OxO4ff4[9]][OxO4ff4[10]];Oxa++){var Ox387=tabledesign[OxO4ff4[9]][Oxa];for(var Ox217=0;Ox217<Ox387[OxO4ff4[11]][OxO4ff4[10]];Ox217++){var Ox397=Ox387[OxO4ff4[11]][Ox217];Ox397.removeAttribute(OxO4ff4[45]);Ox397.removeAttribute(OxO4ff4[46]);Ox397[OxO4ff4[45]]=OxO4ff4[48];Ox397[OxO4ff4[46]]=OxO4ff4[48];Ox397[OxO4ff4[61]]=OxO4ff4[62];Ox397[OxO4ff4[63]]=cell_mouseover;Ox397[OxO4ff4[64]]=cell_mouseout;Ox397[OxO4ff4[60]]=cell_click;Ox397[OxO4ff4[65]]=cell_dblclick;} ;} ;} ;function Element_Contains(element,Ox183){if(!Browser_IsOpera()){if(element[OxO4ff4[66]]){return element.contains(Ox183);} ;} ;for(;Ox183!=null;Ox183=Ox183[OxO4ff4[2]]){if(element==Ox183){return true;} ;} ;return false;} ;function HandleTableChanged(){if(!Element_Contains(tabledesign,currentcell)){SetCurrentCell(tabledesign.rows(0).cells(0));} ;InitDesignTableCells();UpdateButtonStates();editor.ExecCommand(OxO4ff4[67]);editor.ExecCommand(OxO4ff4[67]);} ;function cell_mouseover(){var Ox397=this;Ox397[OxO4ff4[41]][OxO4ff4[68]]=OxO4ff4[69];} ;function cell_mouseout(){var Ox397=this;Ox397[OxO4ff4[41]][OxO4ff4[68]]=OxO4ff4[62];} ;function cell_click(){var Ox397=this;SetCurrentCell(Ox397);} ;function cell_dblclick(){var Ox397=this;SetCurrentCell(Ox397);} ;btn_cell_editcell[OxO4ff4[60]]=function btn_cell_editcell_onclick(){var Ox397=GetElementCell();var Ox283=editor.EditInWindow(Ox397.innerHTML,window);if(Ox283!=null&&Ox283!==false){Ox397[OxO4ff4[13]]=Ox283;} ;} ;btn_cell_dialog[OxO4ff4[60]]=function btn_cell_dialog_onclick(){editor.SetNextDialogWindow(window);editor.ShowTagDialogWithNoCancellable(GetElementCell());} ;btn_row_dialog[OxO4ff4[60]]=function btn_row_dialog_onclick(){editor.SetNextDialogWindow(window);editor.ShowTagDialogWithNoCancellable(GetElementCell().parentNode);} ;var currentcell=null;function GetElementCell(){if(currentcell==null){return null;} ;return element[OxO4ff4[9]][currentcell[OxO4ff4[2]][OxO4ff4[8]]][OxO4ff4[11]][currentcell[OxO4ff4[12]]];} ;function SetCurrentCell(Ox397){if(currentcell!=null){if(Browser_IsWinIE()){currentcell[OxO4ff4[71]][OxO4ff4[70]]=OxO4ff4[48];} else {currentcell[OxO4ff4[41]][OxO4ff4[70]]=OxO4ff4[48];} ;} ;currentcell=Ox397;if(Browser_IsWinIE()){currentcell[OxO4ff4[71]][OxO4ff4[70]]=OxO4ff4[72];} else {currentcell[OxO4ff4[41]][OxO4ff4[70]]=OxO4ff4[72];} ;UpdateButtonStates();SyncToViewInternal();} ;function UpdateButtonStates(){subcolspan[OxO4ff4[43]]=!Table_CanSubColSpan(currentcell);addcolspan[OxO4ff4[43]]=!Table_CanAddColSpan(currentcell);subrowspan[OxO4ff4[43]]=!Table_CanSubRowSpan(currentcell);addrowspan[OxO4ff4[43]]=!Table_CanAddRowSpan(currentcell);subrows[OxO4ff4[43]]=Table_GetRowCount(currentcell)<2;subcolumns[OxO4ff4[43]]=Table_GetColCount(currentcell)<2;} ;function ApplyTable(src,Ox56d){if(Browser_IsSafari()){Ox56d[OxO4ff4[41]][OxO4ff4[46]]=OxO4ff4[48];} ;for(var Oxa=Ox56d[OxO4ff4[9]][OxO4ff4[10]]-1;Oxa>=0;Oxa--){Ox56d[OxO4ff4[9]][Oxa].removeNode(true);} ;for(var Oxa=0;Oxa<src[OxO4ff4[9]][OxO4ff4[10]];Oxa++){var Ox56e=src[OxO4ff4[9]][Oxa];var Ox56f;if(!Browser_IsSafari()){Ox56f=Ox56d.insertRow(-1);} else {var Ox225=document.createElement(OxO4ff4[23]);Ox56d.appendChild(Ox225);Ox56f=Ox225.insertRow(-1);} ;Ox56f[OxO4ff4[41]][OxO4ff4[70]]=Ox56e[OxO4ff4[41]][OxO4ff4[70]];for(var Ox217=0;Ox217<Ox56e[OxO4ff4[11]][OxO4ff4[10]];Ox217++){var Ox570=Ox56e[OxO4ff4[11]][Ox217];var Ox571=Ox56f.insertCell(-1);Ox571[OxO4ff4[0]]=Ox570[OxO4ff4[0]];Ox571[OxO4ff4[4]]=Ox570[OxO4ff4[4]];Ox571[OxO4ff4[41]][OxO4ff4[70]]=Ox570[OxO4ff4[41]][OxO4ff4[70]];if(Browser_IsOpera()){Ox571[OxO4ff4[13]]=OxO4ff4[14];} else {if(Browser_IsGecko()||Browser_IsSafari()){Ox571[OxO4ff4[13]]=OxO4ff4[15];} ;} ;} ;} ;} ;window[OxO4ff4[73]]=function window_onload(){ApplyTable(element,tabledesign);InitDesignTableCells();SetCurrentCell(tabledesign[OxO4ff4[9]][0][OxO4ff4[11]][0]);} ;function updateList(){} ;var oPopup;if(Browser_IsWinIE()){oPopup=window.createPopup();} else {richDropDown[OxO4ff4[41]][OxO4ff4[40]]=OxO4ff4[42];} ;function selectTemplates(){if(Browser_IsWinIE()){oPopup[OxO4ff4[75]][OxO4ff4[74]][OxO4ff4[13]]=list_Templates[OxO4ff4[13]];oPopup[OxO4ff4[75]][OxO4ff4[74]][OxO4ff4[41]][OxO4ff4[76]]=OxO4ff4[77];oPopup.show(0,32,380,220,richDropDown);} ;} ;function hidePopup(){if(Browser_IsWinIE()){if(oPopup){if(oPopup[OxO4ff4[78]]){oPopup.hide();} ;} ;} ;} ;