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
PrivilegesRequired=admin

[Files]
; Копируем билд приложения
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs createallsubdirs ignoreversion

; Копируем установщик VC++ Redistributable (он должен быть скачан в корне проекта)
Source: "vc_redist.x64.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Run]
; Устанавливаем VC++ Redistributable в тихом режиме (если он не установлен)
Filename: "{tmp}\vc_redist.x64.exe"; Parameters: "/install /quiet /norestart"; StatusMsg: "Установка Visual C++ Redistributable..."; Flags: runhidden waituntilterminated

; Запуск установленного приложения (опционально)
; Filename: "{app}\hotel_crm_desktop.exe"; Flags: nowait postinstall skipifsilent

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
