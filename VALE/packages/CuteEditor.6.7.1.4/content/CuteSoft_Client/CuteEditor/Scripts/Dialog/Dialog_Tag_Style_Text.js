var OxOb263=["","sel_align","sel_valign","sel_justify","sel_letter","tb_letter","sel_letter_unit","sel_line","tb_line","sel_line_unit","tb_indent","sel_indent_unit","sel_direction","sel_writingmode","outer","div_demo","disabled","selectedIndex","cssText","style","value","textAlign","verticalAlign","textJustify","letterSpacing","length","options","lineHeight","textIndent","direction","writingMode"];function ParseFloatToString(Ox24){var Ox8=parseFloat(Ox24);if(isNaN(Ox8)){return OxOb263[0];} ;return Ox8+OxOb263[0];} ;var sel_align=Window_GetElement(window,OxOb263[1],true);var sel_valign=Window_GetElement(window,OxOb263[2],true);var sel_justify=Window_GetElement(window,OxOb263[3],true);var sel_letter=Window_GetElement(window,OxOb263[4],true);var tb_letter=Window_GetElement(window,OxOb263[5],true);var sel_letter_unit=Window_GetElement(window,OxOb263[6],true);var sel_line=Window_GetElement(window,OxOb263[7],true);var tb_line=Window_GetElement(window,OxOb263[8],true);var sel_line_unit=Window_GetElement(window,OxOb263[9],true);var tb_indent=Window_GetElement(window,OxOb263[10],true);var sel_indent_unit=Window_GetElement(window,OxOb263[11],true);var sel_direction=Window_GetElement(window,OxOb263[12],true);var sel_writingmode=Window_GetElement(window,OxOb263[13],true);var outer=Window_GetElement(window,OxOb263[14],true);var div_demo=Window_GetElement(window,OxOb263[15],true);UpdateState=function UpdateState_Text(){tb_letter[OxOb263[16]]=sel_letter_unit[OxOb263[16]]=(sel_letter[OxOb263[17]]>0);tb_line[OxOb263[16]]=sel_line_unit[OxOb263[16]]=(sel_line[OxOb263[17]]>0);div_demo[OxOb263[19]][OxOb263[18]]=element[OxOb263[19]][OxOb263[18]];} ;SyncToView=function SyncToView_Text(){sel_align[OxOb263[20]]=element[OxOb263[19]][OxOb263[21]];sel_valign[OxOb263[20]]=element[OxOb263[19]][OxOb263[22]];sel_justify[OxOb263[20]]=element[OxOb263[19]][OxOb263[23]];sel_letter[OxOb263[20]]=element[OxOb263[19]][OxOb263[24]];sel_letter_unit[OxOb263[17]]=0;if(sel_letter[OxOb263[17]]==-1){if(ParseFloatToString(element[OxOb263[19]].letterSpacing)){tb_letter[OxOb263[20]]=ParseFloatToString(element[OxOb263[19]].letterSpacing);for(var i=0;i<sel_letter_unit[OxOb263[26]][OxOb263[25]];i++){var Ox142=sel_letter_unit[OxOb263[26]][i][OxOb263[20]];if(Ox142&&element[OxOb263[19]][OxOb263[24]].indexOf(Ox142)!=-1){sel_letter_unit[OxOb263[17]]=i;break ;} ;} ;} ;} ;sel_line[OxOb263[20]]=element[OxOb263[19]][OxOb263[27]];sel_line_unit[OxOb263[17]]=0;if(sel_line[OxOb263[17]]==-1){if(ParseFloatToString(element[OxOb263[19]].lineHeight)){tb_line[OxOb263[20]]=ParseFloatToString(element[OxOb263[19]].lineHeight);for(var i=0;i<sel_line_unit[OxOb263[26]][OxOb263[25]];i++){var Ox142=sel_line_unit[OxOb263[26]][i][OxOb263[20]];if(Ox142&&element[OxOb263[19]][OxOb263[27]].indexOf(Ox142)!=-1){sel_line_unit[OxOb263[17]]=i;break ;} ;} ;} ;} ;sel_indent_unit[OxOb263[17]]=0;if(!isNaN(ParseFloatToString(element[OxOb263[19]].textIndent))){tb_indent[OxOb263[20]]=ParseFloatToString(element[OxOb263[19]].textIndent);for(var i=0;i<sel_indent_unit[OxOb263[26]][OxOb263[25]];i++){var Ox142=sel_indent_unit[OxOb263[26]][i][OxOb263[20]];if(Ox142&&element[OxOb263[19]][OxOb263[28]].indexOf(Ox142)!=-1){sel_indent_unit[OxOb263[17]]=i;break ;} ;} ;} ;sel_direction[OxOb263[20]]=element[OxOb263[19]][OxOb263[29]];sel_writingmode[OxOb263[20]]=element[OxOb263[19]][OxOb263[30]];} ;SyncTo=function SyncTo_Text(element){element[OxOb263[19]][OxOb263[21]]=sel_align[OxOb263[20]];element[OxOb263[19]][OxOb263[22]]=sel_valign[OxOb263[20]];element[OxOb263[19]][OxOb263[23]]=sel_justify[OxOb263[20]];if(sel_letter[OxOb263[17]]>0){element[OxOb263[19]][OxOb263[24]]=sel_letter[OxOb263[20]];} else {if(ParseFloatToString(tb_letter.value)){element[OxOb263[19]][OxOb263[24]]=ParseFloatToString(tb_letter.value)+sel_letter_unit[OxOb263[20]];} else {element[OxOb263[19]][OxOb263[24]]=OxOb263[0];} ;} ;if(sel_line[OxOb263[17]]>0){element[OxOb263[19]][OxOb263[27]]=sel_line[OxOb263[20]];} else {if(ParseFloatToString(tb_line.value)){element[OxOb263[19]][OxOb263[27]]=ParseFloatToString(tb_line.value)+sel_line_unit[OxOb263[20]];} else {element[OxOb263[19]][OxOb263[27]]=OxOb263[0];} ;} ;if(ParseFloatToString(tb_indent.value)){element[OxOb263[19]][OxOb263[28]]=ParseFloatToString(tb_indent.value)+sel_indent_unit[OxOb263[20]];} else {element[OxOb263[19]][OxOb263[28]]=OxOb263[0];} ;element[OxOb263[19]][OxOb263[29]]=sel_direction[OxOb263[20]]||OxOb263[0];element[OxOb263[19]][OxOb263[30]]=sel_writingmode[OxOb263[20]]||OxOb263[0];} ;