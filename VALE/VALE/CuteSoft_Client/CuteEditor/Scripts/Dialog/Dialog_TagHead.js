var OxO557b=["top","opener","_dialog_arguments","document","dialogArguments","editor","window","element","changed","propertyName","value","checked","trim","prototype",""];function Window_GetDialogTop(Ox1a8){return Ox1a8[OxO557b[0]];} ;function Window_FindDialogArguments(Ox1a8){var Ox23c=Ox1a8[OxO557b[0]];try{var Ox23d=Ox23c[OxO557b[1]];if(Ox23d&&Ox23d[OxO557b[3]][OxO557b[2]]){return Ox23d[OxO557b[3]][OxO557b[2]];} ;} catch(x){} ;if(Ox23c[OxO557b[3]][OxO557b[2]]){return Ox23c[OxO557b[3]][OxO557b[2]];} ;if(Ox23c[OxO557b[4]]){return Ox23c[OxO557b[4]];} ;return Ox23c[OxO557b[3]][OxO557b[2]];} ;var arg=Window_FindDialogArguments(window);var editor=arg[OxO557b[5]];var editwin=arg[OxO557b[6]];var editdoc=arg[OxO557b[3]];var element=arg[OxO557b[7]];var syncingtoview=false;Window_GetDialogTop(window)[OxO557b[8]]=Window_GetDialogTop(window)[OxO557b[8]]||arg[OxO557b[8]];function OnPropertyChange(){if(syncingtoview){return ;} ;var Ox333=Event_GetEvent();if(Ox333[OxO557b[9]]!=OxO557b[10]&&Ox333[OxO557b[9]]!=OxO557b[11]){return ;} ;FireUIChanged();} ;function FireUIChanged(){Window_GetDialogTop(window)[OxO557b[8]]=true;SyncTo(element);UpdateState();} ;function SyncToViewInternal(){syncingtoview=true;try{SyncToView();UpdateState();} finally{syncingtoview=false;} ;} ;String[OxO557b[13]][OxO557b[12]]=function (){return this.replace(/(^\s*)|(\s*$)/g,OxO557b[14]);} ;function UpdateState(){} ;function SyncTo(element){} ;function SyncToView(){} ;