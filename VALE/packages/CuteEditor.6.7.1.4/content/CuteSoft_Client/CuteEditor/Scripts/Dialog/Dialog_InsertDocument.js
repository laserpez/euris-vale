var OxO506e=["top","hiddenDirectory","hiddenFile","hiddenAlert","hiddenAction","hiddenActionData","This function is disabled in the demo mode.","disabled","[[Disabled]]","[[SpecifyNewFolderName]]","","value","createdir","[[CopyMoveto]]","/","move","copy","[[AreyouSureDelete]]","parentNode","text","isdir","true",".","[[SpecifyNewFileName]]","rename","True","False",":","path","FoldersAndFiles","TR","length","onmouseover","this.style.backgroundColor=\x27#eeeeee\x27;","onmouseout","this.style.backgroundColor=\x27\x27;","nodeName","INPUT","changedir","url","TargetUrl","htmlcode","onload","getElementsByTagName","table","sortable"," ","className","id","rows","cells","innerHTML","\x3Ca href=\x22#\x22 onclick=\x22ts_resortTable(this);return false;\x22\x3E","\x3Cspan class=\x22sortarrow\x22\x3E\x26nbsp;\x3C/span\x3E\x3C/a\x3E","string","undefined","innerText","childNodes","nodeValue","nodeType","span","cellIndex","TABLE","sortdir","down","\x26uarr;","up","\x26darr;","sortbottom","tBodies","sortarrow","\x26nbsp;","20","19","browse_Frame","Image1","FolderDescription","CreateDir","Copy","Move","Delete","DoRefresh","name_Cell","size_Cell","op_Cell","divpreview","sel_target","inp_color","inp_color_preview","inc_class","inp_id","inp_index","inp_access","Table8","inp_title","btn_zoom_in","btn_zoom_out","btn_Actualsize","a","editor","documentElement","documentMode","clientHeight","scrollHeight","width","style","255px","appName","Microsoft Internet Explorer","userAgent","MSIE ([0-9]{1,}[.0-9]{0,})","color","backgroundColor","class","title","target","tabIndex","accessKey","href","href_cetemp",".jpeg",".jpg",".gif",".png","\x3CIMG src=\x27","\x27\x3E",".bmp","\x26nbsp;\x3Cembed src=\x22","\x22 quality=\x22high\x22 width=\x22200\x22 height=\x22200\x22 type=\x22application/x-shockwave-flash\x22 pluginspage=\x22http://www.macromedia.com/go/getflashplayer\x22\x3E\x3C/embed\x3E\x0A",".swf",".avi",".mpg",".mp3","\x26nbsp;\x3Cembed name=\x22MediaPlayer1\x22 src=\x22","\x22 autostart=-1 showcontrols=-1  type=\x22application/x-mplayer2\x22 width=\x22240\x22 height=\x22200\x22 pluginspage=\x22http://www.microsoft.com/Windows/MediaPlayer\x22 \x3E\x3C/embed\x3E\x0A",".mpeg","\x3Cdiv\x3E\x3C/div\x3E","\x3Cdiv\x3E\x26nbsp;\x3C/div\x3E","\x3Cdiv\x3E\x26#160;\x3C/div\x3E","\x3Cp\x3E\x3C/p\x3E","\x3Cp\x3E\x26#160;\x3C/p\x3E","\x3Cp\x3E\x26nbsp;\x3C/p\x3E","name","zoom","onclick","display","none","align","absmiddle","wrapupPrompt","iepromptfield","body","div","IEPromptBox","promptBlackout","border","1px solid #b0bec7","#f0f0f0","position","absolute","330px","zIndex","100","\x3Cdiv style=\x22width: 100%; padding-top:3px;background-color: #DCE7EB; font-family: verdana; font-size: 10pt; font-weight: bold; height: 22px; text-align:center; background:url(Load.ashx?type=image\x26file=formbg2.gif) repeat-x left top;\x22\x3E[[InputRequired]]\x3C/div\x3E","\x3Cdiv style=\x22padding: 10px\x22\x3E","\x3CBR\x3E\x3CBR\x3E","\x3Cform action=\x22\x22 onsubmit=\x22return wrapupPrompt()\x22\x3E","\x3Cinput id=\x22iepromptfield\x22 name=\x22iepromptdata\x22 type=text size=46 value=\x22","\x22\x3E","\x3Cbr\x3E\x3Cbr\x3E\x3Ccenter\x3E","\x3Cinput type=\x22submit\x22 value=\x22\x26nbsp;\x26nbsp;\x26nbsp;[[OK]]\x26nbsp;\x26nbsp;\x26nbsp;\x22\x3E","\x26nbsp;\x26nbsp;\x26nbsp;\x26nbsp;\x26nbsp;\x26nbsp;","\x3Cinput type=\x22button\x22 onclick=\x22wrapupPrompt(true)\x22 value=\x22\x26nbsp;[[Cancel]]\x26nbsp;\x22\x3E","\x3C/form\x3E\x3C/div\x3E","100px","left","offsetWidth","px","block","CuteEditor_ColorPicker_ButtonOver(this)"];function Window_GetDialogTop(Ox1a8){return Ox1a8[OxO506e[0]];} ;var hiddenDirectory=Window_GetElement(window,OxO506e[1],true);var hiddenFile=Window_GetElement(window,OxO506e[2],true);var hiddenAlert=Window_GetElement(window,OxO506e[3],true);var hiddenAction=Window_GetElement(window,OxO506e[4],true);var hiddenActionData=Window_GetElement(window,OxO506e[5],true);function CreateDir_click(){if(isDemoMode){alert(OxO506e[6]);return false;} ;if(Event_GetSrcElement()[OxO506e[7]]){alert(OxO506e[8]);return false;} ;if(Browser_IsIE7()){IEprompt(Ox221,OxO506e[9],OxO506e[10]);function Ox221(Ox382){if(Ox382){hiddenActionData[OxO506e[11]]=Ox382;hiddenAction[OxO506e[11]]=OxO506e[12];window.PostBackAction();return true;} else {return false;} ;} ;return Event_CancelEvent();} else {var Ox382=prompt(OxO506e[9],OxO506e[10]);if(Ox382){hiddenActionData[OxO506e[11]]=Ox382;return true;} else {return false;} ;return false;} ;} ;function Move_click(){if(isDemoMode){alert(OxO506e[6]);return false;} ;if(Event_GetSrcElement()[OxO506e[7]]){alert(OxO506e[8]);return false;} ;if(Browser_IsIE7()){IEprompt(Ox221,OxO506e[13],OxO506e[14]);function Ox221(Ox382){if(Ox382){hiddenActionData[OxO506e[11]]=Ox382;hiddenAction[OxO506e[11]]=OxO506e[15];window.PostBackAction();return true;} else {return false;} ;} ;return Event_CancelEvent();} else {var Ox382=prompt(OxO506e[13],OxO506e[14]);if(Ox382){hiddenActionData[OxO506e[11]]=Ox382;return true;} else {return false;} ;return false;} ;} ;function Copy_click(){if(isDemoMode){alert(OxO506e[6]);return false;} ;if(Event_GetSrcElement()[OxO506e[7]]){alert(OxO506e[8]);return false;} ;if(Browser_IsIE7()){IEprompt(Ox221,OxO506e[13],OxO506e[14]);function Ox221(Ox382){if(Ox382){hiddenActionData[OxO506e[11]]=Ox382;hiddenAction[OxO506e[11]]=OxO506e[16];window.PostBackAction();return true;} else {return false;} ;} ;return Event_CancelEvent();} else {var Ox382=prompt(OxO506e[13],OxO506e[14]);if(Ox382){hiddenActionData[OxO506e[11]]=Ox382;return true;} else {return false;} ;return false;} ;} ;function Delete_click(){if(isDemoMode){alert(OxO506e[6]);return false;} ;if(Event_GetSrcElement()[OxO506e[7]]){alert(OxO506e[8]);return false;} ;return confirm(OxO506e[17]);} ;function EditImg_click(img){if(isDemoMode){alert(OxO506e[6]);return false;} ;if(img[OxO506e[7]]){alert(OxO506e[8]);return false;} ;var Ox387=img[OxO506e[18]][OxO506e[18]];var Ox388=Ox387.getAttribute(OxO506e[19]);var name;var Ox389;Ox389=Ox387.getAttribute(OxO506e[20])==OxO506e[21];if(Browser_IsIE7()){var Oxca;if(Ox389){IEprompt(Ox221,OxO506e[9],Ox388);} else {var i=Ox388.lastIndexOf(OxO506e[22]);Oxca=Ox388.substr(i);var Ox12=Ox388.substr(0,Ox388.lastIndexOf(OxO506e[22]));IEprompt(Ox221,OxO506e[23],Ox12);} ;function Ox221(Ox382){if(Ox382&&Ox382!=Ox387.getAttribute(OxO506e[19])){if(!Ox389){Ox382=Ox382+Oxca;} ;hiddenAction[OxO506e[11]]=OxO506e[24];hiddenActionData[OxO506e[11]]=(Ox389?OxO506e[25]:OxO506e[26])+OxO506e[27]+Ox387.getAttribute(OxO506e[28])+OxO506e[27]+Ox382;window.PostBackAction();} ;} ;} else {if(Ox389){name=prompt(OxO506e[9],Ox388);} else {var i=Ox388.lastIndexOf(OxO506e[22]);var Oxca=Ox388.substr(i);var Ox12=Ox388.substr(0,Ox388.lastIndexOf(OxO506e[22]));name=prompt(OxO506e[23],Ox12);if(name){name=name+Oxca;} ;} ;if(name&&name!=Ox387.getAttribute(OxO506e[19])){hiddenAction[OxO506e[11]]=OxO506e[24];hiddenActionData[OxO506e[11]]=(Ox389?OxO506e[25]:OxO506e[26])+OxO506e[27]+Ox387.getAttribute(OxO506e[28])+OxO506e[27]+name;window.PostBackAction();} ;} ;return Event_CancelEvent();} ;setMouseOver();function setMouseOver(){var FoldersAndFiles=Window_GetElement(window,OxO506e[29],true);var Ox38c=FoldersAndFiles.getElementsByTagName(OxO506e[30]);for(var i=1;i<Ox38c[OxO506e[31]];i++){var Ox387=Ox38c[i];Ox387[OxO506e[32]]= new Function(OxO506e[10],OxO506e[33]);Ox387[OxO506e[34]]= new Function(OxO506e[10],OxO506e[35]);} ;} ;function row_click(Ox387){var Ox389;Ox389=Ox387.getAttribute(OxO506e[20])==OxO506e[21];if(Ox389){if(Event_GetSrcElement()[OxO506e[36]]==OxO506e[37]){return ;} ;hiddenAction[OxO506e[11]]=OxO506e[38];hiddenActionData[OxO506e[11]]=Ox387.getAttribute(OxO506e[28]);window.PostBackAction();} else {var Ox109=Ox387.getAttribute(OxO506e[28]);hiddenFile[OxO506e[11]]=Ox109;var Ox288=Ox387.getAttribute(OxO506e[39]);Window_GetElement(window,OxO506e[40],true)[OxO506e[11]]=Ox288;var htmlcode=Ox387.getAttribute(OxO506e[41]);if(htmlcode!=OxO506e[10]&&htmlcode!=null){do_preview(htmlcode);} else {try{Actualsize();} catch(x){do_preview();} ;} ;} ;} ;function do_preview(){} ;function reset_hiddens(){if(hiddenAlert[OxO506e[11]]){alert(hiddenAlert.value);} ;if(TargetUrl[OxO506e[11]]!=OxO506e[10]&&TargetUrl[OxO506e[11]]!=null){do_preview();} ;hiddenAlert[OxO506e[11]]=OxO506e[10];hiddenAction[OxO506e[11]]=OxO506e[10];hiddenActionData[OxO506e[11]]=OxO506e[10];} ;Event_Attach(window,OxO506e[42],reset_hiddens);function RequireFileBrowseScript(){} ;Event_Attach(window,OxO506e[42],sortables_init);var SORT_COLUMN_INDEX;function sortables_init(){if(!document[OxO506e[43]]){return ;} ;var Ox391=document.getElementsByTagName(OxO506e[44]);for(var Ox392=0;Ox392<Ox391[OxO506e[31]];Ox392++){var Ox393=Ox391[Ox392];if(((OxO506e[46]+Ox393[OxO506e[47]]+OxO506e[46]).indexOf(OxO506e[45])!=-1)&&(Ox393[OxO506e[48]])){ts_makeSortable(Ox393);} ;} ;} ;function ts_makeSortable(Ox395){if(Ox395[OxO506e[49]]&&Ox395[OxO506e[49]][OxO506e[31]]>0){var Ox396=Ox395[OxO506e[49]][0];} ;if(!Ox396){return ;} ;for(var i=2;i<4;i++){var Ox397=Ox396[OxO506e[50]][i];var Ox219=ts_getInnerText(Ox397);Ox397[OxO506e[51]]=OxO506e[52]+Ox219+OxO506e[53];} ;} ;function ts_getInnerText(Ox29){if( typeof Ox29==OxO506e[54]){return Ox29;} ;if( typeof Ox29==OxO506e[55]){return Ox29;} ;if(Ox29[OxO506e[56]]){return Ox29[OxO506e[56]];} ;var Ox24=OxO506e[10];var Ox343=Ox29[OxO506e[57]];var Ox11=Ox343[OxO506e[31]];for(var i=0;i<Ox11;i++){switch(Ox343[i][OxO506e[59]]){case 1:Ox24+=ts_getInnerText(Ox343[i]);break ;;case 3:Ox24+=Ox343[i][OxO506e[58]];break ;;} ;} ;return Ox24;} ;function ts_resortTable(Ox39a){var Ox2a6;for(var Ox39b=0;Ox39b<Ox39a[OxO506e[57]][OxO506e[31]];Ox39b++){if(Ox39a[OxO506e[57]][Ox39b][OxO506e[36]]&&Ox39a[OxO506e[57]][Ox39b][OxO506e[36]].toLowerCase()==OxO506e[60]){Ox2a6=Ox39a[OxO506e[57]][Ox39b];} ;} ;var Ox39c=ts_getInnerText(Ox2a6);var Ox1e4=Ox39a[OxO506e[18]];var Ox39d=Ox1e4[OxO506e[61]];var Ox395=getParent(Ox1e4,OxO506e[62]);if(Ox395[OxO506e[49]][OxO506e[31]]<=1){return ;} ;var Ox39e=ts_getInnerText(Ox395[OxO506e[49]][1][OxO506e[50]][Ox39d]);var Ox39f=ts_sort_caseinsensitive;if(Ox39e.match(/^\d\d[\/-]\d\d[\/-]\d\d\d\d$/)){Ox39f=ts_sort_date;} ;if(Ox39e.match(/^\d\d[\/-]\d\d[\/-]\d\d$/)){Ox39f=ts_sort_date;} ;if(Ox39e.match(/^[?]/)){Ox39f=ts_sort_currency;} ;if(Ox39e.match(/^[\d\.]+$/)){Ox39f=ts_sort_numeric;} ;SORT_COLUMN_INDEX=Ox39d;var Ox396= new Array();var Ox3a0= new Array();for(var i=0;i<Ox395[OxO506e[49]][0][OxO506e[31]];i++){Ox396[i]=Ox395[OxO506e[49]][0][i];} ;for(var Ox25=1;Ox25<Ox395[OxO506e[49]][OxO506e[31]];Ox25++){Ox3a0[Ox25-1]=Ox395[OxO506e[49]][Ox25];} ;Ox3a0.sort(Ox39f);if(Ox2a6.getAttribute(OxO506e[63])==OxO506e[64]){var Ox3a1=OxO506e[65];Ox3a0.reverse();Ox2a6.setAttribute(OxO506e[63],OxO506e[66]);} else {Ox3a1=OxO506e[67];Ox2a6.setAttribute(OxO506e[63],OxO506e[64]);} ;for(i=0;i<Ox3a0[OxO506e[31]];i++){if(!Ox3a0[i][OxO506e[47]]||(Ox3a0[i][OxO506e[47]]&&(Ox3a0[i][OxO506e[47]].indexOf(OxO506e[68])==-1))){Ox395[OxO506e[69]][0].appendChild(Ox3a0[i]);} ;} ;for(i=0;i<Ox3a0[OxO506e[31]];i++){if(Ox3a0[i][OxO506e[47]]&&(Ox3a0[i][OxO506e[47]].indexOf(OxO506e[68])!=-1)){Ox395[OxO506e[69]][0].appendChild(Ox3a0[i]);} ;} ;var Ox3a2=document.getElementsByTagName(OxO506e[60]);for(var Ox39b=0;Ox39b<Ox3a2[OxO506e[31]];Ox39b++){if(Ox3a2[Ox39b][OxO506e[47]]==OxO506e[70]){if(getParent(Ox3a2[Ox39b],OxO506e[44])==getParent(Ox39a,OxO506e[44])){Ox3a2[Ox39b][OxO506e[51]]=OxO506e[71];} ;} ;} ;Ox2a6[OxO506e[51]]=Ox3a1;} ;function getParent(Ox29,Ox3a4){if(Ox29==null){return null;} else {if(Ox29[OxO506e[59]]==1&&Ox29[OxO506e[36]].toLowerCase()==Ox3a4.toLowerCase()){return Ox29;} else {return getParent(Ox29.parentNode,Ox3a4);} ;} ;} ;function ts_sort_date(Oxee,b){var Ox3a6=ts_getInnerText(Oxee[OxO506e[50]][SORT_COLUMN_INDEX]);var Ox3a7=ts_getInnerText(b[OxO506e[50]][SORT_COLUMN_INDEX]);if(Ox3a6[OxO506e[31]]==10){var Ox3a8=Ox3a6.substr(6,4)+Ox3a6.substr(3,2)+Ox3a6.substr(0,2);} else {var Ox3a9=Ox3a6.substr(6,2);if(parseInt(Ox3a9)<50){Ox3a9=OxO506e[72]+Ox3a9;} else {Ox3a9=OxO506e[73]+Ox3a9;} ;var Ox3a8=Ox3a9+Ox3a6.substr(3,2)+Ox3a6.substr(0,2);} ;if(Ox3a7[OxO506e[31]]==10){var Ox3aa=Ox3a7.substr(6,4)+Ox3a7.substr(3,2)+Ox3a7.substr(0,2);} else {Ox3a9=Ox3a7.substr(6,2);if(parseInt(Ox3a9)<50){Ox3a9=OxO506e[72]+Ox3a9;} else {Ox3a9=OxO506e[73]+Ox3a9;} ;var Ox3aa=Ox3a9+Ox3a7.substr(3,2)+Ox3a7.substr(0,2);} ;if(Ox3a8==Ox3aa){return 0;} ;if(Ox3a8<Ox3aa){return -1;} ;return 1;} ;function ts_sort_currency(Oxee,b){var Ox3a6=ts_getInnerText(Oxee[OxO506e[50]][SORT_COLUMN_INDEX]).replace(/[^0-9.]/g,OxO506e[10]);var Ox3a7=ts_getInnerText(b[OxO506e[50]][SORT_COLUMN_INDEX]).replace(/[^0-9.]/g,OxO506e[10]);return parseFloat(Ox3a6)-parseFloat(Ox3a7);} ;function ts_sort_numeric(Oxee,b){var Ox3a6=parseFloat(ts_getInnerText(Oxee[OxO506e[50]][SORT_COLUMN_INDEX]));if(isNaN(Ox3a6)){Ox3a6=0;} ;var Ox3a7=parseFloat(ts_getInnerText(b[OxO506e[50]][SORT_COLUMN_INDEX]));if(isNaN(Ox3a7)){Ox3a7=0;} ;return Ox3a6-Ox3a7;} ;function ts_sort_caseinsensitive(Oxee,b){var Ox3a6=ts_getInnerText(Oxee[OxO506e[50]][SORT_COLUMN_INDEX]).toLowerCase();var Ox3a7=ts_getInnerText(b[OxO506e[50]][SORT_COLUMN_INDEX]).toLowerCase();if(Ox3a6==Ox3a7){return 0;} ;if(Ox3a6<Ox3a7){return -1;} ;return 1;} ;function ts_sort_default(Oxee,b){var Ox3a6=ts_getInnerText(Oxee[OxO506e[50]][SORT_COLUMN_INDEX]);var Ox3a7=ts_getInnerText(b[OxO506e[50]][SORT_COLUMN_INDEX]);if(Ox3a6==Ox3a7){return 0;} ;if(Ox3a6<Ox3a7){return -1;} ;return 1;} [sortables_init];RequireFileBrowseScript();var browse_Frame=Window_GetElement(window,OxO506e[74],true);var hiddenDirectory=Window_GetElement(window,OxO506e[1],true);var hiddenFile=Window_GetElement(window,OxO506e[2],true);var hiddenAlert=Window_GetElement(window,OxO506e[3],true);var hiddenAction=Window_GetElement(window,OxO506e[4],true);var hiddenActionData=Window_GetElement(window,OxO506e[5],true);var Image1=Window_GetElement(window,OxO506e[75],true);var FolderDescription=Window_GetElement(window,OxO506e[76],true);var CreateDir=Window_GetElement(window,OxO506e[77],true);var Copy=Window_GetElement(window,OxO506e[78],true);var Move=Window_GetElement(window,OxO506e[79],true);var FoldersAndFiles=Window_GetElement(window,OxO506e[29],true);var Delete=Window_GetElement(window,OxO506e[80],true);var DoRefresh=Window_GetElement(window,OxO506e[81],true);var name_Cell=Window_GetElement(window,OxO506e[82],true);var size_Cell=Window_GetElement(window,OxO506e[83],true);var op_Cell=Window_GetElement(window,OxO506e[84],true);var divpreview=Window_GetElement(window,OxO506e[85],true);var sel_target=Window_GetElement(window,OxO506e[86],true);var inp_color=Window_GetElement(window,OxO506e[87],true);var inp_color_preview=Window_GetElement(window,OxO506e[88],true);var inc_class=Window_GetElement(window,OxO506e[89],true);var inp_id=Window_GetElement(window,OxO506e[90],true);var inp_index=Window_GetElement(window,OxO506e[91],true);var inp_access=Window_GetElement(window,OxO506e[92],true);var Table8=Window_GetElement(window,OxO506e[93],true);var TargetUrl=Window_GetElement(window,OxO506e[40],true);var inp_title=Window_GetElement(window,OxO506e[94],true);var btn_zoom_in=Window_GetElement(window,OxO506e[95],true);var btn_zoom_out=Window_GetElement(window,OxO506e[96],true);var btn_Actualsize=Window_GetElement(window,OxO506e[97],true);var obj=Window_GetDialogArguments(window);var element=null;if(obj){element=obj[OxO506e[98]];} ;var editor=obj[OxO506e[99]];var ver=getInternetExplorerVersion();if(ver>-1&&ver<=9.0){var needAdjust=true;if(ver>=8.0&&document[OxO506e[100]]){if(document[OxO506e[101]]>7){needAdjust=false;} ;} ;if(needAdjust&&(browse_Frame[OxO506e[102]]<browse_Frame[OxO506e[103]])){FoldersAndFiles[OxO506e[105]][OxO506e[104]]=OxO506e[106];} ;} ;function getInternetExplorerVersion(){var Ox3ca=-1;if(navigator[OxO506e[107]]==OxO506e[108]){var Ox3cb=navigator[OxO506e[109]];var Ox296= new RegExp(OxO506e[110]);if(Ox296.exec(Ox3cb)!=null){Ox3ca=parseFloat(RegExp.$1);} ;} ;return Ox3ca;} ;var htmlcode=OxO506e[10];if(element[OxO506e[105]][OxO506e[111]]){inp_color[OxO506e[11]]=revertColor(element[OxO506e[105]].color);inp_color[OxO506e[105]][OxO506e[112]]=inp_color[OxO506e[11]];inp_color_preview[OxO506e[105]][OxO506e[112]]=inp_color[OxO506e[11]];} ;if(element[OxO506e[47]]==OxO506e[10]){element.removeAttribute(OxO506e[47]);} ;if(element[OxO506e[47]]==OxO506e[10]){element.removeAttribute(OxO506e[113]);} ;if(element[OxO506e[114]]){inp_title[OxO506e[11]]=element[OxO506e[114]];} ;if(element[OxO506e[115]]){sel_target[OxO506e[11]]=element[OxO506e[115]];} ;if(element[OxO506e[116]]){inp_index[OxO506e[11]]=element[OxO506e[116]];} ;if(element[OxO506e[117]]){inp_access[OxO506e[11]]=element[OxO506e[117]];} ;var src=OxO506e[10];if(element.getAttribute(OxO506e[118])){src=element.getAttribute(OxO506e[118]);} ;if(element.getAttribute(OxO506e[119])){src=element.getAttribute(OxO506e[119]);} ;if(TargetUrl[OxO506e[11]]){Actualsize();} else {if(element&&src){TargetUrl[OxO506e[11]]=src;} ;} ;inp_id[OxO506e[11]]=element[OxO506e[48]];var divpreview=Window_GetElement(window,OxO506e[85],true);do_preview();function do_preview(Ox283){if(Ox283!=OxO506e[10]&&Ox283!=null){htmlcode=Ox283;divpreview[OxO506e[51]]=Ox283;return ;} ;divpreview[OxO506e[51]]=OxO506e[10];var Ox288=TargetUrl[OxO506e[11]];if(Ox288==OxO506e[10]){return ;} ;var Oxca=Ox288.substring(Ox288.lastIndexOf(OxO506e[22])).toLowerCase();switch(Oxca){case OxO506e[120]:;case OxO506e[121]:;case OxO506e[122]:;case OxO506e[123]:;case OxO506e[126]:divpreview[OxO506e[51]]=OxO506e[124]+Ox288+OxO506e[125];break ;;case OxO506e[129]:var Ox3cc=OxO506e[127]+Ox288+OxO506e[128];divpreview[OxO506e[51]]=Ox3cc+OxO506e[71];break ;;case OxO506e[130]:;case OxO506e[131]:;case OxO506e[132]:;case OxO506e[135]:var Ox3cd=OxO506e[133]+Ox288+OxO506e[134];divpreview[OxO506e[51]]=Ox3cd+OxO506e[71];break ;;} ;} ;function do_insert(){element[OxO506e[47]]=inc_class[OxO506e[11]];element[OxO506e[115]]=sel_target[OxO506e[11]];element[OxO506e[114]]=inp_title[OxO506e[11]];if(TargetUrl[OxO506e[11]]){element[OxO506e[118]]=TargetUrl[OxO506e[11]];element.setAttribute(OxO506e[119],TargetUrl.value);} ;element[OxO506e[116]]=inp_index[OxO506e[11]];element[OxO506e[117]]=inp_access[OxO506e[11]];element[OxO506e[48]]=inp_id[OxO506e[11]];if(element[OxO506e[114]]==OxO506e[10]){element.removeAttribute(OxO506e[114]);} ;if(element[OxO506e[115]]==OxO506e[10]){element.removeAttribute(OxO506e[115]);} ;if(element[OxO506e[47]]==OxO506e[10]){element.removeAttribute(OxO506e[47]);} ;if(element[OxO506e[47]]==OxO506e[10]){element.removeAttribute(OxO506e[113]);} ;if(element[OxO506e[116]]==OxO506e[10]){element.removeAttribute(OxO506e[116]);} ;if(element[OxO506e[117]]==OxO506e[10]){element.removeAttribute(OxO506e[117]);} ;if(element[OxO506e[48]]==OxO506e[10]){element.removeAttribute(OxO506e[48]);} ;try{element[OxO506e[105]][OxO506e[111]]=inp_color[OxO506e[11]];} catch(er){element[OxO506e[105]][OxO506e[111]]=OxO506e[10];} ;var Ox283=element[OxO506e[51]];switch(Ox283.toLowerCase()){case OxO506e[136]:;case OxO506e[137]:;case OxO506e[138]:;case OxO506e[139]:;case OxO506e[140]:;case OxO506e[141]:element[OxO506e[51]]=OxO506e[10];break ;;default:break ;;} ;if(element[OxO506e[51]]==OxO506e[10]){element[OxO506e[51]]=element[OxO506e[114]]||TargetUrl[OxO506e[11]]||element[OxO506e[142]]||OxO506e[10];} ;Window_SetDialogReturnValue(window,element);Window_CloseDialog(window);} ;function do_Close(){Window_SetDialogReturnValue(window,null);Window_CloseDialog(window);} ;function Zoom_In(){if(divpreview[OxO506e[105]][OxO506e[143]]!=0){divpreview[OxO506e[105]][OxO506e[143]]*=1.2;} else {divpreview[OxO506e[105]][OxO506e[143]]=1.2;} ;} ;function Zoom_Out(){if(divpreview[OxO506e[105]][OxO506e[143]]!=0){divpreview[OxO506e[105]][OxO506e[143]]*=0.8;} else {divpreview[OxO506e[105]][OxO506e[143]]=0.8;} ;} ;function Actualsize(){divpreview[OxO506e[105]][OxO506e[143]]=1;do_preview();} ;inp_color[OxO506e[144]]=inp_color_preview[OxO506e[144]]=function inp_color_onclick(){SelectColor(inp_color,inp_color_preview);} ;if(!Browser_IsWinIE()){btn_zoom_in[OxO506e[105]][OxO506e[145]]=btn_zoom_out[OxO506e[105]][OxO506e[145]]=btn_Actualsize[OxO506e[105]][OxO506e[145]]=OxO506e[146];inp_color_preview.setAttribute(OxO506e[147],OxO506e[148]);} ;if(Browser_IsIE7()){var _dialogPromptID=null;function IEprompt(Ox221,Ox222,Ox223){that=this;this[OxO506e[149]]=function (Ox224){val=document.getElementById(OxO506e[150])[OxO506e[11]];_dialogPromptID[OxO506e[105]][OxO506e[145]]=OxO506e[146];document.getElementById(OxO506e[150])[OxO506e[11]]=OxO506e[10];if(Ox224){val=OxO506e[10];} ;Ox221(val);return false;} ;if(Ox223==undefined){Ox223=OxO506e[10];} ;if(_dialogPromptID==null){var Ox225=document.getElementsByTagName(OxO506e[151])[0];tnode=document.createElement(OxO506e[152]);tnode[OxO506e[48]]=OxO506e[153];Ox225.appendChild(tnode);_dialogPromptID=document.getElementById(OxO506e[153]);tnode=document.createElement(OxO506e[152]);tnode[OxO506e[48]]=OxO506e[154];Ox225.appendChild(tnode);_dialogPromptID[OxO506e[105]][OxO506e[155]]=OxO506e[156];_dialogPromptID[OxO506e[105]][OxO506e[112]]=OxO506e[157];_dialogPromptID[OxO506e[105]][OxO506e[158]]=OxO506e[159];_dialogPromptID[OxO506e[105]][OxO506e[104]]=OxO506e[160];_dialogPromptID[OxO506e[105]][OxO506e[161]]=OxO506e[162];} ;var Ox226=OxO506e[163];Ox226+=OxO506e[164]+Ox222+OxO506e[165];Ox226+=OxO506e[166];Ox226+=OxO506e[167]+Ox223+OxO506e[168];Ox226+=OxO506e[169];Ox226+=OxO506e[170];Ox226+=OxO506e[171];Ox226+=OxO506e[172];Ox226+=OxO506e[173];_dialogPromptID[OxO506e[51]]=Ox226;_dialogPromptID[OxO506e[105]][OxO506e[0]]=OxO506e[174];_dialogPromptID[OxO506e[105]][OxO506e[175]]=parseInt((document[OxO506e[151]][OxO506e[176]]-315)/2)+OxO506e[177];_dialogPromptID[OxO506e[105]][OxO506e[145]]=OxO506e[178];var Ox227=document.getElementById(OxO506e[150]);try{var Ox228=Ox227.createTextRange();Ox228.collapse(false);Ox228.select();} catch(x){Ox227.focus();} ;} ;} ;if(CreateDir){CreateDir[OxO506e[32]]= new Function(OxO506e[179]);} ;if(Copy){Copy[OxO506e[32]]= new Function(OxO506e[179]);} ;if(Move){Move[OxO506e[32]]= new Function(OxO506e[179]);} ;if(Delete){Delete[OxO506e[32]]= new Function(OxO506e[179]);} ;if(DoRefresh){DoRefresh[OxO506e[32]]= new Function(OxO506e[179]);} ;if(btn_zoom_in){btn_zoom_in[OxO506e[32]]= new Function(OxO506e[179]);} ;if(btn_zoom_out){btn_zoom_out[OxO506e[32]]= new Function(OxO506e[179]);} ;if(btn_Actualsize){btn_Actualsize[OxO506e[32]]= new Function(OxO506e[179]);} ;