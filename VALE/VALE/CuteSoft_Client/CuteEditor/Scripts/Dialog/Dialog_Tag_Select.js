var OxO1cdb=["inp_name","inp_access","inp_id","inp_index","inp_size","inp_Multiple","inp_Disabled","inp_item_text","inp_item_value","btnInsertItem","btnUpdateItem","btnDeleteItem","btnMoveUpItem","btnMoveDownItem","list_options","list_options2","inp_item_forecolor","inp_item_forecolor_Preview","inp_item_backcolor_Preview","text","value","color","style","backgroundColor","selectedIndex","options","Please select an item first","length","ondblclick","onclick","OPTION","document","id","cssText","Name","name","size","checked","disabled","multiple","tabIndex","","accessKey"];var inp_name=Window_GetElement(window,OxO1cdb[0],true);var inp_access=Window_GetElement(window,OxO1cdb[1],true);var inp_id=Window_GetElement(window,OxO1cdb[2],true);var inp_index=Window_GetElement(window,OxO1cdb[3],true);var inp_size=Window_GetElement(window,OxO1cdb[4],true);var inp_Multiple=Window_GetElement(window,OxO1cdb[5],true);var inp_Disabled=Window_GetElement(window,OxO1cdb[6],true);var inp_item_text=Window_GetElement(window,OxO1cdb[7],true);var inp_item_value=Window_GetElement(window,OxO1cdb[8],true);var btnInsertItem=Window_GetElement(window,OxO1cdb[9],true);var btnUpdateItem=Window_GetElement(window,OxO1cdb[10],true);var btnDeleteItem=Window_GetElement(window,OxO1cdb[11],true);var btnMoveUpItem=Window_GetElement(window,OxO1cdb[12],true);var btnMoveDownItem=Window_GetElement(window,OxO1cdb[13],true);var list_options=Window_GetElement(window,OxO1cdb[14],true);var list_options2=Window_GetElement(window,OxO1cdb[15],true);var inp_item_forecolor=Window_GetElement(window,OxO1cdb[16],true);var inp_item_forecolor=Window_GetElement(window,OxO1cdb[16],true);var inp_item_forecolor_Preview=Window_GetElement(window,OxO1cdb[17],true);var inp_item_backcolor_Preview=Window_GetElement(window,OxO1cdb[18],true);function SetOption(Ox1a6){Ox1a6[OxO1cdb[19]]=inp_item_text[OxO1cdb[20]];Ox1a6[OxO1cdb[20]]=inp_item_value[OxO1cdb[20]];Ox1a6[OxO1cdb[22]][OxO1cdb[21]]=inp_item_forecolor[OxO1cdb[20]];Ox1a6[OxO1cdb[22]][OxO1cdb[23]]=inp_item_backcolor[OxO1cdb[20]];} ;function SetOption2(Ox1a6){Ox1a6[OxO1cdb[19]]=inp_item_value[OxO1cdb[20]];Ox1a6[OxO1cdb[20]]=inp_item_text[OxO1cdb[20]];Ox1a6[OxO1cdb[22]][OxO1cdb[21]]=inp_item_forecolor[OxO1cdb[20]];Ox1a6[OxO1cdb[22]][OxO1cdb[23]]=inp_item_backcolor[OxO1cdb[20]];} ;function Select(Ox1a6){var Ox5a1=Ox1a6[OxO1cdb[24]];list_options[OxO1cdb[24]]=Ox5a1;list_options2[OxO1cdb[24]]=Ox5a1;inp_item_text[OxO1cdb[20]]=list_options2[OxO1cdb[20]];inp_item_value[OxO1cdb[20]]=list_options[OxO1cdb[20]];} ;function Insert(){var Ox1a6= new Option();SetOption(Ox1a6);list_options[OxO1cdb[25]].add(Ox1a6);var Ox5a3= new Option();SetOption2(Ox5a3);list_options2[OxO1cdb[25]].add(Ox5a3);FireUIChanged();} ;function Update(){if(list_options[OxO1cdb[24]]==-1){alert(OxO1cdb[26]);return ;} ;var Ox1a6=list_options.options(list_options.selectedIndex);SetOption(Ox1a6);var Ox5a3=list_options2.options(list_options2.selectedIndex);SetOption2(Ox5a3);FireUIChanged();} ;function Move(Ox142){var Ox5a1=list_options[OxO1cdb[24]];if(Ox5a1<0){return ;} ;var Ox5a5=Ox5a1-Ox142;if(Ox5a5<0){Ox5a5=0;} ;if(Ox5a5>(list_options[OxO1cdb[25]][OxO1cdb[27]]-1)){Ox5a5=list_options[OxO1cdb[25]][OxO1cdb[27]]-1;} ;if(Ox5a1==Ox5a5){return ;} ;var Ox1a6=list_options.options(list_options.selectedIndex);var Ox12=list_options2[OxO1cdb[20]];var Ox8=list_options[OxO1cdb[20]];Delete();inp_item_text[OxO1cdb[20]]=Ox12;inp_item_value[OxO1cdb[20]]=Ox8;var Ox1a6= new Option();SetOption(Ox1a6);list_options[OxO1cdb[25]].add(Ox1a6,Ox5a5);var Ox5a3= new Option();SetOption2(Ox5a3);list_options2[OxO1cdb[25]].add(Ox5a3,Ox5a5);list_options[OxO1cdb[24]]=Ox5a5;list_options2[OxO1cdb[24]]=Ox5a5;FireUIChanged();} ;function Delete(){if(list_options[OxO1cdb[24]]==-1||list_options[OxO1cdb[24]]==-1){alert(OxO1cdb[26]);return ;} ;var Ox5a6=list_options[OxO1cdb[24]];var Ox1a6=list_options.options(list_options.selectedIndex);Ox1a6.removeNode(true);Ox1a6=list_options2.options(list_options2.selectedIndex);Ox1a6.removeNode(true);if(list_options[OxO1cdb[25]][OxO1cdb[27]]>Ox5a6){list_options[OxO1cdb[24]]=Ox5a6;} else {if(list_options[OxO1cdb[25]][OxO1cdb[27]]){list_options[OxO1cdb[24]]=list_options[OxO1cdb[25]][OxO1cdb[27]]-1;} ;} ;list_options.ondblclick();if(list_options2[OxO1cdb[25]][OxO1cdb[27]]>Ox5a6){list_options2[OxO1cdb[24]]=Ox5a6;} else {if(list_options2[OxO1cdb[25]][OxO1cdb[27]]){list_options2[OxO1cdb[24]]=list_options2[OxO1cdb[25]][OxO1cdb[27]]-1;} ;} ;FireUIChanged();} ;list_options[OxO1cdb[28]]=function list_options_ondblclick(){if(list_options[OxO1cdb[24]]==-1){return ;} ;var Ox1a6=list_options.options(list_options.selectedIndex);inp_item_text[OxO1cdb[20]]=Ox1a6[OxO1cdb[19]];inp_item_value[OxO1cdb[20]]=Ox1a6[OxO1cdb[20]];inp_item_forecolor[OxO1cdb[20]]=inp_item_forecolor[OxO1cdb[22]][OxO1cdb[23]]=inp_item_forecolor_Preview[OxO1cdb[22]][OxO1cdb[23]]=Ox1a6[OxO1cdb[22]][OxO1cdb[21]];inp_item_backcolor[OxO1cdb[20]]=inp_item_backcolor[OxO1cdb[22]][OxO1cdb[23]]=inp_item_backcolor_Preview[OxO1cdb[22]][OxO1cdb[23]]=Ox1a6[OxO1cdb[22]][OxO1cdb[23]];} ;inp_item_forecolor[OxO1cdb[29]]=inp_item_forecolor_Preview[OxO1cdb[29]]=function inp_item_forecolor_onclick(){SelectColor(inp_item_forecolor,inp_item_forecolor_Preview);} ;inp_item_backcolor[OxO1cdb[29]]=inp_item_backcolor_Preview[OxO1cdb[29]]=function inp_item_backcolor_onclick(){SelectColor(inp_item_backcolor,inp_item_backcolor_Preview);} ;function CopySelect(Ox5ab,Ox5ac){Ox5ac[OxO1cdb[25]][OxO1cdb[27]]=0;for(var i=0;i<Ox5ab[OxO1cdb[25]][OxO1cdb[27]];i++){var Ox5ad=Ox5ab[OxO1cdb[25]][i];var Ox5a3;if(Browser_IsWinIE()){Ox5a3=Ox5ac[OxO1cdb[31]].createElement(OxO1cdb[30]);} else {Ox5a3=document.createElement(OxO1cdb[30]);} ;if(Ox5ac[OxO1cdb[32]]!=OxO1cdb[15]){Ox5a3[OxO1cdb[20]]=Ox5ad[OxO1cdb[20]];Ox5a3[OxO1cdb[19]]=Ox5ad[OxO1cdb[19]];} else {Ox5a3[OxO1cdb[20]]=Ox5ad[OxO1cdb[19]];Ox5a3[OxO1cdb[19]]=Ox5ad[OxO1cdb[20]];} ;Ox5a3[OxO1cdb[22]][OxO1cdb[33]]=Ox5ad[OxO1cdb[22]][OxO1cdb[33]];Ox5ac[OxO1cdb[25]].add(Ox5a3);} ;Ox5ac[OxO1cdb[24]]=Ox5ab[OxO1cdb[24]];} ;UpdateState=function UpdateState_Select(){} ;SyncToView=function SyncToView_Select(){if(element[OxO1cdb[34]]){inp_name[OxO1cdb[20]]=element[OxO1cdb[34]];} ;if(element[OxO1cdb[35]]){inp_name[OxO1cdb[20]]=element[OxO1cdb[35]];} ;inp_id[OxO1cdb[20]]=element[OxO1cdb[32]];inp_size[OxO1cdb[20]]=element[OxO1cdb[36]];CopySelect(element,list_options);CopySelect(element,list_options2);inp_Disabled[OxO1cdb[37]]=element[OxO1cdb[38]];inp_Multiple[OxO1cdb[37]]=element[OxO1cdb[39]];if(element[OxO1cdb[40]]==0){inp_index[OxO1cdb[20]]=OxO1cdb[41];} else {inp_index[OxO1cdb[20]]=element[OxO1cdb[40]];} ;if(element[OxO1cdb[42]]){inp_access[OxO1cdb[20]]=element[OxO1cdb[42]];} ;} ;SyncTo=function SyncTo_Select(element){element[OxO1cdb[35]]=inp_name[OxO1cdb[20]];if(element[OxO1cdb[34]]){element[OxO1cdb[34]]=inp_name[OxO1cdb[20]];} else {if(element[OxO1cdb[35]]){element.removeAttribute(OxO1cdb[35],0);element[OxO1cdb[34]]=inp_name[OxO1cdb[20]];} else {element[OxO1cdb[34]]=inp_name[OxO1cdb[20]];} ;} ;element[OxO1cdb[32]]=inp_id[OxO1cdb[20]];element[OxO1cdb[36]]=inp_size[OxO1cdb[20]];element[OxO1cdb[38]]=inp_Disabled[OxO1cdb[37]];element[OxO1cdb[39]]=inp_Multiple[OxO1cdb[37]];element[OxO1cdb[42]]=inp_access[OxO1cdb[20]];element[OxO1cdb[40]]=inp_index[OxO1cdb[20]];if(element[OxO1cdb[40]]==OxO1cdb[41]){element.removeAttribute(OxO1cdb[40]);} ;if(element[OxO1cdb[42]]==OxO1cdb[41]){element.removeAttribute(OxO1cdb[42]);} ;CopySelect(list_options,element);} ;