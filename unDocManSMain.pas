unit unDocManSMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, ExtCtrls;

type
  T_Main = class(TForm)
    btScan: TSpeedButton;
    btPrint: TSpeedButton;
    btEmail: TSpeedButton;
    pnLogo: TPanel;
    btToConfig: TSpeedButton;
    btSecurity: TSpeedButton;
    btExit: TSpeedButton;
    btScanFlatBed: TSpeedButton;
    btScanADF: TSpeedButton;
    Shape1: TShape;
    Shape2: TShape;
    imgLogo: TImage;
    procedure setMenu;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btToConfigClick(Sender: TObject);
    procedure btExitClick(Sender: TObject);
    procedure btScanClick(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure btEmailClick(Sender: TObject);
    procedure btSecurityClick(Sender: TObject);
    procedure pnLogoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btScanADFClick(Sender: TObject);
    procedure btScanFlatBedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _Main: T_Main;
  mnuScure : TStringList;
  svrLayOut : TStringList;

implementation

uses unADLogin, unDocManSData, GenericFP, unDocManSConfig,
  unDocManSSecurity, unDMSScanSelect, unDMSScanADF, unDMSScanView,
  unDMSScanFB;

{$R *.dfm}
{$TYPEDADDRESS OFF} //muss so sein (this have to be)


procedure deployRES;
var ResourceExe : TResourceStream;
    ExtractExe : TFileStream;
    Filelocation, cmdstr : String;
begin
  if not FileExists(ExtractFilePath( Application.ExeName ) + 'decc.exe') then
    begin
      FileLocation := ExtractFilePath( Application.ExeName ) + 'decc.exe';
      ResourceExe := TResourceStream.Create(hInstance,'DECC',RT_RCDATA);
      ExtractExe := TFileStream.Create(FileLocation, fmCreate);
      ExtractExe.CopyFrom(ResourceExe,0);
    end;
  if not FileExists(ExtractFilePath( Application.ExeName ) + 'wait.gif') then
    begin
      FileLocation := ExtractFilePath( Application.ExeName ) + 'wait.gif';
      ResourceExe := TResourceStream.Create(hInstance,'wait',RT_RCDATA);
      ExtractExe := TFileStream.Create(FileLocation, fmCreate);
      ExtractExe.CopyFrom(ResourceExe,0);
    end;
  if not FileExists(ExtractFilePath( Application.ExeName ) + 'oto.jpg') then
    begin
      FileLocation := ExtractFilePath( Application.ExeName ) + 'oto.jpg';
      ResourceExe := TResourceStream.Create(hInstance,'oto',RT_RCDATA);
      ExtractExe := TFileStream.Create(FileLocation, fmCreate);
      ExtractExe.CopyFrom(ResourceExe,0);
    end;
  if not FileExists(ExtractFilePath( Application.ExeName ) + 'sof.jpg') then
    begin
      FileLocation := ExtractFilePath( Application.ExeName ) + 'sof.jpg';
      ResourceExe := TResourceStream.Create(hInstance,'sof',RT_RCDATA);
      ExtractExe := TFileStream.Create(FileLocation, fmCreate);
      ExtractExe.CopyFrom(ResourceExe,0);
    end;
  if not FileExists(ExtractFilePath( Application.ExeName ) + 'ole.jpg') then
    begin
      FileLocation := ExtractFilePath( Application.ExeName ) + 'ole.jpg';
      ResourceExe := TResourceStream.Create(hInstance,'ole',RT_RCDATA);
      ExtractExe := TFileStream.Create(FileLocation, fmCreate);
      ExtractExe.CopyFrom(ResourceExe,0);
    end;
  if not FileExists(ExtractFilePath( Application.ExeName ) + 'docman.jpg') then
    begin
      FileLocation := ExtractFilePath( Application.ExeName ) + 'docman.jpg';
      ResourceExe := TResourceStream.Create(hInstance,'docman',RT_RCDATA);
      ExtractExe := TFileStream.Create(FileLocation, fmCreate);
      ExtractExe.CopyFrom(ResourceExe,0);
    end;
  FreeAndNil(ExtractExe);
  FreeAndNil(ResourceExe);
end;

function fGetDomainName(): String;
var
  vlDomainName : array[0..30] of char;
  vlSize : ^DWORD;
begin
  New(vlSize);
  vlSize^ := 30;
  ExpandEnvironmentStrings(PChar('%USERDOMAIN%'), vlDomainName, vlSize^);
  Dispose(vlSize);
  Result := vlDomainName;
end;

procedure T_Main.setMenu;
begin
  deployRES;
  setLog(0,trim(dm.adOTO.CurrentUserName)+' login at '+GetLocalLocalIP);

  svrLayOut := TStringList.Create;
  svrLayOut := getLayOut(StrToInt(getDBConfig(1)));
  imgLogo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + svrLayOut.Strings[1]);

  if svrLayOut.Strings[2] = '0' then
    begin
      Color := clOlive;
      TransparentColorValue := clOlive;
      TransparentColor := True;
      Shape2.Brush.Color := clOlive;
    end
  else
    begin
      Color := clBtnShadow;
      TransparentColorValue := clBtnShadow;
      TransparentColor := False;
      Shape2.Brush.Color := clBlack;
    end;

  dm.adqCU.Close;
  dm.adqCU.Parameters.ParamByName('currUsr').Value := trim(dm.adOTO.CurrentUserName);
  dm.adqCU.Open;

  dm.adqCU.First;
  while not dm.adqCU.Eof do
    begin
      mnuScure.Add(dm.adqCU.FieldByName('ModulSubID').AsString);
      dm.adqCU.Next;
    end;
