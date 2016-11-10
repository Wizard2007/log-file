unit uLogFile;

interface

uses
  Windows, SysUtils, Classes, IniFiles, Forms, uClearLog, Dialogs;
{
������ ini-�����:
[Log]
; ������� ����������� �������� ���� ����� �������� ����� ��������
;  INFO  = 1 - information ;
;  ERROR = 2 - Errors;
;  TRACE = 3 - Debug;
LogLevel = 4
;������� �����
FileName = Log
; 1 - ������ � ��� ����, 0 - �� ������ � ��� ����
Active = 1
; 1 - ������� ���� ��������
KeepOpened = 1
; ��������� ����� ������ ������� � ���� ���� ���� � �����
AddDateTimeToLog = 1
; ���������� ����� ����
FileExt = .log
; ������ ���� ������� � ����� �����.
FormatDateStr = YYYYMMDD
;���� � ������ �����
; ����� Log � ���������� ������ ����������� ����
FileDir = .\Log
; ������ ���� ������� ������������ � ���
;dd/mm/yy hh:mm:ss = 09/02/49 01:02:03
;mmm = ���
;mmmm = �������
;ddd = ��
;dddd = �������
;ddddd = 09/02/2049
;dddddd = 09 ������� 2049
;hhampm = 01AM
;t = 01:02
;tt = 01:02:03
;dd/mm/yyyy = 09/02/2049
;dd/mm/yy hh:mm:ss = 09-02-49 01_02_03
;mmm = ���
;mmmm = �������
;ddd = ��
;dddd = �������
;ddddd = 09-���-49
;dddddd = ������� 09 ������� 1949
;hhampm = 01����
;t = 01_02_03
;tt = 01 _ 02 _ 03 . 004
;dd/mm/yyyy = 09-02-1949
FormatDateTimeToLog = dd/mm/yyyy hh:mm:ss
; true - ���������� � ���� ��� ���������, false - �� ����������
AddMessageTypeToLog = 1
;���������� ������� � �����������
DateTimeAndTextSeparatorLength = 0
;������ �����������
DateTimeAndTextSeparator=-
;������� ����� ���� �� ������������ ���� = 1 - ������� , 0 - �� �������.
isDeleteLogFiles = 1
;���������� ���� ������� ���� ������� ����� �����
StoreLogFileDays = 90
; 1 - ��������� ��������� �� ������ , 0 - �� ����������.
isShowMessageOnError = 0
}
{
Example ini-file:
[Log]
; Logging level uazyvaet message containing any type will be written
; INFO = 1 - information;
; ERROR = 2 - Errors;
; TRACE = 3 - Debug;
LogLevel = 4
; Name prefix
FileName = Log
; 1 - to write to log file 0 - do not write to log file
Active = 1
; Keep a file open
KeepOpened = 1
; Add to Kajo record to a log file date and time
AddDateTimeToLog = 1
; Expanding the log file
FileExt =.log
; Date format of time in the filename.
FormatDateStr = YYYYMMDD
; The path to the log
; folder Log at the current folder
FileDir = .\Log
; Date format of time in the log
;dd/mm/yy hh:mm:ss = 09/02/49 01:02:03
;mmm = Feb
;mmmm = February
;ddd = Th
;dddd = Thursday
;ddddd = 09/02/2049
;dddddd = 09 february 2049
;hhampm = 01AM
;t = 01:02
;tt = 01:02:03
FormatDateTimeToLog = dd/mm/yyyy hh:mm:ss
; true - write to log file message type, false - dont write
AddMessageTypeToLog = 1
;length of Separetor
DateTimeAndTextSeparatorLength = 0
;symbol of Separetor
DateTimeAndTextSeparator=-
;Delete Log Files after n days  = 1 - delete , 0 - not delete.
isDeleteLogFiles = 1
;number of days before delete log files
StoreLogFileDays = 90
; 1 - Show message on error? 0 - don't show
isShowMessageOnError = 0 }
const
//���� ���������, ������� ����� �������� � ���
//  LOG_LEVEL_NONE  = 0;
  cCopyRight = '*** Copyright (c) Eugene Tatarinov, 2010 - ...'+#10#13;
  c_DF_DateTimeSeparator = '$';
