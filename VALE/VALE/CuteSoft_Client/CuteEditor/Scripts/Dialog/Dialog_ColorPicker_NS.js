var OxOa429=["onload","onclick","btnCancel","btnOK","onkeyup","txtHSB_Hue","onkeypress","txtHSB_Saturation","txtHSB_Brightness","txtRGB_Red","txtRGB_Green","txtRGB_Blue","txtHex","btnWebSafeColor","rdoHSB_Hue","rdoHSB_Saturation","rdoHSB_Brightness","pnlGradient_Top","onmousemove","onmousedown","onmouseup","pnlVertical_Top","pnlWebSafeColor","pnlWebSafeColorBorder","pnlOldColor","lblHSB_Hue","lblHSB_Saturation","lblHSB_Brightness","length","\x5C{","\x5C}","BadNumber","A number between {0} and {1} is required. Closest value inserted.","Title","Color Picker","SelectAColor","Select a color:","OKButton","OK","CancelButton","Cancel","Recent","WebSafeWarning","Warning: not a web safe color","WebSafeClick","Click to select web safe color","HsbHue","H:","HsbHueTooltip","Hue","HsbHueUnit","%","HsbSaturation","S:","HsbSaturationTooltip","Saturation","HsbSaturationUnit","HsbBrightness","B:","HsbBrightnessTooltip","Brightness","HsbBrightnessUnit","RgbRed","R:","RgbRedTooltip","Red","RgbGreen","G:","RgbGreenTooltip","Green","RgbBlue","RgbBlueTooltip","Blue","Hex","#","RecentTooltip","Recent:","lblSelectColorMessage","lblRecent","lblRGB_Red","lblRGB_Green","lblRGB_Blue","lblHex","lblUnitHSB_Hue","lblUnitHSB_Saturation","lblUnitHSB_Brightness","pnlHSB_Hue","pnlHSB_Saturation","pnlHSB_Brightness","pnlRGB_Red","pnlRGB_Green","pnlRGB_Blue","frmColorPicker","Color","","FFFFFF","value","checked","ColorMode","ColorType","RecentColors","pnlRecent","border","style","0px","backgroundColor","target","rgb","(",")",",","display","none","title","innerHTML","backgroundPosition","px ","px","pnlGradientHsbHue_Hue","pnlGradientHsbHue_Black","pnlGradientHsbHue_White","pnlVerticalHsbHue_Background","pnlVerticalHsbSaturation_Hue","pnlVerticalHsbSaturation_White","pnlVerticalHsbBrightness_Hue","pnlVerticalHsbBrightness_Black","pnlVerticalRgb_Start","pnlVerticalRgb_End","pnlGradientRgb_Base","pnlGradientRgb_Invert","pnlGradientRgb_Overlay1","pnlGradientRgb_Overlay2","src","imgGradient","Load.ashx?type=image\x26file=cpns_ColorSpace1.png","Load.ashx?type=image\x26file=cpns_ColorSpace2.png","Load.ashx?type=image\x26file=cpns_Vertical1.png","#000000","Load.ashx?type=image\x26file=cpns_Vertical2.png","#ffffff","01234567879","which","abcdef","01234567879ABCDEF","opener","closeeditordialog","close","pnlGradientPosition","pnlNewColor","0123456789ABCDEFabcdef","000000","0","id","top","pnlVerticalPosition","backgroundImage","url(Load.ashx?type=image\x26file=cpns_GradientPositionDark.gif)","url(Load.ashx?type=image\x26file=cpns_GradientPositionLight.gif)","cancelBubble","pageX","pageY","className","GradientNormal","GradientFullScreen","_isverdown","=","; path=/;"," expires=",";","cookie","search","location","\x26","00336699CCFF","0x","do_select","frm","__cphex"];var POSITIONADJUSTX=22;var POSITIONADJUSTY=52;var POSITIONADJUSTZ=48;var ColorMode=1;var GradientPositionDark= new Boolean(false);var frm= new Object();var msg= new Object();var _xmlDocs= new Array();var _xmlIndex=-1;var _xml=null;LoadLanguage();window[OxOa429[0]]=window_load;function initialize(){frm[OxOa429[2]][OxOa429[1]]=btnCancel_Click;frm[OxOa429[3]][OxOa429[1]]=btnOK_Click;frm[OxOa429[5]][OxOa429[4]]=Hsb_Changed;frm[OxOa429[5]][OxOa429[6]]=validateNumber;frm[OxOa429[7]][OxOa429[4]]=Hsb_Changed;frm[OxOa429[7]][OxOa429[6]]=validateNumber;frm[OxOa429[8]][OxOa429[4]]=Hsb_Changed;frm[OxOa429[8]][OxOa429[6]]=validateNumber;frm[OxOa429[9]][OxOa429[4]]=Rgb_Changed;frm[OxOa429[9]][OxOa429[6]]=validateNumber;frm[OxOa429[10]][OxOa429[4]]=Rgb_Changed;frm[OxOa429[10]][OxOa429[6]]=validateNumber;frm[OxOa429[11]][OxOa429[4]]=Rgb_Changed;frm[OxOa429[11]][OxOa429[6]]=validateNumber;frm[OxOa429[12]][OxOa429[4]]=Hex_Changed;frm[OxOa429[12]][OxOa429[6]]=validateHex;frm[OxOa429[13]][OxOa429[1]]=btnWebSafeColor_Click;frm[OxOa429[14]][OxOa429[1]]=rdoHsb_Hue_Click;frm[OxOa429[15]][OxOa429[1]]=rdoHsb_Saturation_Click;frm[OxOa429[16]][OxOa429[1]]=rdoHsb_Brightness_Click;document.getElementById(OxOa429[17])[OxOa429[1]]=pnlGradient_Top_Click;document.getElementById(OxOa429[17])[OxOa429[18]]=pnlGradient_Top_MouseMove;document.getElementById(OxOa429[17])[OxOa429[19]]=pnlGradient_Top_MouseDown;document.getElementById(OxOa429[17])[OxOa429[20]]=pnlGradient_Top_MouseUp;document.getElementById(OxOa429[21])[OxOa429[1]]=pnlVertical_Top_Click;document.getElementById(OxOa429[21])[OxOa429[18]]=pnlVertical_Top_MouseMove;document.getElementById(OxOa429[21])[OxOa429[19]]=pnlVertical_Top_MouseDown;document.getElementById(OxOa429[21])[OxOa429[20]]=pnlVertical_Top_MouseUp;document.getElementById(OxOa429[22])[OxOa429[1]]=btnWebSafeColor_Click;document.getElementById(OxOa429[23])[OxOa429[1]]=btnWebSafeColor_Click;document.getElementById(OxOa429[24])[OxOa429[1]]=pnlOldClick_Click;document.getElementById(OxOa429[25])[OxOa429[1]]=rdoHsb_Hue_Click;document.getElementById(OxOa429[26])[OxOa429[1]]=rdoHsb_Saturation_Click;document.getElementById(OxOa429[27])[OxOa429[1]]=rdoHsb_Brightness_Click;frm[OxOa429[5]].focus();window.focus();} ;function formatString(Ox2b2){Ox2b2= new String(Ox2b2);for(var i=1;i<arguments[OxOa429[28]];i++){Ox2b2=Ox2b2.replace( new RegExp(OxOa429[29]+(i-1)+OxOa429[30]),arguments[i]);} ;return Ox2b2;} ;function AddValue(Ox11a,Ox4f){Ox4f= new String(Ox4f).toLowerCase();for(var i=0;i<Ox11a[OxOa429[28]];i++){if(Ox11a[i]==Ox4f){return ;} ;} ;Ox11a[Ox11a[OxOa429[28]]]=Ox4f;} ;function SniffLanguage(Ox11){} ;function LoadNextLanguage(){} ;function LoadLanguage(){msg[OxOa429[31]]=OxOa429[32];msg[OxOa429[33]]=OxOa429[34];msg[OxOa429[35]]=OxOa429[36];msg[OxOa429[37]]=OxOa429[38];msg[OxOa429[39]]=OxOa429[40];msg[OxOa429[41]]=OxOa429[41];msg[OxOa429[42]]=OxOa429[43];msg[OxOa429[44]]=OxOa429[45];msg[OxOa429[46]]=OxOa429[47];msg[OxOa429[48]]=OxOa429[49];msg[OxOa429[50]]=OxOa429[51];msg[OxOa429[52]]=OxOa429[53];msg[OxOa429[54]]=OxOa429[55];msg[OxOa429[56]]=OxOa429[51];msg[OxOa429[57]]=OxOa429[58];msg[OxOa429[59]]=OxOa429[60];msg[OxOa429[61]]=OxOa429[51];msg[OxOa429[62]]=OxOa429[63];msg[OxOa429[64]]=OxOa429[65];msg[OxOa429[66]]=OxOa429[67];msg[OxOa429[68]]=OxOa429[69];msg[OxOa429[70]]=OxOa429[58];msg[OxOa429[71]]=OxOa429[72];msg[OxOa429[73]]=OxOa429[74];msg[OxOa429[75]]=OxOa429[76];} ;function AssignLanguage(){} ;function localize(){SetHTML(document.getElementById(OxOa429[77]),msg.SelectAColor,document.getElementById(OxOa429[78]),msg.Recent,document.getElementById(OxOa429[25]),msg.HsbHue,document.getElementById(OxOa429[26]),msg.HsbSaturation,document.getElementById(OxOa429[27]),msg.HsbBrightness,document.getElementById(OxOa429[79]),msg.RgbRed,document.getElementById(OxOa429[80]),msg.RgbGreen,document.getElementById(OxOa429[81]),msg.RgbBlue,document.getElementById(OxOa429[82]),msg.Hex,document.getElementById(OxOa429[83]),msg.HsbHueUnit,document.getElementById(OxOa429[84]),msg.HsbSaturationUnit,document.getElementById(OxOa429[85]),msg.HsbBrightnessUnit);SetValue(frm.btnCancel,msg.CancelButton,frm.btnOK,msg.OKButton);SetTitle(frm.btnWebSafeColor,msg.WebSafeWarning,document.getElementById(OxOa429[22]),msg.WebSafeClick,document.getElementById(OxOa429[86]),msg.HsbHueTooltip,document.getElementById(OxOa429[87]),msg.HsbSaturationTooltip,document.getElementById(OxOa429[88]),msg.HsbBrightnessTooltip,document.getElementById(OxOa429[89]),msg.RgbRedTooltip,document.getElementById(OxOa429[90]),msg.RgbGreenTooltip,document.getElementById(OxOa429[91]),msg.RgbBlueTooltip);} ;function window_load(Ox43){frm=document.getElementById(OxOa429[92]);localize();initialize();var hex=GetQuery(OxOa429[93]).toUpperCase();if(hex==OxOa429[94]){hex=OxOa429[95];} ;if(hex[OxOa429[28]]==7){hex=hex.substr(1,6);} ;frm[OxOa429[12]][OxOa429[96]]=hex;Hex_Changed(Ox43);hex=Form_Get_Hex();SetBg(document.getElementById(OxOa429[24]),hex);frm[OxOa429[99]][ new Number(GetCookie(OxOa429[98])||0)][OxOa429[97]]=true;ColorMode_Changed(Ox43);var Ox2a8=GetCookie(OxOa429[100])||OxOa429[94];var Ox2b8=msg[OxOa429[75]];for(var i=1;i<33;i++){if(Ox2a8[OxOa429[28]]/6>=i){hex=Ox2a8.substr((i-1)*6,6);var Ox2b9=HexToRgb(hex);var title=formatString(msg.RecentTooltip,hex,Ox2b9[0],Ox2b9[1],Ox2b9[2]);SetBg(document.getElementById(OxOa429[101]+i),hex);SetTitle(document.getElementById(OxOa429[101]+i),title);document.getElementById(OxOa429[101]+i)[OxOa429[1]]=pnlRecent_Click;} else {document.getElementById(OxOa429[101]+i)[OxOa429[103]][OxOa429[102]]=OxOa429[104];} ;} ;} ;function pnlRecent_Click(Ox43){var Oxdc=Ox43[OxOa429[106]][OxOa429[103]][OxOa429[105]];if(Oxdc.indexOf(OxOa429[107])!=-1){var Ox2b9= new Array();Oxdc=Oxdc.substr(Oxdc.indexOf(OxOa429[108])+1);Oxdc=Oxdc.substr(0,Oxdc.indexOf(OxOa429[109]));Ox2b9[0]= new Number(Oxdc.substr(0,Oxdc.indexOf(OxOa429[110])));Oxdc=Oxdc.substr(Oxdc.indexOf(OxOa429[110])+1);Ox2b9[1]= new Number(Oxdc.substr(0,Oxdc.indexOf(OxOa429[110])));Ox2b9[2]= new Number(Oxdc.substr(Oxdc.indexOf(OxOa429[110])+1));Oxdc=RgbToHex(Ox2b9);} else {Oxdc=Oxdc.substr(1,6).toUpperCase();} ;frm[OxOa429[12]][OxOa429[96]]=Oxdc;Hex_Changed(Ox43);} ;function pnlOldClick_Click(Ox43){frm[OxOa429[12]][OxOa429[96]]=document.getElementById(OxOa429[24])[OxOa429[103]][OxOa429[105]].substr(1,6).toUpperCase();Hex_Changed(Ox43);} ;function rdoHsb_Hue_Click(Ox43){frm[OxOa429[14]][OxOa429[97]]=true;ColorMode_Changed(Ox43);} ;function rdoHsb_Saturation_Click(Ox43){frm[OxOa429[15]][OxOa429[97]]=true;ColorMode_Changed(Ox43);} ;function rdoHsb_Brightness_Click(Ox43){frm[OxOa429[16]][OxOa429[97]]=true;ColorMode_Changed(Ox43);} ;function Hide(){for(var i=0;i<arguments[OxOa429[28]];i++){if(arguments[i]){arguments[i][OxOa429[103]][OxOa429[111]]=OxOa429[112];} ;} ;} ;function Show(){for(var i=0;i<arguments[OxOa429[28]];i++){if(arguments[i]){arguments[i][OxOa429[103]][OxOa429[111]]=OxOa429[94];} ;} ;} ;function SetValue(){for(var i=0;i<arguments[OxOa429[28]];i+=2){arguments[i][OxOa429[96]]=arguments[i+1];} ;} ;function SetTitle(){for(var i=0;i<arguments[OxOa429[28]];i+=2){arguments[i][OxOa429[113]]=arguments[i+1];} ;} ;function SetHTML(){for(var i=0;i<arguments[OxOa429[28]];i+=2){arguments[i][OxOa429[114]]=arguments[i+1];} ;} ;function SetBg(){for(var i=0;i<arguments[OxOa429[28]];i+=2){if(arguments[i]){arguments[i][OxOa429[103]][OxOa429[105]]=OxOa429[74]+arguments[i+1];} ;} ;} ;function SetBgPosition(){for(var i=0;i<arguments[OxOa429[28]];i+=3){arguments[i][OxOa429[103]][OxOa429[115]]=arguments[i+1]+OxOa429[116]+arguments[i+2]+OxOa429[117];} ;} ;function ColorMode_Changed(Ox43){for(var i=0;i<3;i++){if(frm[OxOa429[99]][i][OxOa429[97]]){ColorMode=i;} ;} ;SetCookie(OxOa429[98],ColorMode,60*60*24*365);Hide(document.getElementById(OxOa429[118]),document.getElementById(OxOa429[119]),document.getElementById(OxOa429[120]),document.getElementById(OxOa429[121]),document.getElementById(OxOa429[122]),document.getElementById(OxOa429[123]),document.getElementById(OxOa429[124]),document.getElementById(OxOa429[125]),document.getElementById(OxOa429[126]),document.getElementById(OxOa429[127]),document.getElementById(OxOa429[128]),document.getElementById(OxOa429[129]),document.getElementById(OxOa429[130]),document.getElementById(OxOa429[131]));switch(ColorMode){case 0:document.getElementById(OxOa429[133])[OxOa429[132]]=OxOa429[134];Show(document.getElementById(OxOa429[118]),document.getElementById(OxOa429[119]),document.getElementById(OxOa429[120]),document.getElementById(OxOa429[121]));Hsb_Changed(Ox43);break ;;case 1:document.getElementById(OxOa429[133])[OxOa429[132]]=OxOa429[135];document.getElementById(OxOa429[122])[OxOa429[132]]=OxOa429[136];Show(document.getElementById(OxOa429[118]),document.getElementById(OxOa429[122]));document.getElementById(OxOa429[118])[OxOa429[103]][OxOa429[105]]=OxOa429[137];Hsb_Changed(Ox43);break ;;case 2:document.getElementById(OxOa429[133])[OxOa429[132]]=OxOa429[135];document.getElementById(OxOa429[122])[OxOa429[132]]=OxOa429[138];Show(document.getElementById(OxOa429[118]),document.getElementById(OxOa429[122]));document.getElementById(OxOa429[118])[OxOa429[103]][OxOa429[105]]=OxOa429[139];Hsb_Changed(Ox43);break ;;default:break ;;} ;} ;function btnWebSafeColor_Click(Ox43){var Ox2b9=HexToRgb(frm[OxOa429[12]].value);Ox2b9=RgbToWebSafeRgb(Ox2b9);frm[OxOa429[12]][OxOa429[96]]=RgbToHex(Ox2b9);Hex_Changed(Ox43);} ;function checkWebSafe(){var Ox2b9=Form_Get_Rgb();if(RgbIsWebSafe(Ox2b9)){Hide(frm.btnWebSafeColor,document.getElementById(OxOa429[22]),document.getElementById(OxOa429[23]));} else {Ox2b9=RgbToWebSafeRgb(Ox2b9);SetBg(document.getElementById(OxOa429[22]),RgbToHex(Ox2b9));Show(frm.btnWebSafeColor,document.getElementById(OxOa429[22]),document.getElementById(OxOa429[23]));} ;} ;function validateNumber(Ox43){var Ox2ce=String.fromCharCode(Ox43.which);if(IgnoreKey(Ox43)){return ;} ;if(OxOa429[140].indexOf(Ox2ce)!=-1){return ;} ;Ox43[OxOa429[141]]=0;} ;function validateHex(Ox43){if(IgnoreKey(Ox43)){return ;} ;var Ox2ce=String.fromCharCode(Ox43.which);if(OxOa429[142].indexOf(Ox2ce)!=-1){return ;} ;if(OxOa429[143].indexOf(Ox2ce)!=-1){return ;} ;} ;function IgnoreKey(Ox43){var Ox2ce=String.fromCharCode(Ox43.which);var Ox2d1= new Array(0,8,9,13,27);if(Ox2ce==null){return true;} ;for(var i=0;i<5;i++){if(Ox43[OxOa429[141]]==Ox2d1[i]){return true;} ;} ;return false;} ;function btnCancel_Click(){if(window[OxOa429[144]]){window[OxOa429[144]].focus();} ;(top[OxOa429[145]]||top[OxOa429[146]])();} ;function btnOK_Click(){var hex= new String(frm[OxOa429[12]].value);if(window[OxOa429[144]]){try{window[OxOa429[144]].ColorPicker_Picked(hex);} catch(e){} ;window[OxOa429[144]].focus();} ;recent=GetCookie(OxOa429[100])||OxOa429[94];for(var i=0;i<recent[OxOa429[28]];i+=6){if(recent.substr(i,6)==hex){recent=recent.substr(0,i)+recent.substr(i+6);i-=6;} ;} ;if(recent[OxOa429[28]]>31*6){recent=recent.substr(0,31*6);} ;recent=frm[OxOa429[12]][OxOa429[96]]+recent;SetCookie(OxOa429[100],recent,60*60*24*365);(top[OxOa429[145]]||top[OxOa429[146]])();} ;function SetGradientPosition(Ox43,x,y){x=x-POSITIONADJUSTX+5;y=y-POSITIONADJUSTY+5;x-=7;y-=27;x=x<0?0:x>255?255:x;y=y<0?0:y>255?255:y;SetBgPosition(document.getElementById(OxOa429[147]),x-5,y-5);switch(ColorMode){case 0:var Ox2d5= new Array(0,0,0);Ox2d5[1]=x/255;Ox2d5[2]=1-(y/255);frm[OxOa429[7]][OxOa429[96]]=Math.round(Ox2d5[1]*100);frm[OxOa429[8]][OxOa429[96]]=Math.round(Ox2d5[2]*100);Hsb_Changed(Ox43);break ;;case 1:var Ox2d5= new Array(0,0,0);Ox2d5[0]=x/255;Ox2d5[2]=1-(y/255);frm[OxOa429[5]][OxOa429[96]]=Ox2d5[0]==1?0:Math.round(Ox2d5[0]*360);frm[OxOa429[8]][OxOa429[96]]=Math.round(Ox2d5[2]*100);Hsb_Changed(Ox43);break ;;case 2:var Ox2d5= new Array(0,0,0);Ox2d5[0]=x/255;Ox2d5[1]=1-(y/255);frm[OxOa429[5]][OxOa429[96]]=Ox2d5[0]==1?0:Math.round(Ox2d5[0]*360);frm[OxOa429[7]][OxOa429[96]]=Math.round(Ox2d5[1]*100);Hsb_Changed(Ox43);break ;;} ;} ;function Hex_Changed(Ox43){var hex=Form_Get_Hex();var Ox2b9=HexToRgb(hex);var Ox2d5=RgbToHsb(Ox2b9);Form_Set_Rgb(Ox2b9);Form_Set_Hsb(Ox2d5);SetBg(document.getElementById(OxOa429[148]),hex);SetupCursors(Ox43);SetupGradients();checkWebSafe();} ;function Rgb_Changed(Ox43){var Ox2b9=Form_Get_Rgb();var Ox2d5=RgbToHsb(Ox2b9);var hex=RgbToHex(Ox2b9);Form_Set_Hsb(Ox2d5);Form_Set_Hex(hex);SetBg(document.getElementById(OxOa429[148]),hex);SetupCursors(Ox43);SetupGradients();checkWebSafe();} ;function Hsb_Changed(Ox43){var Ox2d5=Form_Get_Hsb();var Ox2b9=HsbToRgb(Ox2d5);var hex=RgbToHex(Ox2b9);Form_Set_Rgb(Ox2b9);Form_Set_Hex(hex);SetBg(document.getElementById(OxOa429[148]),hex);SetupCursors(Ox43);SetupGradients();checkWebSafe();} ;function Form_Set_Hex(hex){frm[OxOa429[12]][OxOa429[96]]=hex;} ;function Form_Get_Hex(){var hex= new String(frm[OxOa429[12]].value);for(var i=0;i<hex[OxOa429[28]];i++){if(OxOa429[149].indexOf(hex.substr(i,1))==-1){hex=OxOa429[150];frm[OxOa429[12]][OxOa429[96]]=hex;alert(formatString(msg.BadNumber,OxOa429[150],OxOa429[95]));break ;} ;} ;while(hex[OxOa429[28]]<6){hex=OxOa429[151]+hex;} ;return hex;} ;function Form_Get_Hsb(){var Ox2d5= new Array(0,0,0);Ox2d5[0]= new Number(frm[OxOa429[5]].value)/360;Ox2d5[1]= new Number(frm[OxOa429[7]].value)/100;Ox2d5[2]= new Number(frm[OxOa429[8]].value)/100;if(Ox2d5[0]>1||isNaN(Ox2d5[0])){Ox2d5[0]=1;frm[OxOa429[5]][OxOa429[96]]=360;alert(formatString(msg.BadNumber,0,360));} ;if(Ox2d5[1]>1||isNaN(Ox2d5[1])){Ox2d5[1]=1;frm[OxOa429[7]][OxOa429[96]]=100;alert(formatString(msg.BadNumber,0,100));} ;if(Ox2d5[2]>1||isNaN(Ox2d5[2])){Ox2d5[2]=1;frm[OxOa429[8]][OxOa429[96]]=100;alert(formatString(msg.BadNumber,0,100));} ;return Ox2d5;} ;function Form_Set_Hsb(Ox2d5){SetValue(frm.txtHSB_Hue,Math.round(Ox2d5[0]*360),frm.txtHSB_Saturation,Math.round(Ox2d5[1]*100),frm.txtHSB_Brightness,Math.round(Ox2d5[2]*100));} ;function Form_Get_Rgb(){var Ox2b9= new Array(0,0,0);Ox2b9[0]= new Number(frm[OxOa429[9]].value);Ox2b9[1]= new Number(frm[OxOa429[10]].value);Ox2b9[2]= new Number(frm[OxOa429[11]].value);if(Ox2b9[0]>255||isNaN(Ox2b9[0])||Ox2b9[0]!=Math.round(Ox2b9[0])){Ox2b9[0]=255;frm[OxOa429[9]][OxOa429[96]]=255;alert(formatString(msg.BadNumber,0,255));} ;if(Ox2b9[1]>255||isNaN(Ox2b9[1])||Ox2b9[1]!=Math.round(Ox2b9[1])){Ox2b9[1]=255;frm[OxOa429[10]][OxOa429[96]]=255;alert(formatString(msg.BadNumber,0,255));} ;if(Ox2b9[2]>255||isNaN(Ox2b9[2])||Ox2b9[2]!=Math.round(Ox2b9[2])){Ox2b9[2]=255;frm[OxOa429[11]][OxOa429[96]]=255;alert(formatString(msg.BadNumber,0,255));} ;return Ox2b9;} ;function Form_Set_Rgb(Ox2b9){frm[OxOa429[9]][OxOa429[96]]=Ox2b9[0];frm[OxOa429[10]][OxOa429[96]]=Ox2b9[1];frm[OxOa429[11]][OxOa429[96]]=Ox2b9[2];} ;function SetupCursors(Ox43){var Ox2d5=Form_Get_Hsb();var Ox2b9=Form_Get_Rgb();if(RgbToYuv(Ox2b9)[0]>=0.5){SetGradientPositionDark();} else {SetGradientPositionLight();} ;if(Ox43[OxOa429[106]]!=null){if(Ox43[OxOa429[106]][OxOa429[152]]==OxOa429[17]){return ;} ;if(Ox43[OxOa429[106]][OxOa429[152]]==OxOa429[21]){return ;} ;} ;var x;var y;var z;if(ColorMode>=0&&ColorMode<=2){for(var i=0;i<3;i++){Ox2d5[i]*=255;} ;} ;switch(ColorMode){case 0:x=Ox2d5[1];y=Ox2d5[2];z=Ox2d5[0]==0?1:Ox2d5[0];break ;;case 1:x=Ox2d5[0]==0?1:Ox2d5[0];y=Ox2d5[2];z=Ox2d5[1];break ;;case 2:x=Ox2d5[0]==0?1:Ox2d5[0];y=Ox2d5[1];z=Ox2d5[2];break ;;} ;y=255-y;z=255-z;SetBgPosition(document.getElementById(OxOa429[147]),x-5,y-5);document.getElementById(OxOa429[154])[OxOa429[103]][OxOa429[153]]=(z+27)+OxOa429[117];} ;function SetupGradients(){var Ox2d5=Form_Get_Hsb();var Ox2b9=Form_Get_Rgb();switch(ColorMode){case 0:SetBg(document.getElementById(OxOa429[118]),RgbToHex(HueToRgb(Ox2d5[0])));break ;;case 1:SetBg(document.getElementById(OxOa429[122]),RgbToHex(HsbToRgb( new Array(Ox2d5[0],1,Ox2d5[2]))));break ;;case 2:SetBg(document.getElementById(OxOa429[122]),RgbToHex(HsbToRgb( new Array(Ox2d5[0],Ox2d5[1],1))));break ;;default:;} ;} ;function SetGradientPositionDark(){if(GradientPositionDark){return ;} ;GradientPositionDark=true;document.getElementById(OxOa429[147])[OxOa429[103]][OxOa429[155]]=OxOa429[156];} ;function SetGradientPositionLight(){if(!GradientPositionDark){return ;} ;GradientPositionDark=false;document.getElementById(OxOa429[147])[OxOa429[103]][OxOa429[155]]=OxOa429[157];} ;function pnlGradient_Top_Click(Ox43){Ox43[OxOa429[158]]=true;SetGradientPosition(Ox43,Ox43[OxOa429[159]]-5,Ox43[OxOa429[160]]-5);document.getElementById(OxOa429[17])[OxOa429[161]]=OxOa429[162];_down=false;} ;var _down=false;function pnlGradient_Top_MouseMove(Ox43){Ox43[OxOa429[158]]=true;if(!_down){return ;} ;SetGradientPosition(Ox43,Ox43[OxOa429[159]]-5,Ox43[OxOa429[160]]-5);} ;function pnlGradient_Top_MouseDown(Ox43){Ox43[OxOa429[158]]=true;_down=true;SetGradientPosition(Ox43,Ox43[OxOa429[159]]-5,Ox43[OxOa429[160]]-5);document.getElementById(OxOa429[17])[OxOa429[161]]=OxOa429[163];} ;function pnlGradient_Top_MouseUp(Ox43){_down=false;Ox43[OxOa429[158]]=true;SetGradientPosition(Ox43,Ox43[OxOa429[159]]-5,Ox43[OxOa429[160]]-5);document.getElementById(OxOa429[17])[OxOa429[161]]=OxOa429[162];} ;function Document_MouseUp(){e[OxOa429[158]]=true;document.getElementById(OxOa429[17])[OxOa429[161]]=OxOa429[162];} ;function SetVerticalPosition(Ox43,z){var z=z-POSITIONADJUSTZ;if(z<27){z=27;} ;if(z>282){z=282;} ;document.getElementById(OxOa429[154])[OxOa429[103]][OxOa429[153]]=z+OxOa429[117];z=1-((z-27)/255);switch(ColorMode){case 0:if(z==1){z=0;} ;frm[OxOa429[5]][OxOa429[96]]=Math.round(z*360);Hsb_Changed(Ox43);break ;;case 1:frm[OxOa429[7]][OxOa429[96]]=Math.round(z*100);Hsb_Changed(Ox43);break ;;case 2:frm[OxOa429[8]][OxOa429[96]]=Math.round(z*100);Hsb_Changed(Ox43);break ;;} ;} ;function pnlVertical_Top_Click(Ox43){SetVerticalPosition(Ox43,Ox43[OxOa429[160]]-5);Ox43[OxOa429[158]]=true;} ;function pnlVertical_Top_MouseMove(Ox43){if(!window[OxOa429[164]]){return ;} ;if(Ox43[OxOa429[141]]!=1){return ;} ;SetVerticalPosition(Ox43,Ox43[OxOa429[160]]-5);Ox43[OxOa429[158]]=true;} ;function pnlVertical_Top_MouseDown(Ox43){window[OxOa429[164]]=true;SetVerticalPosition(Ox43,Ox43[OxOa429[160]]-5);Ox43[OxOa429[158]]=true;} ;function pnlVertical_Top_MouseUp(Ox43){window[OxOa429[164]]=false;SetVerticalPosition(Ox43,Ox43[OxOa429[160]]-5);Ox43[OxOa429[158]]=true;} ;function SetCookie(name,Ox4f,Ox56){var Ox57=name+OxOa429[165]+escape(Ox4f)+OxOa429[166];if(Ox56){var Ox58= new Date();Ox58.setSeconds(Ox58.getSeconds()+Ox56);Ox57+=OxOa429[167]+Ox58.toUTCString()+OxOa429[168];} ;document[OxOa429[169]]=Ox57;} ;function GetCookie(name){var Ox5a=document[OxOa429[169]].split(OxOa429[168]);for(var i=0;i<Ox5a[OxOa429[28]];i++){var Ox5b=Ox5a[i].split(OxOa429[165]);if(name==Ox5b[0].replace(/\s/g,OxOa429[94])){return unescape(Ox5b[1]);} ;} ;} ;function GetCookieDictionary(){var Ox12b={};var Ox5a=document[OxOa429[169]].split(OxOa429[168]);for(var i=0;i<Ox5a[OxOa429[28]];i++){var Ox5b=Ox5a[i].split(OxOa429[165]);Ox12b[Ox5b[0].replace(/\s/g,OxOa429[94])]=unescape(Ox5b[1]);} ;return Ox12b;} ;function GetQuery(name){var i=0;while(window[OxOa429[171]][OxOa429[170]].indexOf(name+OxOa429[165],i)!=-1){var Ox4f=window[OxOa429[171]][OxOa429[170]].substr(window[OxOa429[171]][OxOa429[170]].indexOf(name+OxOa429[165],i));Ox4f=Ox4f.substr(name[OxOa429[28]]+1);if(Ox4f.indexOf(OxOa429[172])!=-1){if(Ox4f.indexOf(OxOa429[172])==0){Ox4f=OxOa429[94];} else {Ox4f=Ox4f.substr(0,Ox4f.indexOf(OxOa429[172]));} ;} ;return unescape(Ox4f);} ;return OxOa429[94];} ;function RgbIsWebSafe(Ox2b9){var hex=RgbToHex(Ox2b9);for(var i=0;i<3;i++){if(OxOa429[173].indexOf(hex.substr(i*2,2))==-1){return false;} ;} ;return true;} ;function RgbToWebSafeRgb(Ox2b9){var Ox2ef= new Array(Ox2b9[0],Ox2b9[1],Ox2b9[2]);if(RgbIsWebSafe(Ox2b9)){return Ox2ef;} ;var Ox2f0= new Array(0x00,0x33,0x66,0x99,0xCC,0xFF);for(var i=0;i<3;i++){for(var Ox25=1;Ox25<6;Ox25++){if(Ox2ef[i]>Ox2f0[Ox25-1]&&Ox2ef[i]<Ox2f0[Ox25]){if(Ox2ef[i]-Ox2f0[Ox25-1]>Ox2f0[Ox25]-Ox2ef[i]){Ox2ef[i]=Ox2f0[Ox25];} else {Ox2ef[i]=Ox2f0[Ox25-1];} ;break ;} ;} ;} ;return Ox2ef;} ;function RgbToYuv(Ox2b9){var Ox2f2= new Array();Ox2f2[0]=(Ox2b9[0]*0.299+Ox2b9[1]*0.587+Ox2b9[2]*0.114)/255;Ox2f2[1]=(Ox2b9[0]*-0.169+Ox2b9[1]*-0.332+Ox2b9[2]*0.500+128)/255;Ox2f2[2]=(Ox2b9[0]*0.500+Ox2b9[1]*-0.419+Ox2b9[2]*-0.0813+128)/255;return Ox2f2;} ;function RgbToHsb(Ox2b9){var Ox2f4= new Array(Ox2b9[0],Ox2b9[1],Ox2b9[2]);var Ox2f5= new Number(1);var Ox2f6= new Number(0);var Ox2f7= new Number(1);var Ox2d5= new Array(0,0,0);var Ox2f8= new Array();for(var i=0;i<3;i++){Ox2f4[i]=Ox2b9[i]/255;if(Ox2f4[i]<Ox2f5){Ox2f5=Ox2f4[i];} ;if(Ox2f4[i]>Ox2f6){Ox2f6=Ox2f4[i];} ;} ;Ox2f7=Ox2f6-Ox2f5;Ox2d5[2]=Ox2f6;if(Ox2f7==0){return Ox2d5;} ;Ox2d5[1]=Ox2f7/Ox2f6;for(var i=0;i<3;i++){Ox2f8[i]=(((Ox2f6-Ox2f4[i])/6)+(Ox2f7/2))/Ox2f7;} ;if(Ox2f4[0]==Ox2f6){Ox2d5[0]=Ox2f8[2]-Ox2f8[1];} else {if(Ox2f4[1]==Ox2f6){Ox2d5[0]=(1/3)+Ox2f8[0]-Ox2f8[2];} else {if(Ox2f4[2]==Ox2f6){Ox2d5[0]=(2/3)+Ox2f8[1]-Ox2f8[0];} ;} ;} ;if(Ox2d5[0]<0){Ox2d5[0]+=1;} else {if(Ox2d5[0]>1){Ox2d5[0]-=1;} ;} ;return Ox2d5;} ;function HsbToRgb(Ox2d5){var Ox2b9=HueToRgb(Ox2d5[0]);var Ox120=Ox2d5[2]*255;for(var i=0;i<3;i++){Ox2b9[i]=Ox2b9[i]*Ox2d5[2];Ox2b9[i]=((Ox2b9[i]-Ox120)*Ox2d5[1])+Ox120;Ox2b9[i]=Math.round(Ox2b9[i]);} ;return Ox2b9;} ;function RgbToHex(Ox2b9){var hex= new String();for(var i=0;i<3;i++){Ox2b9[2-i]=Math.round(Ox2b9[2-i]);hex=Ox2b9[2-i].toString(16)+hex;if(hex[OxOa429[28]]%2==1){hex=OxOa429[151]+hex;} ;} ;return hex.toUpperCase();} ;function HexToRgb(hex){var Ox2b9= new Array();for(var i=0;i<3;i++){Ox2b9[i]= new Number(OxOa429[174]+hex.substr(i*2,2));} ;return Ox2b9;} ;function HueToRgb(Ox2fd){var Ox2fe=Ox2fd*360;var Ox2b9= new Array(0,0,0);var Ox2ff=(Ox2fe%60)/60;if(Ox2fe<60){Ox2b9[0]=255;Ox2b9[1]=Ox2ff*255;} else {if(Ox2fe<120){Ox2b9[1]=255;Ox2b9[0]=(1-Ox2ff)*255;} else {if(Ox2fe<180){Ox2b9[1]=255;Ox2b9[2]=Ox2ff*255;} else {if(Ox2fe<240){Ox2b9[2]=255;Ox2b9[1]=(1-Ox2ff)*255;} else {if(Ox2fe<300){Ox2b9[2]=255;Ox2b9[0]=Ox2ff*255;} else {if(Ox2fe<360){Ox2b9[0]=255;Ox2b9[2]=(1-Ox2ff)*255;} ;} ;} ;} ;} ;} ;return Ox2b9;} ;function CheckHexSelect(){if(window[OxOa429[175]]&&window[OxOa429[176]]&&frm[OxOa429[12]]){var Oxdc=OxOa429[74]+frm[OxOa429[12]][OxOa429[96]];if(Oxdc[OxOa429[28]]==7){if(window[OxOa429[177]]!=Oxdc){window[OxOa429[177]]=Oxdc;window.do_select(Oxdc);} ;} ;} ;} ;setInterval(CheckHexSelect,10);