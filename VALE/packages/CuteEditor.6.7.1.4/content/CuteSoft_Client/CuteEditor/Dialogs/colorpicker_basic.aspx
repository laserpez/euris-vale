<%@ Page Language="C#" Inherits="CuteEditor.EditorUtilityPage" %>
<script runat="server">
string GetDialogQueryString;
override protected void OnInit(EventArgs args)
{
	if(Context.Request.QueryString["Dialog"]=="Standard")
	{	
	if(Context.Request.QueryString["IsFrame"]==null)
	{
		string FrameSrc="colorpicker_basic.aspx?IsFrame=1&"+Request.ServerVariables["QUERY_STRING"];
		CuteEditor.CEU.WriteDialogOuterFrame(Context,"[[MoreColors]]",FrameSrc);
		Context.Response.End();
	}
	}
	string s="";
	if(Context.Request.QueryString["Dialog"]=="Standard")	
		s="&Dialog=Standard";
	
	GetDialogQueryString="Theme="+Context.Request.QueryString["Theme"]+s;	
	base.OnInit(args);
}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<meta http-equiv="Page-Enter" content="blendTrans(Duration=0.1)" />
		<meta http-equiv="Page-Exit" content="blendTrans(Duration=0.1)" />
		<script type="text/javascript" src="Load.ashx?type=dialogscript&verfix=1006&file=DialogHead.js"></script>
		<script type="text/javascript" src="Load.ashx?type=dialogscript&verfix=1006&file=Dialog_ColorPicker.js"></script>
		<link href='Load.ashx?type=themecss&file=dialog.css&theme=[[_Theme_]]' type="text/css"
			rel="stylesheet" />
		<style type="text/css">
			.colorcell
			{
				width:16px;
				height:17px;
				cursor:hand;
			}
			.colordiv,.customdiv
			{
				border:solid 1px #808080;
				width:16px;
				height:17px;
				font-size:1px;
			}
			#ajaxdiv{padding:10px;margin:0;text-align:center; background:#eeeeee;}
		</style>
		<title>[[NamedColors]]</title>
		<script>
								
		var OxO6bdb=["Green","#008000","Lime","#00FF00","Teal","#008080","Aqua","#00FFFF","Navy","#000080","Blue","#0000FF","Purple","#800080","Fuchsia","#FF00FF","Maroon","#800000","Red","#FF0000","Olive","#808000","Yellow","#FFFF00","White","#FFFFFF","Silver","#C0C0C0","Gray","#808080","Black","#000000","DarkOliveGreen","#556B2F","DarkGreen","#006400","DarkSlateGray","#2F4F4F","SlateGray","#708090","DarkBlue","#00008B","MidnightBlue","#191970","Indigo","#4B0082","DarkMagenta","#8B008B","Brown","#A52A2A","DarkRed","#8B0000","Sienna","#A0522D","SaddleBrown","#8B4513","DarkGoldenrod","#B8860B","Beige","#F5F5DC","HoneyDew","#F0FFF0","DimGray","#696969","OliveDrab","#6B8E23","ForestGreen","#228B22","DarkCyan","#008B8B","LightSlateGray","#778899","MediumBlue","#0000CD","DarkSlateBlue","#483D8B","DarkViolet","#9400D3","MediumVioletRed","#C71585","IndianRed","#CD5C5C","Firebrick","#B22222","Chocolate","#D2691E","Peru","#CD853F","Goldenrod","#DAA520","LightGoldenrodYellow","#FAFAD2","MintCream","#F5FFFA","DarkGray","#A9A9A9","YellowGreen","#9ACD32","SeaGreen","#2E8B57","CadetBlue","#5F9EA0","SteelBlue","#4682B4","RoyalBlue","#4169E1","BlueViolet","#8A2BE2","DarkOrchid","#9932CC","DeepPink","#FF1493","RosyBrown","#BC8F8F","Crimson","#DC143C","DarkOrange","#FF8C00","BurlyWood","#DEB887","DarkKhaki","#BDB76B","LightYellow","#FFFFE0","Azure","#F0FFFF","LightGray","#D3D3D3","LawnGreen","#7CFC00","MediumSeaGreen","#3CB371","LightSeaGreen","#20B2AA","DeepSkyBlue","#00BFFF","DodgerBlue","#1E90FF","SlateBlue","#6A5ACD","MediumOrchid","#BA55D3","PaleVioletRed","#DB7093","Salmon","#FA8072","OrangeRed","#FF4500","SandyBrown","#F4A460","Tan","#D2B48C","Gold","#FFD700","Ivory","#FFFFF0","GhostWhite","#F8F8FF","Gainsboro","#DCDCDC","Chartreuse","#7FFF00","LimeGreen","#32CD32","MediumAquamarine","#66CDAA","DarkTurquoise","#00CED1","CornflowerBlue","#6495ED","MediumSlateBlue","#7B68EE","Orchid","#DA70D6","HotPink","#FF69B4","LightCoral","#F08080","Tomato","#FF6347","Orange","#FFA500","Bisque","#FFE4C4","Khaki","#F0E68C","Cornsilk","#FFF8DC","Linen","#FAF0E6","WhiteSmoke","#F5F5F5","GreenYellow","#ADFF2F","DarkSeaGreen","#8FBC8B","Turquoise","#40E0D0","MediumTurquoise","#48D1CC","SkyBlue","#87CEEB","MediumPurple","#9370DB","Violet","#EE82EE","LightPink","#FFB6C1","DarkSalmon","#E9967A","Coral","#FF7F50","NavajoWhite","#FFDEAD","BlanchedAlmond","#FFEBCD","PaleGoldenrod","#EEE8AA","Oldlace","#FDF5E6","Seashell","#FFF5EE","PaleGreen","#98FB98","SpringGreen","#00FF7F","Aquamarine","#7FFFD4","PowderBlue","#B0E0E6","LightSkyBlue","#87CEFA","LightSteelBlue","#B0C4DE","Plum","#DDA0DD","Pink","#FFC0CB","LightSalmon","#FFA07A","Wheat","#F5DEB3","Moccasin","#FFE4B5","AntiqueWhite","#FAEBD7","LemonChiffon","#FFFACD","FloralWhite","#FFFAF0","Snow","#FFFAFA","AliceBlue","#F0F8FF","LightGreen","#90EE90","MediumSpringGreen","#00FA9A","PaleTurquoise","#AFEEEE","LightCyan","#E0FFFF","LightBlue","#ADD8E6","Lavender","#E6E6FA","Thistle","#D8BFD8","MistyRose","#FFE4E1","Peachpuff","#FFDAB9","PapayaWhip","#FFEFD5"];var colorlist=[{n:OxO6bdb[0],h:OxO6bdb[1]},{n:OxO6bdb[2],h:OxO6bdb[3]},{n:OxO6bdb[4],h:OxO6bdb[5]},{n:OxO6bdb[6],h:OxO6bdb[7]},{n:OxO6bdb[8],h:OxO6bdb[9]},{n:OxO6bdb[10],h:OxO6bdb[11]},{n:OxO6bdb[12],h:OxO6bdb[13]},{n:OxO6bdb[14],h:OxO6bdb[15]},{n:OxO6bdb[16],h:OxO6bdb[17]},{n:OxO6bdb[18],h:OxO6bdb[19]},{n:OxO6bdb[20],h:OxO6bdb[21]},{n:OxO6bdb[22],h:OxO6bdb[23]},{n:OxO6bdb[24],h:OxO6bdb[25]},{n:OxO6bdb[26],h:OxO6bdb[27]},{n:OxO6bdb[28],h:OxO6bdb[29]},{n:OxO6bdb[30],h:OxO6bdb[31]}];var colormore=[{n:OxO6bdb[32],h:OxO6bdb[33]},{n:OxO6bdb[34],h:OxO6bdb[35]},{n:OxO6bdb[36],h:OxO6bdb[37]},{n:OxO6bdb[38],h:OxO6bdb[39]},{n:OxO6bdb[40],h:OxO6bdb[41]},{n:OxO6bdb[42],h:OxO6bdb[43]},{n:OxO6bdb[44],h:OxO6bdb[45]},{n:OxO6bdb[46],h:OxO6bdb[47]},{n:OxO6bdb[48],h:OxO6bdb[49]},{n:OxO6bdb[50],h:OxO6bdb[51]},{n:OxO6bdb[52],h:OxO6bdb[53]},{n:OxO6bdb[54],h:OxO6bdb[55]},{n:OxO6bdb[56],h:OxO6bdb[57]},{n:OxO6bdb[58],h:OxO6bdb[59]},{n:OxO6bdb[60],h:OxO6bdb[61]},{n:OxO6bdb[62],h:OxO6bdb[63]},{n:OxO6bdb[64],h:OxO6bdb[65]},{n:OxO6bdb[66],h:OxO6bdb[67]},{n:OxO6bdb[68],h:OxO6bdb[69]},{n:OxO6bdb[70],h:OxO6bdb[71]},{n:OxO6bdb[72],h:OxO6bdb[73]},{n:OxO6bdb[74],h:OxO6bdb[75]},{n:OxO6bdb[76],h:OxO6bdb[77]},{n:OxO6bdb[78],h:OxO6bdb[79]},{n:OxO6bdb[80],h:OxO6bdb[81]},{n:OxO6bdb[82],h:OxO6bdb[83]},{n:OxO6bdb[84],h:OxO6bdb[85]},{n:OxO6bdb[86],h:OxO6bdb[87]},{n:OxO6bdb[88],h:OxO6bdb[89]},{n:OxO6bdb[90],h:OxO6bdb[91]},{n:OxO6bdb[92],h:OxO6bdb[93]},{n:OxO6bdb[94],h:OxO6bdb[95]},{n:OxO6bdb[96],h:OxO6bdb[97]},{n:OxO6bdb[98],h:OxO6bdb[99]},{n:OxO6bdb[100],h:OxO6bdb[101]},{n:OxO6bdb[102],h:OxO6bdb[103]},{n:OxO6bdb[104],h:OxO6bdb[105]},{n:OxO6bdb[106],h:OxO6bdb[107]},{n:OxO6bdb[108],h:OxO6bdb[109]},{n:OxO6bdb[110],h:OxO6bdb[111]},{n:OxO6bdb[112],h:OxO6bdb[113]},{n:OxO6bdb[114],h:OxO6bdb[115]},{n:OxO6bdb[116],h:OxO6bdb[117]},{n:OxO6bdb[118],h:OxO6bdb[119]},{n:OxO6bdb[120],h:OxO6bdb[121]},{n:OxO6bdb[122],h:OxO6bdb[123]},{n:OxO6bdb[124],h:OxO6bdb[125]},{n:OxO6bdb[126],h:OxO6bdb[127]},{n:OxO6bdb[128],h:OxO6bdb[129]},{n:OxO6bdb[130],h:OxO6bdb[131]},{n:OxO6bdb[132],h:OxO6bdb[133]},{n:OxO6bdb[134],h:OxO6bdb[135]},{n:OxO6bdb[136],h:OxO6bdb[137]},{n:OxO6bdb[138],h:OxO6bdb[139]},{n:OxO6bdb[140],h:OxO6bdb[141]},{n:OxO6bdb[142],h:OxO6bdb[143]},{n:OxO6bdb[144],h:OxO6bdb[145]},{n:OxO6bdb[146],h:OxO6bdb[147]},{n:OxO6bdb[148],h:OxO6bdb[149]},{n:OxO6bdb[150],h:OxO6bdb[151]},{n:OxO6bdb[152],h:OxO6bdb[153]},{n:OxO6bdb[154],h:OxO6bdb[155]},{n:OxO6bdb[156],h:OxO6bdb[157]},{n:OxO6bdb[158],h:OxO6bdb[159]},{n:OxO6bdb[160],h:OxO6bdb[161]},{n:OxO6bdb[162],h:OxO6bdb[163]},{n:OxO6bdb[164],h:OxO6bdb[165]},{n:OxO6bdb[166],h:OxO6bdb[167]},{n:OxO6bdb[168],h:OxO6bdb[169]},{n:OxO6bdb[170],h:OxO6bdb[171]},{n:OxO6bdb[172],h:OxO6bdb[173]},{n:OxO6bdb[174],h:OxO6bdb[175]},{n:OxO6bdb[176],h:OxO6bdb[177]},{n:OxO6bdb[178],h:OxO6bdb[179]},{n:OxO6bdb[180],h:OxO6bdb[181]},{n:OxO6bdb[182],h:OxO6bdb[183]},{n:OxO6bdb[184],h:OxO6bdb[185]},{n:OxO6bdb[186],h:OxO6bdb[187]},{n:OxO6bdb[188],h:OxO6bdb[189]},{n:OxO6bdb[190],h:OxO6bdb[191]},{n:OxO6bdb[192],h:OxO6bdb[193]},{n:OxO6bdb[194],h:OxO6bdb[195]},{n:OxO6bdb[196],h:OxO6bdb[197]},{n:OxO6bdb[198],h:OxO6bdb[199]},{n:OxO6bdb[200],h:OxO6bdb[201]},{n:OxO6bdb[202],h:OxO6bdb[203]},{n:OxO6bdb[204],h:OxO6bdb[205]},{n:OxO6bdb[206],h:OxO6bdb[207]},{n:OxO6bdb[208],h:OxO6bdb[209]},{n:OxO6bdb[210],h:OxO6bdb[211]},{n:OxO6bdb[212],h:OxO6bdb[213]},{n:OxO6bdb[214],h:OxO6bdb[215]},{n:OxO6bdb[216],h:OxO6bdb[217]},{n:OxO6bdb[218],h:OxO6bdb[219]},{n:OxO6bdb[220],h:OxO6bdb[221]},{n:OxO6bdb[156],h:OxO6bdb[157]},{n:OxO6bdb[222],h:OxO6bdb[223]},{n:OxO6bdb[224],h:OxO6bdb[225]},{n:OxO6bdb[226],h:OxO6bdb[227]},{n:OxO6bdb[228],h:OxO6bdb[229]},{n:OxO6bdb[230],h:OxO6bdb[231]},{n:OxO6bdb[232],h:OxO6bdb[233]},{n:OxO6bdb[234],h:OxO6bdb[235]},{n:OxO6bdb[236],h:OxO6bdb[237]},{n:OxO6bdb[238],h:OxO6bdb[239]},{n:OxO6bdb[240],h:OxO6bdb[241]},{n:OxO6bdb[242],h:OxO6bdb[243]},{n:OxO6bdb[244],h:OxO6bdb[245]},{n:OxO6bdb[246],h:OxO6bdb[247]},{n:OxO6bdb[248],h:OxO6bdb[249]},{n:OxO6bdb[250],h:OxO6bdb[251]},{n:OxO6bdb[252],h:OxO6bdb[253]},{n:OxO6bdb[254],h:OxO6bdb[255]},{n:OxO6bdb[256],h:OxO6bdb[257]},{n:OxO6bdb[258],h:OxO6bdb[259]},{n:OxO6bdb[260],h:OxO6bdb[261]},{n:OxO6bdb[262],h:OxO6bdb[263]},{n:OxO6bdb[264],h:OxO6bdb[265]},{n:OxO6bdb[266],h:OxO6bdb[267]},{n:OxO6bdb[268],h:OxO6bdb[269]},{n:OxO6bdb[270],h:OxO6bdb[271]},{n:OxO6bdb[272],h:OxO6bdb[273]}];
		
		</script>
	</head>
	<body>
		<div id="ajaxdiv">
			<div class="tab-pane-control tab-pane" id="tabPane1">
				<div class="tab-row">
					<h2 class="tab">
						<a tabindex="-1" href='colorpicker.aspx?<%=GetDialogQueryString%>'>
							<span style="white-space:nowrap;">
								[[WebPalette]]
							</span>
						</a>
					</h2>
					<h2 class="tab selected">
							<a tabindex="-1" href='colorpicker_basic.aspx?<%=GetDialogQueryString%>'>
								<span style="white-space:nowrap;">
									[[NamedColors]]
								</span>
							</a>
					</h2>
					<h2 class="tab">
							<a tabindex="-1" href='colorpicker_more.aspx?<%=GetDialogQueryString%>'>
								<span style="white-space:nowrap;">
									[[CustomColor]]
								</span>
							</a>
					</h2>
				</div>
				<div class="tab-page">			
					<table class="colortable" align="center">
						<tr>
							<td colspan="16" height="16"><p align="left">Basic:
								</p>
							</td>
						</tr>
						<tr>
							<script>
								var OxOb19d=["length","\x3Ctd class=\x27colorcell\x27\x3E\x3Cdiv class=\x27colordiv\x27 style=\x27background-color:","\x27 title=\x27"," ","\x27 cname=\x27","\x27 cvalue=\x27","\x27\x3E\x3C/div\x3E\x3C/td\x3E",""];var arr=[];for(var i=0;i<colorlist[OxOb19d[0]];i++){arr.push(OxOb19d[1]);arr.push(colorlist[i].n);arr.push(OxOb19d[2]);arr.push(colorlist[i].n);arr.push(OxOb19d[3]);arr.push(colorlist[i].h);arr.push(OxOb19d[4]);arr.push(colorlist[i].n);arr.push(OxOb19d[5]);arr.push(colorlist[i].h);arr.push(OxOb19d[6]);} ;document.write(arr.join(OxOb19d[7]));
							</script>
						</tr>
						<tr>
							<td colspan="16" height="12"><p align="left"></p>
							</td>
						</tr>
						<tr>
							<td colspan="16"><p align="left">Additional:
								</p>
							</td>
						</tr>
						<script>
							var OxO83a6=["length","\x3Ctr\x3E","\x3Ctd class=\x27colorcell\x27\x3E\x3Cdiv class=\x27colordiv\x27 style=\x27background-color:","\x27 title=\x27"," ","\x27 cname=\x27","\x27 cvalue=\x27","\x27\x3E\x3C/div\x3E\x3C/td\x3E","\x3C/tr\x3E",""];var arr=[];for(var i=0;i<colormore[OxO83a6[0]];i++){if(i%16==0){arr.push(OxO83a6[1]);} ;arr.push(OxO83a6[2]);arr.push(colormore[i].n);arr.push(OxO83a6[3]);arr.push(colormore[i].n);arr.push(OxO83a6[4]);arr.push(colormore[i].h);arr.push(OxO83a6[5]);arr.push(colormore[i].n);arr.push(OxO83a6[6]);arr.push(colormore[i].h);arr.push(OxO83a6[7]);if(i%16==15){arr.push(OxO83a6[8]);} ;} ;if(colormore%16>0){arr.push(OxO83a6[8]);} ;document.write(arr.join(OxO83a6[9]));
						</script>
						<tr>
							<td colspan="16" height="8">
							</td>
						</tr>
						<tr>
							<td colspan="16" height="12">
								<input checked id="CheckboxColorNames" style="width: 16px; height: 20px" type="checkbox">
								<span style="width: 118px;">Use color names</span>
							</td>
						</tr>
						<tr>
							<td colspan="16" height="12">
							</td>
						</tr>
						<tr>
							<td colspan="16" valign="middle" height="24">
							<span style="height:24px;width:50px;vertical-align:middle;">Color : </span>&nbsp;
							<input type="text" id="divpreview" size="7" maxlength="7" style="width:180px;height:24px;border:#a0a0a0 1px solid; Padding:4;"/>
					
							</td>
						</tr>
				</table>
			</div>
		</div>
		<div id="container-bottom">
			<input type="button" id="buttonok" value="[[OK]]" class="formbutton" style="width:70px"	onclick="do_insert();" /> 
			&nbsp;&nbsp;&nbsp;&nbsp; 
			<input type="button" id="buttoncancel" value="[[Cancel]]" class="formbutton" style="width:70px"	onclick="do_Close();" />	
		</div>
	</div>
	</body>
</html>

