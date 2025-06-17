[Setup]
AppName=Hotel CRM
AppVersion=1.0.0
DefaultDirName={pf}\Hotel CRM
DefaultGroupName=Hotel CRM
OutputDir=dist\installer
OutputBaseFilename=HotelCRMInstaller
Compression=lzma
SolidCompression=yes
DisableProgramGroupPage=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64

[Files]
; Копируем всё из сборки Flutter Windows
Source: "build\windows\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs createallsubdirs ignoreversion

[Icons]
; Основной ярлык
Name: "{group}\Hotel CRM"; Filename: "{app}\hotel_crm_desktop.exe"
; Ярлык удаления
Name: "{group}\Удалить Hotel CRM"; Filename: "{uninstallexe}"
; Ярлык на рабочем столе
Name: "{commondesktop}\Hotel CRM"; Filename: "{app}\hotel_crm_desktop.exe"; Tasks: desktopicon

[Tasks]
; Установка ярлыка на рабочий стол
Name: "desktopicon"; Description: "Создать ярлык на рабочем столе"; GroupDescription: "Дополнительные значки:"
