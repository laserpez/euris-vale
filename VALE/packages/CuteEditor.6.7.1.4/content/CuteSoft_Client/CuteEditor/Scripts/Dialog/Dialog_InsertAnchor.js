var OxOda9d=["nodeName","INPUT","TEXTAREA","BUTTON","IMG","SELECT","TABLE","position","style","absolute","relative","|H1|H2|H3|H4|H5|H6|P|PRE|LI|TD|DIV|BLOCKQUOTE|DT|DD|TABLE|HR|IMG|","|","body","document","allanchors","anchor_name","editor","window","name","value","[[ValidName]]","options","length","anchors","OPTION","text","#","images","className","cetempAnchor","anchorname","","--\x3E"," ","trim","prototype"];function Element_IsBlockControl(element){var name=element[OxOda9d[0]];if(name==OxOda9d[1]){return true;} ;if(name==OxOda9d[2]){return true;} ;if(name==OxOda9d[3]){return true;} ;if(name==OxOda9d[4]){return true;} ;if(name==OxOda9d[5]){return true;} ;if(name==OxOda9d[6]){return true;} ;var Ox126=element[OxOda9d[8]][OxOda9d[7]];if(Ox126==OxOda9d[9]||Ox126==OxOda9d[10]){return true;} ;return false;} ;function Element_CUtil_IsBlock(Ox36f){var Ox370=OxOda9d[11];return (Ox36f!=null)&&(Ox370.indexOf(OxOda9d[12]+Ox36f[OxOda9d[0]]+OxOda9d[12])!=-1);} ;function Window_SelectElement(Ox1a8,element){if(Browser_UseIESelection()){if(Element_IsBlockControl(element)){var Ox31=Ox1a8[OxOda9d[14]][OxOda9d[13]].createControlRange();Ox31.add(element);Ox31.select();} else {var Ox228=Ox1a8[OxOda9d[14]][OxOda9d[13]].createTextRange();Ox228.moveToElementText(element);Ox228.select();} ;} else {var Ox228=Ox1a8[OxOda9d[14]].createRange();try{Ox228.selectNode(element);} catch(x){Ox228.selectNodeContents(element);} ;var Ox136=Ox1a8.getSelection();Ox136.removeAllRanges();Ox136.addRange(Ox228);} ;} ;var allanchors=Window_GetElement(window,OxOda9d[15],true);var anchor_name=Window_GetElement(window,OxOda9d[16],true);var obj=Window_GetDialogArguments(window);var editor=obj[OxOda9d[17]];var editwin=obj[OxOda9d[18]];var editdoc=obj[OxOda9d[14]];var name=obj[OxOda9d[19]];function insert_link(){var Ox375=anchor_name[OxOda9d[20]];var Ox376=/[^a-z\d]/i;Ox375=Ox375.trim();if(Ox376.test(Ox375)){alert(OxOda9d[21]);} else {Window_SetDialogReturnValue(window,Ox375);Window_CloseDialog(window);} ;} ;function updateList(){while(allanchors[OxOda9d[22]][OxOda9d[23]]!=0){allanchors[OxOda9d[22]].remove(allanchors.options(0));} ;if(Browser_IsWinIE()){for(var i=0;i<editdoc[OxOda9d[24]][OxOda9d[23]];i++){var Ox378=document.createElement(OxOda9d[25]);Ox378[OxOda9d[26]]=OxOda9d[27]+editdoc[OxOda9d[24]][i][OxOda9d[19]];Ox378[OxOda9d[20]]=editdoc[OxOda9d[24]][i][OxOda9d[19]];allanchors[OxOda9d[22]].add(Ox378);} ;} else {var Ox379=editdoc[OxOda9d[28]];if(Ox379){for(var Ox25=0;Ox25<Ox379[OxOda9d[23]];Ox25++){var img=Ox379[Ox25];if(img[OxOda9d[29]]==OxOda9d[30]){var Ox378=document.createElement(OxOda9d[25]);Ox378[OxOda9d[26]]=OxOda9d[27]+img.getAttribute(OxOda9d[31]);Ox378[OxOda9d[20]]=img.getAttribute(OxOda9d[31]);allanchors[OxOda9d[22]].add(Ox378);} ;} ;} ;} ;} ;function selectAnchor(Ox37b){editor.FocusDocument();for(var i=0;i<editdoc[OxOda9d[24]][OxOda9d[23]];i++){if(editdoc[OxOda9d[24]][i][OxOda9d[19]]==Ox37b){anchor_name[OxOda9d[20]]=Ox37b;Window_SelectElement(editwin,editdoc[OxOda9d[24]][i]);} ;} ;} ;if(name&&name!=OxOda9d[32]){name=name.replace(/[\s]*<!--[\s\S]*?-->[\s]*/g,OxOda9d[32]);name=name.replace(OxOda9d[33],OxOda9d[34]);anchor_name[OxOda9d[20]]=name;} ;updateList();String[OxOda9d[36]][OxOda9d[35]]=function (){return this.replace(/^\s*/,OxOda9d[32]).replace(/\s*$/,OxOda9d[32]);} ;