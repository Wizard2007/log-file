unit uClearLog;

interface

uses
  Windows, SysUtils,Classes;

type
  TClearLog = class(TThread)
  private
    FClearDate: TDateTime;
    FPathToLogs: string;
    FFileExt: string;
    procedure SetClearDate(const Value: TDateTime);
    procedure SetFileExt(const Value: string);
    procedure SetPathToLogs(const Value: string);
    { Private declarations }
  protected
    procedure Execute; override;
  public
    property ClearDate: TDateTime read FClearDate write SetClearDate;
    property PathToLogs: string read FPathToLogs write SetPathToLogs;
    property FileExt: string read FFileExt write SetFileExt;
  end;

implementation
  uses uLogFile;
{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TCLearPosLog.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TCLearPosLog }

procedure TClearLog.Execute;
var
  srec: TSearchRec;
begin
  { Place thread code here }
//  dtmDatecs.LogFile.Add(llINFO, 'Начинаем подчищать логи в дирректории:'+PathToLogs);
  if FindFirst(PathToLogs+FileExt, faAnyFile, srec) = 0 then begin
    repeat
      Sleep(0);
      if FileDateToDateTime(srec.Time)<= ClearDate then begin
        Windows.DeleteFile(PChar(PathToLogs+srec.Name));
        Sleep(0);
      end;
    until FindNext(srec) <> 0;
    Sleep(0);
    FindClose(srec);
    Sleep(0);
  end;
  Terminate;
end;

procedure TClearLog.SetClearDate(const Value: TDateTime);
begin
  FClearDate := Value;
end;

procedure TClearLog.SetFileExt(const Value: string);
begin
  FFileExt := Value;
end;

procedure TClearLog.SetPathToLogs(const Value: string);
begin
  FPathToLogs := Value;
end;

end.