resourcestring
  infoAddToLogFile = '��������� � ��� ���� ������ �� ����� - ';
  infoAddFromStream = '��������� � ��� ���� ������ �� ������!';
  cErrorWhileOpenIniFile = '������ ��� �������� �����!!!'+#10#13;
  cErrorWhilePrepareFile = '������ ��� �������� �����!!!'+#10#13;
type
  TLogLevel = (llINFO, llERROR, llTRACE, llInfinity);
  TtLogFile = class(TComponent)
  private
    { Private declarations }
    FFile: TextFile;
    FCriticalSection: TRTLCriticalSection;
    FActive: boolean;
    FFileName: string;
    FFullName: string;
    FKeepOpened: boolean;
    FFileExt: String;
    FFormatDateStr: String;
    FIniFileName: string;
    FIniFileSectionName: string;
    FLogLevel: TLogLevel;
//    FLogLevleInterior: TLogLevel;
    FFileDir: string;
    FAddDateTimeToLog: boolean;
    FAddMessageTypeToLog: Boolean;
    FFormatDateTimeToLog: string;
    FDateTimeAndTextSeparator: String;
    FDateTimeAndTextSeparatorLength: Integer;
    FisDeleteLogFiles: Boolean;
    FStoreLogFileDays: Integer;
    FisShowMessageOnError: Boolean;
    FisFileAssigned: Boolean;
    procedure SetFileName(const Value: string);
    procedure SetKeepOpened(const Value: boolean);
    procedure SetFileExt(const Value: String);
    procedure SetFormatDateStr(const Value: String);
    procedure SetIniFileName(const Value: string);
    procedure SetIniFileSectionName(const Value: string);
    procedure SetLogLevel(const Value: TLogLevel);
    procedure SetFileDir(const Value: string);
    procedure SetAddDateTimeToLog(const Value: boolean);
    procedure SetAddMessageTypeToLog(const Value: Boolean);
    procedure SetFormatDateTimeToLog(const Value: string);
    function GetLogFileName: String;
    procedure SetDateTimeAndTextSeparator(const Value: String);
    procedure SetDateTimeAndTextSeparatorLength(const Value: Integer);
    procedure SetisDeleteLogFiles(const Value: Boolean);
    procedure SetStoreLogFileDays(const Value: Integer);
    procedure SetisShowMessageOnError(const Value: Boolean);
    procedure SetActive(const Value: boolean);
    procedure SetisFileAssigned(const Value: Boolean);
  protected
    { Protected declarations }
  public
    { Public declarations }
    {�����, � ������� ����� ��������� �����.}
    FthrdDeleteLogs: TClearLog;
    // ����������� ��� ini - �����
    FFileDirIniFile: string;
    // ��������� ���� / ������� � ������ - ��� ���� ��� �� �� ��������� ��� ������ ���
    FSeparator: string;
    // ������� ������������� ������ � ������� �����.
    function Prepare: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // ������� ��� ������ � ���� ����� ��������
    procedure Add(ALevel: TLogLevel; AText: string);
    // ������� ��� ������ � ���� ������ �� ������� ���������� �����.
    procedure AddFile(ALevel: TLogLevel; AFilePath: string);
    // ������� ��� ������ ��������� ����� � ��� ����
    procedure AddStrings(ALevel: TLogLevel; AStrings: TStrings);
    // ������� ��� ������ �� ������ � ��� ����
    procedure AddFromStream(ALevel: Tloglevel; AStream: TStream; ABufSize: Integer);
    // ������� � ��� ���������� ����� ����� � �����.
    procedure SaveToStream(AStream: TStream; const AFileName: string = '');
    // ������� ��� �������� ��������� ����������� �� �����.
    function LoadFromIniFile: Boolean;
    // ���������� ������� � �����������
    property DateTimeAndTextSeparatorLength: Integer read FDateTimeAndTextSeparatorLength
      write SetDateTimeAndTextSeparatorLength;
  published
    { Published declarations }
    //  true - ������ � ��� �������, false-��� ��������
    property Active: boolean read FActive write SetActive;
    //  ������� ����� ����� �����
    property FileName: string read FFileName write SetFileName;
    //  true - ���� �� ����������� ����� ������ ������
    property KeepOpened: boolean read FKeepOpened write SetKeepOpened;
    // ���� ��� ����� ��������� ����� �����
    property FileDir: string read FFileDir write SetFileDir;
    // ���������� ��� ����� �����
    property FileExt: String read FFileExt write SetFileExt;
    // ������ ���� � �������, ����������� � ���
    property FormatDateTimeToLog: string read FFormatDateTimeToLog write SetFormatDateTimeToLog;
    // ������ ���� �������, ����������� � ��� �����
    property FormatDateStr: String read FFormatDateStr write SetFormatDateStr;
    // true - ���������� � ���� ���� � �����, false - �� ����������
    property AddDateTimeToLog: boolean read FAddDateTimeToLog write SetAddDateTimeToLog;
    // true - ���������� � ���� ��� ���������, false - �� ����������
    property AddMessageTypeToLog: Boolean read FAddMessageTypeToLog write SetAddMessageTypeToLog;
    // ���� � ini - file , ��� ����� ��������� ��������� ��� ���� �����
    property IniFileName: string read FIniFileName write SetIniFileName;
    // �������� ������ � ini - file, �� ������� ��������� ����� �������� ��������� ��� �����������
    property IniFileSectionName: string read FIniFileSectionName write SetIniFileSectionName;
    {llINFO - ���������� � ��� �������������� ���������,
     llERROR - ���������� � ��� ��������� �� ������,
     llTRACE - ���������� � ��� ��������� ��� �����������}
    property LogLevel: TLogLevel read FLogLevel write SetLogLevel;
    // ������ �����������
    property DateTimeAndTextSeparator: String read FDateTimeAndTextSeparator write
      SetDateTimeAndTextSeparator;
      {������� ����� ���� �� ������������ ���� = 1 - ������� , 0 - �� �������.}
    property isDeleteLogFiles: Boolean read FisDeleteLogFiles write SetisDeleteLogFiles;
      {���������� ���� ������� ���� ������� ����� �����}
    property StoreLogFileDays: Integer read FStoreLogFileDays write SetStoreLogFileDays;
      {������� ����, ��� ���� ���������� ��������� ��� ������������� ������}
    property isShowMessageOnError: Boolean read FisShowMessageOnError write
      SetisShowMessageOnError;
      {������� ����, ��� ���� ��� ������ � ��� ��� ��� ������}
    property isFileAssigned: Boolean read FisFileAssigned
      write SetisFileAssigned;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TTComponets', [TtLogFile]);