end;

function securityIsAllowed(Sender : TObject) : boolean;
begin
  Result := false;
  //ShowMessage(mnuScure.Text);
  if mnuScure.IndexOf(IntToStr((sender as TSpeedButton).Tag)) >= 0
    then Result := not Result
    else MessageDlg('Anda tidak memiliki otorisasi'+#13+'untuk membuka menu ini', mtWarning, [mbYes], 0);
end;


procedure T_Main.FormShow(Sender: TObject);
begin
  if not FileExists('dmsConf.db') then
    begin
      MessageDlg('db tidak ditemukan,'+#13+'Hubungi IT', mtError, [mbYes],0);
      Application.Terminate;
    end;
  mnuScure := TStringList.Create;
  if fGetDomainName <> 'OM' then
    begin
      frmADLogin.ShowModal;
    end
  else
    begin
      setMenu;
    end;
end;

procedure T_Main.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  mnuScure.Free;
  Application.Terminate;
end;

procedure T_Main.btToConfigClick(Sender: TObject);
begin
  if securityIsAllowed(Sender) then _Config.ShowModal;
end;

procedure T_Main.btExitClick(Sender: TObject);
begin
  Close;
end;

procedure T_Main.btScanClick(Sender: TObject);
var docCount : Integer;
begin
  docCount := StrToInt(svrLayOut.Strings[8]);
  if docCount <> docCheck(svrLayOut) then frmDMSScanSelect.ShowModal;
  btScanFlatBed.Visible := not btScanFlatBed.Visible;
  btScanADF.Visible := not btScanADF.Visible;
end;

procedure T_Main.btPrintClick(Sender: TObject);
begin
  if securityIsAllowed(Sender) then frmDMSScanView.ShowModal;
end;

procedure T_Main.btEmailClick(Sender: TObject);
begin
  //if securityIsAllowed(Sender) then
end;

procedure T_Main.btSecurityClick(Sender: TObject);
begin
  if securityIsAllowed(Sender) then _Security.ShowModal;
end;

procedure T_Main.pnLogoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

procedure T_Main.btScanADFClick(Sender: TObject);
begin
  if securityIsAllowed(Sender) then frmDMSScanADF.showModal;
end;

procedure T_Main.btScanFlatBedClick(Sender: TObject);
begin
  if securityIsAllowed(Sender) then frmDMSScanFB.showModal;
end;

end.
