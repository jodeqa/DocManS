unit unDMSPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, AcroPDFLib_TLB, StdCtrls, FileCtrl, Buttons, ExtCtrls;

type
  TfrmDMSPrint = class(TForm)
    pnv: TPanel;
    lbi: TLabel;
    lbg: TLabel;
    lbcr: TLabel;
    btsrc: TSpeedButton;
    lbdp: TLabel;
    cbxg: TComboBox;
    edcr: TEdit;
    pna: TPanel;
    btx: TSpeedButton;
    flbx: TFileListBox;
    AcroPDF1: TAcroPDF;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edcrKeyPress(Sender: TObject; var Key: Char);
    procedure btsrcClick(Sender: TObject);
    procedure flbxClick(Sender: TObject);
    procedure btxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDMSPrint: TfrmDMSPrint;
  dmsFolder : String;
  docCount : Integer;
  svrLayOut, crowList : TStringList;

implementation

uses unDocManSData, GenericFP;

{$R *.dfm}

procedure TfrmDMSPrint.FormShow(Sender: TObject);
var svrData,svrFolder,svrBranch, usrName, usrSalt : String;
    isOK : Boolean;
    iTry, eco : integer;
begin
  svrBranch := getDBConfig(3);
  svrData := getDBConfig(5);
  svrFolder := getDBConfig(6);
  usrName := getDBConfig(8);
  usrSalt := getDBConfig(9);

  dmsFolder := '\\' + svrData + '\' + svrFolder;
  isOK := false;

  svrLayOut := TStringList.Create;
  svrLayOut := getLayOut(StrToInt(getDBConfig(1)));
  docCount := StrToInt(svrLayOut.Strings[8]);

  cbxg.Clear;
  for iTry := 3 to 6 do //isCOP, isBPK, isOLE, isInt
    begin
      if svrLayOut.Strings[iTry] <> '0'
         then cbxg.Items.Add((getGroup(iTry-2)).Strings[0]);
    end;
  cbxg.ItemIndex := 0;

  //if ConnectDrive('soffatfs01\orca','050508r4d4r',dms,'',eco)
  for iTry := 1 to 3 do
    begin
      if ConnectDrive(usrName,usrSalt,dmsFolder,'',eco) then
        begin
          isOK := true;
          break;
        end;
    end;

  if isOK then
    begin
    end
  else
    begin
      MessageDlg('folder penyimpanan DocManS tidak bisa diakses'+#13+'Hubungi IT untuk pemeriksaan lebih lanjut', mtError, [mbYes], 0);
      close;
    end;
end;

procedure TfrmDMSPrint.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  {};
end;

procedure TfrmDMSPrint.edcrKeyPress(Sender: TObject; var Key: Char);
begin
  if key = chr(VK_RETURN) then
    begin
      key := #0;
      flbx.Directory := dmsFolder + '\' + cbxg.Text;
      flbx.Mask := cbxg.Text + '-' + edcr.Text + '*.pdf';
      AcroPDF1.Visible := False;
    end;
end;

procedure TfrmDMSPrint.btsrcClick(Sender: TObject);
var key : char;
begin
  key := chr(VK_RETURN);
  edcrKeyPress(sender,key);
end;

procedure TfrmDMSPrint.flbxClick(Sender: TObject);
begin
  if FileExists(flbx.FileName) then
    begin
      //AcroPDF1.src := flbx.FileName;
      if MessageDlg('apakah hendak melihat file dulu ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          AcroPDF1.LoadFile(flbx.FileName);
          AcroPDF1.setView('fitbv');
          AcroPDF1.setShowScrollbars(False);
          AcroPDF1.setShowToolbar(False);
          AcroPDF1.Visible := True;
        end
      else btxClick(sender);
    end;

end;

procedure TfrmDMSPrint.btxClick(Sender: TObject);
begin
  close;
end;

end.