end;

procedure TtLogFile.Add(ALevel: TLogLevel; AText: string);
const
  cErrorWhileAddLineToLogFile = '������ ��� ���������� ������ � ��� ���� :'+#10#13;
var
  fname, lMessage: string;
begin
  if not Active then exit;
  if ALevel > FLogLevel then exit;
  EnterCriticalSection(FCriticalSection);
  fname:= GetLogFileName;
  try
    try
      if not KeepOpened then
      begin
        AssignFile(FFile, fname);
        isFileAssigned:= True;
        if FileExists(fname) then
          Append(FFile)
        else
          Rewrite(FFile);
      end
      //���� ���� ������ ��������, �� ���� ����� ����, ���� ��� �����������
      else
        if fname <> FFullName then
        begin
          isFileAssigned:= False;
          CloseFile(FFile);
          FFullName:= fname;
          AssignFile(FFile, fname);
          isFileAssigned:= True;
          if FileExists(fname) then
            Append(FFile)
          else
            Rewrite(FFile);
        end;
      lMessage:= '';
      if AddDateTimeToLog then
        lMessage:= lMessage + FormatDateTime(FormatDateTimeToLog, Now)+
          DateTimeAndTextSeparator
      else
        if AddDateTimeToLog then
          lMessage:= lMessage + TimeToStr(Now)+' ';
      if AddMessageTypeToLog then
        case ALevel of
          llINFO:lMessage:= lMessage + 'I ';
          llERROR:lMessage:= lMessage + 'E ';
          llTRACE:lMessage:= lMessage + 'T ';
        end;
      lMessage:= lMessage + FSeparator +AText;
      writeln(FFile, lMessage);
      //  writeln(FFile, inttostr(GetCurrentThreadId) + ' - ' + AText);
      if not KeepOpened then
        CloseFile(FFile);
    Except on e: Exception do
      begin
        if isShowMessageOnError then        
          ShowMessage('# '+cErrorWhileAddLineToLogFile+FFullName+#10#13+
            AText+#10#13+e.Message);
      end;
    end;
  finally
    LeaveCriticalSection(FCriticalSection);
  end;
end;


procedure TtLogFile.AddFile(ALevel: TLogLevel; AFilePath: string);
var
  F: TextFile;
  lStr: string;
begin
  Add(ALevel, infoAddToLogFile+AFilePath);
  try
    AssignFile(F, AFilePath);
    Reset(F);
    while not EOF(F) do
    begin
      Readln( F, lStr);
      Add(ALevel, lStr);
    end;
  finally
    CloseFile(F);
  end;
end;

procedure TtLogFile.AddFromStream(ALevel: Tloglevel; AStream: TStream; ABufSize: Integer);
var
  lStr: String;
begin
  Add(ALevel, infoAddFromStream);
  AStream.Position:=0;
  SetLength(lStr, AStream.Size);
  AStream.ReadBuffer(lStr[1], AStream.Size);
  Add(ALevel, lStr);
end;

procedure TtLogFile.AddStrings(ALevel: TLogLevel; AStrings: TStrings);
var
  i: Integer;
begin
  for i := 0 to AStrings.Count - 1 do
    Add(ALevel, AStrings[i]);
end;

constructor TtLogFile.Create(AOwner: TComponent);
begin
  inherited;
  FisFileAssigned:= False;
  FthrdDeleteLogs:= TClearLog.Create(True);
  FthrdDeleteLogs.FreeOnTerminate:= True;
end;

destructor TtLogFile.Destroy;
begin
  if FthrdDeleteLogs <> nil then begin
    TerminateThread(FthrdDeleteLogs.Handle, 0);
    //FthrdDeleteLogs.Terminate;
    FthrdDeleteLogs:= nil;
  end;
  
  if KeepOpened then CloseFile(FFile);
  inherited;
end;

function TtLogFile.GetLogFileName: String;
var
  lSize: Cardinal;
  lComputerName: string;
begin
  lSize:= MAX_COMPUTERNAME_LENGTH + 1;
  setlength(lComputerName,20);
  GetComputerName(PChar(lComputerName), lSize);
  setlength(lComputerName,lSize);
  Result:= FileDir + FileName + FormatDateTime(FormatDateStr, Date)+'-'+
    lComputerName+'-'+ FileExt;
end;

function TtLogFile.LoadFromIniFile: Boolean;
var
  lApplicationName: string;
  lApplicationHandle: THandle;
  ini: TIniFile;
begin

  ini:= TIniFile.Create(IniFileName);
  try
    lApplicationHandle:= Application.Handle;
    lApplicationName:= Application.Name;
    try
      Result:= True;
      if IniFileName = '' then begin
        Result:= False;
        Exit
      end;
      LogLevel:= TLogLevel(ini.ReadInteger(IniFileSectionName, 'LogLevel', 0));
      FileName:= ini.ReadString(IniFileSectionName, 'FileName', 'Log');
      Active:= ini.ReadBool(IniFileSectionName, 'Active', false);
      FileDir:= ini.ReadString(IniFileSectionName, 'FileDir', ExtractFilePath(IniFileName));
      KeepOpened:= ini.ReadBool(IniFileSectionName, 'KeepOpened', true);
      AddDateTimeToLog:= ini.ReadBool(IniFileSectionName, 'AddDateTimeToLog', true);
      FileExt:= ini.ReadString(IniFileSectionName, 'FileExt', '.log');
      FormatDateStr:= ini.ReadString(IniFileSectionName, 'FormatDateStr', '_yyyy_MM_dd');
      FormatDateTimeToLog:= ini.ReadString(IniFileSectionName, 'FormatDateTimeToLog', '_yyyy_MM_dd');
      AddMessageTypeToLog:= ini.ReadBool(IniFileSectionName, 'AddMessageTypeToLog', true);
      DateTimeAndTextSeparatorLength:= ini.ReadInteger(IniFileSectionName, 'DateTimeAndTextSeparatorLength', 0);
      DateTimeAndTextSeparator:= ini.ReadString(IniFileSectionName, 'DateTimeAndTextSeparator', '-');
      isDeleteLogFiles:= ini.ReadBool(IniFileSectionName, 'isDeleteLogFiles', False);
      StoreLogFileDays:= ini.ReadInteger(IniFileSectionName, 'StoreLogFileDays', 90);
      isShowMessageOnError:= ini.ReadBool(IniFileSectionName, 'isShowMessageOnError', true);
    Except on e: Exception do
      begin
        Result:= False;
        MessageBox(lApplicationHandle, PChar(lApplicationName),
          PChar(cErrorWhileOpenIniFile+e.Message), MB_OK or MB_ICONERROR);
      end;
    end;
  finally
    ini.Free;
  end;
end;

function TtLogFile.Prepare: Boolean;
var
  lApplicationName: string;
  lApplicationHandle: THandle;
begin
  Result:= True;
  lApplicationHandle:= Application.Handle;
  lApplicationName:= Application.Name;
  try
    InitializeCriticalSection(FCriticalSection);
    FFullName:= GetLogFileName;                    
    //���� ���� ���� ������� � ������� ������, ������� ��� ������
    if KeepOpened then
    begin
      if isFileAssigned then begin
        isFileAssigned:= False;;
        Close(FFile);
      end;
      AssignFile(FFile, FFullName);
      isFileAssigned:= True;
      if FileExists(FFullName) then
        Append(FFile)
      else
        Rewrite(FFile);
    end;
    if isDeleteLogFiles then FthrdDeleteLogs.Resume;
  except on e: Exception do
    begin
      Result:= False;
      MessageBox(lApplicationHandle, PChar(lApplicationName),
        PChar(cErrorWhilePrepareFile+E.Message), MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TtLogFile.SaveToStream(AStream: TStream; const AFileName: string = '');
var
  fs: TFileStream;
begin
  if not Assigned(AStream) then exit;
  EnterCriticalSection(FCriticalSection);
  fs:= nil;
  try
    //�.�. �� ���������� ��������� ���� ������ ��� ������, ������� ���������
    //������������ �����
    if KeepOpened then CloseFile(FFile);
    if AFileName = '' then
      fs:= TFileStream.Create(FFullName, fmOpenRead or fmShareDenyNone)
    else
      fs:= TFileStream.Create(FileDir + AFileName, fmOpenRead or fmShareDenyNone);
    AStream.CopyFrom(fs, fs.Size);
  finally
    if Assigned(fs) then fs.Free;
    if KeepOpened then
      if FileExists(FFullName) then
        Append(FFile)
      else
        Rewrite(FFile);
    LeaveCriticalSection(FCriticalSection);
  end;
end;

procedure TtLogFile.SetActive(const Value: boolean);
begin
  if FActive <> Value then begin
    FActive := Value;
    if FActive then begin
      if FileDir <> '' then begin
        ForceDirectories(FileDir);
      end;
    end;
  end;
end;

procedure TtLogFile.SetAddDateTimeToLog(const Value: boolean);
begin
  FAddDateTimeToLog := Value;
end;

procedure TtLogFile.SetAddMessageTypeToLog(const Value: Boolean);
begin
  FAddMessageTypeToLog := Value;
end;

procedure TtLogFile.SetDateTimeAndTextSeparator(const Value: String);
var
  lChar: Char;
begin
  if FDateTimeAndTextSeparator <> Value then begin
    FDateTimeAndTextSeparator:= Value;
    if Length(DateTimeAndTextSeparator) <> 0 then
      lChar:= DateTimeAndTextSeparator[1]
    else lChar:= c_DF_DateTimeSeparator;
    FSeparator:= StringOfChar(lChar, DateTimeAndTextSeparatorLength);
  end;
end;

procedure TtLogFile.SetDateTimeAndTextSeparatorLength(const Value: Integer);
var
  lChar: Char;
begin
 if FDateTimeAndTextSeparatorLength <> Value then begin
   FDateTimeAndTextSeparatorLength:= Value;
   if Length(DateTimeAndTextSeparator) <> 0 then
     lChar:= DateTimeAndTextSeparator[1]
   else lChar:= c_DF_DateTimeSeparator;
   FSeparator:= StringOfChar(lChar, DateTimeAndTextSeparatorLength);
 end;
end;

procedure TtLogFile.SetFileDir(const Value: string);
begin
  FFileDir:= Value;
  if FFileDir <> '' then begin
    FFileDirIniFile:= FFileDir;
    if FFileDir[1] = '.' then begin
      Delete(FFileDir,1,1);
      Delete(FFileDir,1,1);
      FFileDir:= ExtractFilePath(Application.ExeName)+FFileDir;
    end;
    if Active then begin
      ForceDirectories(FFileDir);
    end;
    FFileDir := IncludeTrailingPathDelimiter(FFileDir);
    FthrdDeleteLogs.PathToLogs:= FFileDir;
  end;
end;

procedure TtLogFile.SetFileExt(const Value: String);
begin
  if FFileExt <> Value then begin
    FFileExt:= Value;
    FthrdDeleteLogs.FileExt:= '*'+FFileExt;
  end;
end;

procedure TtLogFile.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure TtLogFile.SetFormatDateStr(const Value: String);
begin
  FFormatDateStr := Value;
end;

procedure TtLogFile.SetFormatDateTimeToLog(const Value: string);
begin
  FFormatDateTimeToLog := Value;
end;  

procedure TtLogFile.SetIniFileName(const Value: string);
begin
  FIniFileName := Value;
end;

procedure TtLogFile.SetIniFileSectionName(const Value: string);
begin
  FIniFileSectionName := Value;
end;

procedure TtLogFile.SetisDeleteLogFiles(const Value: Boolean);
begin
  FisDeleteLogFiles := Value;
end;

procedure TtLogFile.SetisFileAssigned(const Value: Boolean);
begin
  FisFileAssigned := Value;
end;

procedure TtLogFile.SetisShowMessageOnError(const Value: Boolean);
begin
  FisShowMessageOnError := Value;
end;

procedure TtLogFile.SetKeepOpened(const Value: boolean);
begin
  FKeepOpened := Value;
end;

procedure TtLogFile.SetLogLevel(const Value: TLogLevel);
begin
  FLogLevel := Value;
end;

procedure TtLogFile.SetStoreLogFileDays(const Value: Integer);
begin
  if FStoreLogFileDays <> Value then begin
    FStoreLogFileDays:= Value;
    FthrdDeleteLogs.ClearDate:= Now()-FStoreLogFileDays;
  end;                                                  
end;

end.
