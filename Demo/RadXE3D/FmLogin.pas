unit FmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uLogFile, ComCtrls, ActnList, FileCtrl, ExceptionLog,
  System.Actions;

type
  TfrmLogin = class(TForm)
    LogFile: TtLogFile;
    btnWriteToLog: TButton;
    edtLogText: TEdit;
    PageControl1: TPageControl;
    tsWriteString: TTabSheet;
    tsSettings: TTabSheet;
    tsWriteFrom: TTabSheet;
    grpWriteStringds: TGroupBox;
    grpWriteString: TGroupBox;
    mmWriteStrings: TMemo;
    Button1: TButton;
    lblFileName: TLabel;
    edtFileName: TEdit;
    cmbLogLevel: TComboBox;
    lblLogLevel: TLabel;
    cbActive: TCheckBox;
    cbKeepOpened: TCheckBox;
    cbAddDateTimeToLog: TCheckBox;
    lblFileExt: TLabel;
    edtFileExt: TEdit;
    lblFormatDateStr: TLabel;
    edtFormatDateStr: TEdit;
    lblFileDir: TLabel;
    edtFileDir: TEdit;
    btnSelectFileDir: TButton;
    ActionList1: TActionList;
    aSelectFileDir: TAction;
    lblFormatDateTimeToLog: TLabel;
    edtFormatDateTimeToLog: TEdit;
    cbAddMessageTypeToLog: TCheckBox;
    aWriteToLog: TAction;
    aWriteStrings: TAction;
    odWriteFromFile: TOpenDialog;
    lblWriteFromFile: TLabel;
    edtWriteFromFile: TEdit;
    btnSelectFileForWrite: TButton;
    aSelectFile: TAction;
    btnSelectFileForStream: TButton;
    edtWriteFromSream: TEdit;
    lblWriteFromSream: TLabel;
    aWriteFromSream: TAction;
    aWriteFile: TAction;
    btnWriteFile: TButton;
    aWriteStream: TAction;
    aSelectFileForStream: TAction;
    btnWriteStream: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aSelectFileDirExecute(Sender: TObject);
    procedure aWriteToLogExecute(Sender: TObject);
    procedure aWriteStringsExecute(Sender: TObject);
    procedure aSelectFileExecute(Sender: TObject);
    procedure aWriteFromSreamExecute(Sender: TObject);
    procedure aWriteFileExecute(Sender: TObject);
    procedure aSelectFileForStreamExecute(Sender: TObject);
    procedure aWriteStreamExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.aSelectFileExecute(Sender: TObject);
begin
  if odWriteFromFile.Execute then edtWriteFromFile.Text:= odWriteFromFile.FileName;
end;

procedure TfrmLogin.aSelectFileForStreamExecute(Sender: TObject);
begin
  if odWriteFromFile.Execute then edtWriteFromSream.Text:= odWriteFromFile.FileName;
end;

procedure TfrmLogin.aWriteFileExecute(Sender: TObject);
var
  lString: String;
begin
  lString:= edtFileName.Text;
  //LogFile.AddFile(llTRACE,edtWriteFromFile.Text);
  LogFile.AddFile(llTRACE,edtFileExt.Text);
end;

procedure TfrmLogin.aWriteFromSreamExecute(Sender: TObject);
var
  lFileStream: TFileStream;
begin
  if odWriteFromFile.Execute then begin
    lFileStream:= TFileStream.Create(odWriteFromFile.FileName, fmOpenRead);
    try
      LogFile.AddFromStream(llTRACE, lFileStream, 1024);
    finally
      lFileStream.Free;
    end;
    edtWriteFromSream.Text:= odWriteFromFile.FileName;
  end;
end;

procedure TfrmLogin.aWriteStreamExecute(Sender: TObject);
var
  lStream: TStream;
begin
  lStream:= TFileStream.Create(edtWriteFromSream.Text, fmOpenRead);
  LogFile.AddFromStream(llERROR, lStream, 1024);
  lStream.Free;
end;

procedure TfrmLogin.aWriteStringsExecute(Sender: TObject);
begin
  LogFile.AddStrings(llTRACE, mmWriteStrings.Lines);
end;

procedure TfrmLogin.aWriteToLogExecute(Sender: TObject);
begin
  LogFile.Add(llTRACE, edtLogText.Text);
end;

procedure TfrmLogin.aSelectFileDirExecute(Sender: TObject);
var lPath: String;
begin
  lPath:= ExtractFilePath(Application.ExeName);
  if SelectDirectory('', '', lPath, [sdNewFolder, sdShowEdit, sdShowShares,
    sdNewUI, sdShowFiles, sdValidateDir]) then
  begin
    edtFileDir.Text:= lPath;
  end;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LogFile.Add(llINFO, 'Finish Apllication');
  LogFile.Free;

end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
   LogFile.IniFileName:= ChangeFileExt(Application.ExeName, '.ini');
   LogFile.IniFileSectionName:='Log';
   LogFile.LoadFromIniFile;
   LogFile.Prepare;
   LogFile.Add(llINFO, 'Strat Apllication');

   cmbLogLevel.ItemIndex:= Integer(LogFile.LogLevel)-1;
   edtFileName.Text:= LogFile.FileName;
   cbActive.Checked:= LogFile.Active;
   cbKeepOpened.Checked:= LogFile.KeepOpened;
   edtFileExt.Text:= LogFile.FileExt;
   edtFormatDateStr.Text:= LogFile.FormatDateStr;
   edtFileDir.Text:= LogFile.FFileDirIniFile;
   edtFormatDateTimeToLog.Text:= LogFile.FormatDateTimeToLog;
   cbAddMessageTypeToLog.Checked:= LogFile.AddMessageTypeToLog;

end;

end.
